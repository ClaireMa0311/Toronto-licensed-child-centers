#### Preamble ####
# Purpose: Models
# Author: Minglu Ma
# Date: 28 November 2024
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `caret`, `arrow`, `modelsummary` and 'ggplot2' package must be installed and loaded
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(caret)
library(ggplot2)
library(arrow)
library(modelsummary)

data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
# Encode categorical variables
data$AUSPICE <- as.factor(data$AUSPICE)
data$bldg_type <- as.factor(data$bldg_type)

# Split the data into training and testing sets
set.seed(1008047418)
train_index <- createDataPartition(data$subsidy, p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Fit logistic regression model (full model)
full_model <- glm(subsidy ~ ., data = train_data, family = binomial)
# Summary of the model
summary(full_model)

# Stepwise selection based on AIC
step_model_aic <- step(full_model, direction = "both", trace = TRUE)
summary(step_model_aic) # AIC-based selected model

# Refit model by removing non-significant variables to obtain the reduced model
reduced_model <- glm(
  formula = subsidy ~ AUSPICE + cwelcc_flag + TOTSPACE,
  family = binomial, data = train_data
)
summary(reduced_model)

# Create a binary variable for "Non Profit Agency"
train_data$AUSPICE_NonProfit <- ifelse(train_data$AUSPICE == "Non Profit Agency", 1, 0)
# Fit a simplified model with the binary variable for AUSPICE
simplified_model <- glm(
  formula = subsidy ~ AUSPICE_NonProfit + bldg_type + cwelcc_flag + TOTSPACE,
  family = binomial, data = train_data
)
summary(simplified_model)

# Create a coefficient table of all models
model_list <- list(
  "Full Model" = full_model,
  "AIC Model" = step_model_aic,
  "Reduced Model" = reduced_model,
  "Reduced Model (binary AUSPICE)" = simplified_model
)

# Customize the table to display only AIC and Deviance
modelsummary(
  model_list,
  gof_map = c("AIC", "Deviance") # Include only AIC and Deviance in the table
)

# Fit models to full analysis data
# Rename varaible names to beautify model output
data <- data %>%
  mutate(AUSPICE_NonProfit = ifelse(AUSPICE == "Non Profit Agency", 1, 0)) %>%
  rename(
    Ward = ward,
    Operating_Auspice = AUSPICE,
    Building_Type = bldg_type,
    CWELCC_Participation = cwelcc_flag,
    Total_Space = TOTSPACE
  )
full_model <- glm(subsidy ~ ., data = data, family = binomial)
step_model_aic <- step(full_model, direction = "both", trace = TRUE)
reduced_model <- glm(
  formula = subsidy ~ Operating_Auspice + CWELCC_Participation + Total_Space,
  family = binomial, data = data
)
simplified_model <- glm(
  formula = subsidy ~ Operating_Auspice + Building_Type + CWELCC_Participation + Total_Space,
  family = binomial, data = data
)
# Save models
saveRDS(full_model, file = "models/full_model.rds")
saveRDS(step_model_aic, file = "models/Stepwise_AIC_model.rds")
saveRDS(reduced_model, file = "models/final_model.rds")
saveRDS(simplified_model, file = "models/simplified_model.rds")

# Calculate log-likelihood of the reduced (final) model
log_likelihood_fitted <- logLik(reduced_model)
# Fit the null model (model with intercept only)
null_model <- glm(subsidy ~ 1, data = data, family = binomial)
log_likelihood_null <- logLik(null_model)
# McFadden's R-squared
mcfadden_r2 <- 1 - as.numeric(log_likelihood_fitted / log_likelihood_null)
# Print the result
print(paste("McFadden's R-squared:", round(mcfadden_r2, 3)))
