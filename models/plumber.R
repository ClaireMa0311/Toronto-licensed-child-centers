library(plumber)
library(tidyverse)

# Load the model
model <- readRDS("final_model.rds")

# Define the model version
version_number <- "0.0.1"

# Define the predictors for the model
variables <- list(
  AUSPICE = "The type of agency: 'Commercial Agency', 'Non Profit Agency', or 'Other'.",
  cwelcc_flag = "A binary flag indicating CWELCC participation (0 or 1).",
  TOTSPACE = "The total space available (numeric)."
)

#* @param AUSPICE The type of agency: 'Commercial Agency', 'Non Profit Agency', or 'Other'.
#* @param cwelcc_flag The CWELCC flag (0 or 1).
#* @param TOTSPACE The total space available (numeric).
#* @get /predict_subsidy
predict_subsidy <- function(AUSPICE = "Non Profit Agency", cwelcc_flag = 1, TOTSPACE = 100) {
  # Convert inputs to appropriate types
  AUSPICE <- as.character(AUSPICE)
  cwelcc_flag <- as.numeric(cwelcc_flag)
  TOTSPACE <- as.numeric(TOTSPACE)
  
  # Prepare the payload as a data frame
  payload <- data.frame(
    AUSPICE = AUSPICE,
    cwelcc_flag = cwelcc_flag,
    TOTSPACE = TOTSPACE
  )
  
  # Use the logistic regression model to predict probabilities
  predicted_probability <- predict(model, newdata = payload, type = "response")
  
  # Classify based on probability threshold of 0.5
  predicted_class <- ifelse(predicted_probability > 0.5, "Yes", "No")
  
  # Return results as a list
  result <- list(
    "Predicted to receive subsidy or not" = predicted_class
  )
  
  return(result)
}
