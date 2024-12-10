#### Preamble ####
# Purpose: Models
# Author: Minglu Ma
# Date: 28 November 2024 
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `caret`, `arrow`, and 'ggplot2' package must be installed and loaded
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(caret)
library(ggplot2)
library(arrow)

data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
#full model
# Encode categorical variables
data$AUSPICE <- as.factor(data$AUSPICE)
data$bldg_type <- as.factor(data$bldg_type)

# Split the data into training and testing sets
set.seed(1008047418)
train_index <- createDataPartition(data$subsidy, p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Fit logistic regression model
log_model <- glm(subsidy ~ ., data = train_data, family = binomial)

# Summary of the model
summary(log_model)

# Stepwise selection based on AIC
step_model_aic <- step(log_model, direction = "both", trace = TRUE)

# Summary of models
summary(step_model_aic)  # AIC-based selected model

# Refit model by removing non-significant variables
reduced_model_2 <- glm(formula = subsidy ~ AUSPICE + cwelcc_flag + TOTSPACE, 
                       family = binomial, data = train_data)
summary(reduced_model_2)

anova(reduced_model_2, step_model_aic)

reduced_model_2 <- glm(formula = subsidy ~ AUSPICE + cwelcc_flag + TOTSPACE, 
                       family = binomial, data = data)
saveRDS(reduced_model_2, file="models/final_model.rds")

# 1.
#Encode categorical variables
data$AUSPICE <- as.factor(data$AUSPICE)
data$bldg_type <- as.factor(data$bldg_type)

# Split the data into training and testing sets
set.seed(1008047418)
train_index <- createDataPartition(data$subsidy, p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Fit logistic regression model
log_model <- glm(subsidy ~ ., data = train_data, family = binomial)

# Summary of the model
summary(log_model)

# 2.
# Stepwise selection based on AIC
step_model_aic <- step(log_model, direction = "both", trace = TRUE)

# Summary of models
summary(step_model_aic)  # AIC-based selected model

# 3.
# Create a binary variable for "Non Profit Agency"
train_data$AUSPICE_NonProfit <- ifelse(train_data$AUSPICE == "Non Profit Agency", 1, 0)

# Refit the model with the binary variable for AUSPICE
reduced_model_re2 <- glm(formula = subsidy ~ AUSPICE_NonProfit + bldg_type + cwelcc_flag + TOTSPACE, 
                         family = binomial, data = train_data)

# Summary of the updated model
summary(reduced_model_re2)

# 4. 
# Refit the best aic model
reduced_model_re <- glm(formula = subsidy ~ AUSPICE + bldg_type + cwelcc_flag + TOTSPACE, 
                        family = binomial, data = train_data)
summary(reduced_model_re)

# 5.
# Refit model by removing non-significant variables
reduced_model_2 <- glm(formula = subsidy ~ AUSPICE + cwelcc_flag + TOTSPACE, 
                       family = binomial, data = train_data)
summary(reduced_model_2)

# 6. 
# Create a coefficient table of all models
model_list <- list(
  "Full Model" = log_model,
  "AIC Model" = reduced_model_re,
  "Simplified Model" = reduced_model_2
)

# Customize the table to display only AIC and Deviance
modelsummary(
  model_list,
  gof_map = c("AIC", "Deviance")  # Include only AIC and Deviance in the table
)


# Calculate log-likelihood of the fitted model
log_likelihood_fitted <- logLik(model)
# Fit the null model (model with intercept only)
null_model <- glm(subsidy ~ 1, data = data, family = binomial)
log_likelihood_null <- logLik(null_model)
# McFadden's R-squared
mcfadden_r2 <- 1 - as.numeric(log_likelihood_fitted / log_likelihood_null)
# Print the result
# print(paste("McFadden's R-squared:", round(mcfadden_r2, 6)))