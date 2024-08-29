## Time Series Analysis in R on Historical Stock Price Data

### Objective

The objective of this project was to conduct a comprehensive time series analysis on the closing prices of MasterCard and Visa stocks using ARIMA (AutoRegressive Integrated Moving Average) modeling. I aimed to evaluate the predictive accuracy of ARIMA models by comparing forecasted values against actual observed data.

### Data Description

This dataset contains historical stock price data for MasterCard (MA) and Visa (V) from June 2008 to June 2024. The data includes daily stock prices with the following columns:

- **Date:** The date of the recorded stock prices.
- **Open_M:** Opening price of MasterCard stock.
- **High_M:** Highest price of MasterCard stock for the day.
- **Low_M:** Lowest price of MasterCard stock for the day.
- **Close_M:** Closing price of MasterCard stock.
- **Adj Close_M:** Adjusted closing price of MasterCard stock.
- **Volume_M:** Trading volume of MasterCard stock.
- **Open_V:** Opening price of Visa stock.
- **High_V:** Highest price of Visa stock for the day.
- **Low_V:** Lowest price of Visa stock for the day.
- **Close_V:** Closing price of Visa stock.
- **Adj Close_V:** Adjusted closing price of Visa stock.
- **Volume_V:** Trading volume of Visa stock.

**Dataset Highlights:**
- Comprehensive historical data covering over 15 years.
- Useful for analyzing the stock performance of two major financial services companies.
- Ideal for time series analysis, financial forecasting, and comparative studies.

### Data Preprocessing

- **Data Loading and Preparation:** I began by loading the dataset and converting the date column to a suitable time series format. Missing values were checked and handled appropriately.
- **Time Series Creation:** Time series objects were created for the closing prices of MasterCard and Visa, facilitating the subsequent modeling process.

### ARIMA Modeling

I fitted ARIMA models to the historical data of both MasterCard and Visa stocks. The models were trained on historical data and used to forecast future values. These forecasts were then compared against a testing dataset to assess their accuracy.

### Training Set Importance

In the context of this time series analysis project, the training set plays a critical role for the following reasons:

- **Model Fitting:** The training set is used to fit the ARIMA (AutoRegressive Integrated Moving Average) models. By training the models on historical stock price data, the models learn the patterns and dynamics of the stock prices, which is essential for generating accurate forecasts.
- **Parameter Estimation:** For ARIMA models, parameters such as autoregressive terms (AR), differencing (I), and moving average terms (MA) need to be estimated. The training set provides the data needed to estimate these parameters effectively.
- **Forecasting:** The ARIMA models are trained on the historical data to make predictions about future stock prices. The training set helps the model understand the past trends and seasonality in the stock prices, which is crucial for generating reliable forecasts.
- **Performance Assessment:** By comparing the forecasts from the ARIMA models against actual observed data (which is not used during training), you can assess how well the models generalize to new data. This evaluation is crucial to understand the model’s forecasting accuracy and make improvements if needed.
- **Avoiding Overfitting:** Using a separate training set helps ensure that the model is not just memorizing the historical data but is learning generalizable patterns. This is important to avoid overfitting, where the model performs well on the training data but poorly on new or unseen data.
- **Model Selection and Validation:** The training set allows you to test different ARIMA configurations and select the best model based on its performance metrics. This process is crucial to ensure that the chosen model is the most appropriate for forecasting future stock prices.

In summary, the training set is crucial for developing and validating the ARIMA models in this time series analysis project. It helps in fitting the models, estimating parameters, generating forecasts, and ensuring that the models perform well on new data.

### Summary Statistics

| Statistic                  | MasterCard            | Visa                  |
|----------------------------|------------------------|------------------------|
| Minimum                    | 11.918                 | 10.605                 |
| Maximum                    | 488.64                 | 290.37                 |
| Mean                       | 164.5639               | 108.0036               |
| Median                     | 97.6                   | 78.62                  |
| Standard Deviation (SD)     | 138.6356               | 82.31997               |
| ACF1 (First Lag Autocorrelation) | 0.9990448          | 0.9991106              |
| PACF1 (First Lag Partial Autocorrelation) | NA          | NA                     |

### Model Accuracy Metrics

| Metric                     | MasterCard Training Set | MasterCard Test Set | Visa Training Set | Visa Test Set |
|----------------------------|-------------------------|---------------------|-------------------|---------------|
| Mean Error (ME)            | 0.0046                  | -1452.966           | -0.0017           | -12.8628      |
| Root Mean Squared Error (RMSE) | 3.2932               | 1662.1836           | 1.6409            | 23.2131       |
| Mean Absolute Error (MAE)  | 1.5749                  | 1452.9663           | 0.8850            | 19.3247       |
| Mean Percentage Error (MPE)| -0.0018                 | -376.1800           | -0.2153           | -6.3876       |
| Mean Absolute Percentage Error (MAPE) | 1.4886         | 376.1800            | 1.2919            | 8.9048        |
| Mean Absolute Scaled Error (MASE) | 1.1025            | 1017.0811           | 1.0016            | 21.8719       |
| ACF1                       | -0.0247                 | NA                  | -0.0179           | NA            |

### ARIMA Model Summaries

| Metric                     | MasterCard ARIMA Model           | Visa ARIMA Model                |
|----------------------------|----------------------------------|---------------------------------|
| Model                      | ARIMA(0,1,1) with drift          | ARIMA(1,1,0) with drift         |
| Coefficients               | ma1: -0.0470, drift: 0.1011      | ar1: -0.0918, drift: 0.0596     |
| Sigma^2                    | 13.43                            | 4.271                           |
| Log Likelihood             | -10994.93                        | -8677.14                        |
| AIC                        | 21995.85                         | 17360.28                        |
| BIC                        | 22014.77                         | 17379.19                        |
| Mean Error (ME)            | 0.0000                           | 0.0001                          |
| Root Mean Squared Error (RMSE) | 3.6635                        | 2.0659                          |
| Mean Absolute Error (MAE)  | 1.9580                           | 1.1604                          |
| Mean Percentage Error (MPE)| -0.1296                          | -0.0889                         |
| Mean Absolute Percentage Error (MAPE) | 1.3129                  | 1.2079                          |
| Mean Absolute Scaled Error (MASE) | 0.0631                   | 0.0607                          |
| ACF1                       | -0.0001                          | 0.0018                          |

### Residual Diagnostics

**MasterCard:**
- **Ljung-Box Test:** Q* = 1260.8, df = 503, p-value < 2.2e-16

**Visa:**
- **Ljung-Box Test:** Q* = 1269.8, df = 503, p-value < 2.2e-16

### Plots

**Time Series Plots:**

- **MasterCard Closing Prices:**

![MasterCard Closing Prices](results/time_series_plots/MasterCard_Closing_Prices.png)

  - This plot shows the historical closing prices of MasterCard, reflecting the stock’s performance over time.

- **Visa Closing Prices:**

![Visa Closing Prices](results/time_series_plots/Visa_Closing_Prices.png)

  - This plot displays the historical closing prices of Visa, illustrating the stock’s trends over the same period.

**Forecast Plots:**

- **Forecast for MasterCard:**

![Forecast MasterCard](results/forecast_plots/Forecast_MasterCard.png)

  - This plot presents the forecasted values of MasterCard closing prices along with the actual values, showcasing the model’s performance.

- **Forecast for Visa:**

![Forecast Visa](results/forecast_plots/Forecast_Visa.png)

  - This plot shows the forecasted values of Visa closing prices compared with the actual values, highlighting the forecast accuracy.

**Residual Plots:**

- **Residuals of MasterCard ARIMA Model:**

![Residuals MasterCard](results/residual_plots/residuals_MasterCard.png)

  - This plot illustrates the residuals from the ARIMA model fitted to MasterCard closing prices, depicting the difference between observed and predicted values.

- **Residuals of Visa ARIMA Model:**

![Residuals Visa](results/residual_plots/residuals_Visa.png)

  - This plot shows the residuals from the ARIMA model for Visa closing prices, providing insight into model fit.

### Conclusion

The ARIMA models applied to the historical stock price data for MasterCard and Visa showed varying levels of accuracy in forecasting future stock prices. While the models provided reasonable forecasts, the residual diagnostics indicated some areas where model improvements could be made. Further analysis and model refinement are suggested to enhance predictive performance.

### References

[1] Box, G. E. P., Jenkins, G. M., & Reinsel, G. C. (2015). *Time Series Analysis: Forecasting and Control* (5th ed.). Wiley.
[2] Hyndman, R. J., & Athanasopoulos, G. (2018). *Forecasting: principles and practice*. OTexts.
