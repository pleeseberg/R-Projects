# Sentiment Analysis and Time Series Visualization

Welcome to the **Sentiment Analysis and Time Series Visualization** project. This project focuses on analyzing sentiment from tweets related to Amazon and visualizing these sentiments over time.

## Project Overview

### 1. Sentiment Analysis

This component processes tweets to determine their sentiment using the NRC Sentiment Lexicon. The process involves:

- **Data Collection:** Gathering tweets related to Amazon.
- **Text Processing:** Cleaning the text by removing punctuation, numbers, and single-letter words.
- **Sentiment Analysis:** Computing and aggregating sentiment scores by date to analyze sentiment trends.

### 2. Time Series Visualization

This component visualizes sentiment scores over time to identify trends and patterns. It includes:

- **Timeline Plot:** Displays the overall trend of sentiment scores.
- **Facet Plots:** Provides individual plots for each sentiment category to offer a detailed view of sentiment changes.

## Files and Resources

The project directory includes the following files:

- **`AMZN-tweets.csv`**: Raw tweet data used for sentiment analysis.
- **`sentiment_analysis_data.csv`**: Aggregated sentiment scores by date.
- **`sentiment_analysis_output.csv`**: Results of the processed sentiment analysis.
- **`Time_Series_Plot.R`**: R script for generating time series plots.
- **`Twitter_Sentiment_Analysis.R`**: R script for processing data and performing sentiment analysis.
- **`sentiment_barchart.png`**: PNG file showing the sentiment barchart.
- **`sentiment_time_series_combined.png`**: PNG file of the combined time series plot.
- **`wordcloud.png`**: PNG file of the word cloud from unigrams.

## Top Ten Words

The most frequent words in the tweet data are listed below. These words provide insight into common themes and topics discussed in the tweets:

1. **word1**
2. **word2**
3. **word3**
4. **word4**
5. **word5**
6. **word6**
7. **word7**
8. **word8**
9. **word9**
10. **word10**

*Note: Replace "word1", "word2", etc., with actual top ten words derived from your analysis.*

## Setup Instructions

### Required Packages

Ensure you have the following R packages installed:

```r
install.packages(c('tidyverse', 'ggplot2', 'patchwork', 'syuzhet', 'wordcloud', 'tm', 'RColorBrewer', 'lubridate'))
