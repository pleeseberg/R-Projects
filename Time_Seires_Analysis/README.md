## Stock Prices

### Objective

The objective of this project was to conduct a comprehensive time series analysis on the closing prices of MasterCard and Visa stocks using ARIMA (AutoRegressive Integrated Moving Average) modeling. We aimed to evaluate the predictive accuracy of ARIMA models by comparing forecasted values against actual observed data.

### Data Preprocessing

- **Data Loading and Preparation:** We began by loading the dataset and converting the date column to a suitable time series format. Missing values were checked and handled appropriately.
- **Time Series Creation:** Time series objects were created for the closing prices of MasterCard and Visa, facilitating the subsequent modeling process.

### ARIMA Modeling

We fitted ARIMA models to the historical data of both MasterCard and Visa stocks. The models were trained on historical data and used to forecast future values. These forecasts were then compared against a testing dataset to assess their accuracy.

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

### Conclusion

The ARIMA models offered a structured approach to forecasting stock prices. The models showed reasonable performance on the training data but revealed significant forecast errors on the test data for both MasterCard and Visa. For MasterCard, the forecast indicated large errors in the test set, while Visa exhibited more stable predictions but with notable forecast errors. The residual diagnostics confirmed that both models had residuals significantly autocorrelated, suggesting that there is room for improvement in the models.

Overall, while the ARIMA models provide valuable insights and forecasts, additional analysis and market considerations are necessary for informed investment decisions.
