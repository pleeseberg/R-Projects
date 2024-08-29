# Load necessary libraries
print("Loading necessary libraries...")
suppressMessages({
  library(forecast)
  library(readr)
  library(tseries)
  library(ggplot2)  # For residual plots and visualization
  library(dplyr)    # For data manipulation
})

# Set the working directory to the project directory
setwd("/Users/paigeleeseberg/Downloads/R-Projects/Time_Seires_Analysis")

# Define file paths
data_path <- "data/MVR.csv"  # Path to the dataset
results_path <- "results/forecast_results.csv"  # Path to save forecast results
residuals_path <- "results/residuals_data.csv"  # Path to save residuals data
residual_plots_path <- "results/residual_plots"  # Directory to save residual plots
time_series_plots_path <- "results/time_series_plots"  # Directory to save time series plots
forecast_plots_path <- "results/forecast_plots"  # Directory to save forecast plots

# Create directories if they don't exist
dir.create(residual_plots_path, showWarnings = FALSE)
dir.create(time_series_plots_path, showWarnings = FALSE)
dir.create(forecast_plots_path, showWarnings = FALSE)

# Load the dataset with error handling
print("Loading the dataset...")
tryCatch({
  data <- read_csv(data_path)
  print("Dataset loaded successfully!")
}, error = function(e) {
  print("Error loading dataset!")
  print(e)
  stop("Stopping script due to error.")
})

# Convert the Date column to Date type with error handling
print("Converting the Date column to Date type...")
tryCatch({
  data$Date <- as.Date(data$Date, format="%Y-%m-%d")
  print("Date conversion completed!")
}, error = function(e) {
  print("Error converting Date column!")
  print(e)
  stop("Stopping script due to error.")
})

# Check for missing values
print("Checking for missing values...")
missing_values <- sum(is.na(data))
if (missing_values > 0) {
  print(paste("Warning: There are", missing_values, "missing values in the dataset."))
} else {
  print("No missing values found in the dataset.")
}

# Print column names to identify the correct names
print("Column names in the dataset:")
print(colnames(data))

# Create time series objects for closing prices
print("Creating time series objects for closing prices...")
ts_MasterCard <- ts(data$`Close_M`, start = c(2008, 6), frequency = 252)
ts_Visa <- ts(data$`Close_V`, start = c(2008, 6), frequency = 252)
print("Time series objects created!")

# Split data into training and testing sets
print("Splitting data into training and testing sets...")
train_size <- floor(0.8 * length(ts_MasterCard))
train_MasterCard <- ts_MasterCard[1:train_size]
test_MasterCard <- ts_MasterCard[(train_size + 1):length(ts_MasterCard)]
train_Visa <- ts_Visa[1:train_size]
test_Visa <- ts_Visa[(train_size + 1):length(ts_Visa)]

# Refit ARIMA models on training data
print("Fitting ARIMA model on training data...")
fit_MasterCard_train <- auto.arima(train_MasterCard)
fit_Visa_train <- auto.arima(train_Visa)

# Forecast on testing data
print("Generating forecasts...")
forecast_MasterCard_test <- forecast(fit_MasterCard_train, h=length(test_MasterCard))
forecast_Visa_test <- forecast(fit_Visa_train, h=length(test_Visa))

# Save forecast plots
print("Saving forecast plots...")

# Forecast vs Actual for MasterCard
png(file.path(forecast_plots_path, "Forecast_vs_Actual_MasterCard.png"))
plot(ts_MasterCard, main="MasterCard Forecast vs Actual", ylab="Price (USD)", xlab="Time", col="blue", lty=1)
lines(forecast_MasterCard_test$mean, col="red", lty=2)
legend("topright", legend=c("Actual", "Forecast"), col=c("blue", "red"), lty=c(1, 2))
dev.off()

# Forecast vs Actual for Visa
png(file.path(forecast_plots_path, "Forecast_vs_Actual_Visa.png"))
plot(ts_Visa, main="Visa Forecast vs Actual", ylab="Price (USD)", xlab="Time", col="green", lty=1)
lines(forecast_Visa_test$mean, col="purple", lty=2)
legend("topright", legend=c("Actual", "Forecast"), col=c("green", "purple"), lty=c(1, 2))
dev.off()

# Save forecast results
print("Saving forecast results...")
forecast_results <- data.frame(Date = time(forecast_MasterCard_test$mean),
                               MasterCard_Forecast = forecast_MasterCard_test$mean,
                               Visa_Forecast = forecast_Visa_test$mean)
write.csv(forecast_results, results_path, row.names = FALSE)

# Calculate and print accuracy metrics
print("Calculating model accuracy metrics...")
accuracy_MasterCard <- accuracy(forecast_MasterCard_test, test_MasterCard)
accuracy_Visa <- accuracy(forecast_Visa_test, test_Visa)
print("Model accuracy metrics for MasterCard:")
print(accuracy_MasterCard)
print("Model accuracy metrics for Visa:")
print(accuracy_Visa)

# Fit ARIMA model for MasterCard
print("Fitting ARIMA model for MasterCard...")
fit_MasterCard <- auto.arima(ts_MasterCard)
print("ARIMA model for MasterCard fitted successfully!")
print(summary(fit_MasterCard))  # Print summary of the model

# Fit ARIMA model for Visa
print("Fitting ARIMA model for Visa...")
fit_Visa <- auto.arima(ts_Visa)
print("ARIMA model for Visa fitted successfully!")
print(summary(fit_Visa))  # Print summary of the model

# Residual diagnostics for MasterCard
print("Performing residual diagnostics for MasterCard...")
checkresiduals(fit_MasterCard)

# Save residual plot for MasterCard
png(file.path(residual_plots_path, "residuals_MasterCard.png"))
plot(fit_MasterCard$residuals, main="Residuals of MasterCard ARIMA Model", ylab="Residuals", xlab="Time", col="blue", bg="white")
abline(h=0, col="red", lty=2)
dev.off()

# Residual diagnostics for Visa
print("Performing residual diagnostics for Visa...")
checkresiduals(fit_Visa)

# Save residual plot for Visa
png(file.path(residual_plots_path, "residuals_Visa.png"))
plot(fit_Visa$residuals, main="Residuals of Visa ARIMA Model", ylab="Residuals", xlab="Time", col="green", bg="white")
abline(h=0, col="red", lty=2)
dev.off()

print("All plots and results have been saved successfully!")
