# Install and load required packages
if(!require(tidyverse)) install.packages('tidyverse', dependencies=TRUE)
if(!require(syuzhet)) install.packages('syuzhet', dependencies=TRUE)
if(!require(wordcloud)) install.packages('wordcloud', dependencies=TRUE)
if(!require(tm)) install.packages('tm', dependencies=TRUE)
if(!require(RColorBrewer)) install.packages('RColorBrewer', dependencies=TRUE)
if(!require(ggplot2)) install.packages('ggplot2', dependencies=TRUE)
if(!require(lubridate)) install.packages('lubridate', dependencies=TRUE)
if(!require(tidytext)) install.packages('tidytext', dependencies=TRUE)

library(tidyverse)
library(syuzhet)
library(wordcloud)
library(tm)
library(RColorBrewer)
library(ggplot2)
library(lubridate)
library(tidytext)

# Set the working directory to the location of the project
setwd("/Users/paigeleeseberg/Downloads/R-Projects/Twitter_Sentiment_Analysis")

# Load the dataset
textDataAll <- read.csv("data/AMZN-tweets.csv")

# Examine the structure of the dataset
str(textDataAll)

# Format the datetime column to UTC and then convert to EST
textDataAll$datetime <- as.POSIXct(strptime(textDataAll$datetime, format="%Y-%m-%d %H:%M:%S"), tz="UTC")
textDataAll$datetime <- format(textDataAll$datetime, tz="America/New_York")

# Extract the date
textDataAll$date <- as.Date(textDataAll$datetime)

# Additional text cleaning
text_clean <- textDataAll$text %>%
  tolower() %>%
  removePunctuation() %>%
  removeNumbers() %>%
  removeWords(stopwords("en")) %>%
  removeWords(c("amzn", "tsla", "aapl", "nflx", "googl", "spy", "qqq", "fb", "nvda", "msft", "stocks", "stock", "amd", "goog", "spx", "gme", "twtr", "baba", "ba", "nio", "btc", "c", "dis")) %>%
  str_replace_all("\\$[A-Za-z]+", "") %>%
  str_replace_all("#[A-Za-z]+", "") %>%
  str_replace_all("[^[:alpha:][:space:]]", "") %>%
  stripWhitespace()

# Remove single-letter words
text_clean <- text_clean %>%
  str_split(pattern = "\\s+") %>%
  map(~ .[nchar(.) > 1]) %>%
  map(~ paste(., collapse = " ")) %>%
  unlist()

# Re-add the cleaned text to the dataframe
textDataAll$text_clean <- text_clean

# Print a few cleaned texts to verify
print(head(textDataAll$text_clean, n = 5))

# Text Analysis: Tokenization and N-grams
# Unigrams
unigrams <- textDataAll %>%
  unnest_tokens(word, text_clean)

unigrams_count <- unigrams %>%
  count(word, sort=TRUE)

# Bigrams
bigrams <- textDataAll %>%
  unnest_tokens(bigram, text_clean, token = "ngrams", n = 2)

bigrams_count <- bigrams %>%
  count(bigram, sort=TRUE)

# Trigrams
trigrams <- textDataAll %>%
  unnest_tokens(trigram, text_clean, token = "ngrams", n = 3)

trigrams_count <- trigrams %>%
  count(trigram, sort=TRUE)

# Print the top 10 words
top_10_words <- unigrams_count %>%
  top_n(10, n) %>%
  arrange(desc(n))

print(top_10_words)

# Generate and save the word cloud for unigrams
png(filename = "results/wordcloud.png", width = 800, height = 600)
wordcloud(words = unigrams_count$word, freq = unigrams_count$n, 
          min.freq = 1, max.words = 200, random.order = FALSE, rot.per = 0.35, 
          colors = brewer.pal(8, "Dark2"))
dev.off()

# Sentiment Analysis using NRC Sentiment Lexicon
sentiment_nrc <- get_nrc_sentiment(textDataAll$text_clean)

# Add an ID column to match the original data
sentiment_nrc$id <- seq.int(nrow(sentiment_nrc))

# Join the sentiment data with the original data
sentiment_join <- textDataAll %>%
  mutate(id = row_number()) %>%
  left_join(sentiment_nrc, by="id")

# Examine the first few rows of the joined sentiment data
head(sentiment_join)

# Save the cleaned text and sentiment data to a CSV file
write.csv(sentiment_join, "data/sentiment_analysis_data.csv", row.names = FALSE)

# Create sentiment bar chart data
sentiment_summary <- sentiment_nrc %>%
  summarise(across(everything(), sum, na.rm = TRUE)) %>%
  pivot_longer(cols = everything(), names_to = "nrc", values_to = "n")

# Filter to include specified emotions
specified_emotions <- c("anger", "anticipation", "disgust", "fear", "joy", "negative", "positive", "sadness", "surprise", "trust")
sentiment_summary <- sentiment_summary %>%
  filter(nrc %in% specified_emotions)

# Generate and save the sentiment bar chart with updated legend color and white background
sentimentBarchart <- sentiment_summary %>%
  ggplot(aes(x = nrc, y = n, fill = nrc)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  theme_minimal(base_size = 15) + 
  theme(
    axis.text.x = element_text(angle = 25, vjust = 1.0, hjust = 1.0),
    legend.position = "bottom",
    legend.title = element_text(color = "black"),
    legend.text = element_text(color = "black"),
    panel.background = element_rect(fill = "white", color = "black"),
    plot.background = element_rect(fill = "white"),
    legend.background = element_rect(fill = "white")
  ) + 
  labs(title = "NRC Sentiment Comparison", y = "Total Sentiment", x = "Emotion") + 
  scale_fill_discrete(name = "Rating")

# Save the plot
ggsave(filename = "results/sentiment_barchart.png", plot = sentimentBarchart, width = 10, height = 6)
