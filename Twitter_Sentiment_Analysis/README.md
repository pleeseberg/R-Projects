# Sentiment Analysis and Time Series Visualization

Welcome to the **Sentiment Analysis and Time Series Visualization** project. This project focuses on analyzing sentiment from tweets related to Amazon and visualizing these sentiments over time.

## Project Overview

### 1. **Sentiment Analysis**

This component processes tweets to determine their sentiment using the NRC Sentiment Lexicon. It involves:

- **Data Collection:** Gathering tweets related to Amazon.
- **Text Processing:** Cleaning the text by removing punctuation, numbers, and single-letter words.
- **Sentiment Analysis:** Computing and aggregating sentiment scores by date.

### 2. **Time Series Visualization**

This component visualizes sentiment scores over time to identify trends and patterns. It includes:

- **Timeline Plot:** Displays the overall trend of sentiment scores.
- **Facet Plots:** Shows individual plots for each sentiment category.

## Files and Resources

Here is a list of files included in the project directory:

- **`AMZN-tweets.csv`**: Raw tweet data for sentiment analysis.
- **`sentiment_analysis_data.csv`**: Aggregated sentiment scores by date.
- **`sentiment_analysis_output.csv`**: Processed sentiment analysis results.
- **`Time_Series_Plot.R`**: R script for generating time series plots.
- **`Twitter_Sentiment_Analysis.R`**: R script for data processing and sentiment analysis.
- **`sentiment_barchart.png`**: PNG file of the sentiment barchart.
- **`sentiment_time_series_combined.png`**: PNG file of the combined time series plot.
- **`wordcloud.png`**: PNG file of the word cloud from unigrams.

## Setup Instructions

### Required Packages

Ensure you have the following R packages installed:

```r
install.packages(c('tidyverse', 'ggplot2', 'patchwork', 'syuzhet', 'wordcloud', 'tm', 'RColorBrewer', 'lubridate'))
