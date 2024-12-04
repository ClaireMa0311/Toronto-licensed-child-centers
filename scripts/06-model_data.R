#### Preamble ####
# Purpose: Models
# Author: Minglu Ma
# Date: 28 November 2024 
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `caret` and 'ggplot2' package must be installed and loaded
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(caret)
library(ggplot2)
data <- read.csv("../data/02-analysis_data/cleaned_data.csv")
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

