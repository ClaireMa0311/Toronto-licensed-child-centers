#### Preamble ####
# Purpose: EDA
# Author: Claire Ma
# Date: 25 November 2024
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `dplyr`,'readr', 'ggplot2', 'reshape' and 'gridExtra'packages must be installed and loaded
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(dplyr)
library(readr)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(arrow)

#### Read data ####
data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### EDA ####
head(data)
summary(data)

# 1. Distribution of the Target Variable (subsidy)
plot1 <- ggplot(data, aes(x = as.factor(subsidy))) +
  geom_bar(fill = c("skyblue", "coral"), alpha = 0.8) +
  labs(
    title = "Distribution of Subsidy",
    x = "Subsidy (0 = No, 1 = Yes)",
    y = "Count"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 9), # Reduce title size
    axis.title = element_text(size = 10), # Reduce axis title size
    axis.text = element_text(size = 8)
  ) # Reduce axis text size

# 2. Distribution of TOTSPACE (Histogram + Density)
plot2 <- ggplot(data, aes(x = TOTSPACE)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", alpha = 0.8) +
  geom_density(color = "blue", size = 1) +
  labs(
    title = "Distribution of TOTSPACE",
    x = "TOTSPACE",
    y = "Density"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 9),
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 8)
  )

# 3. Distribution of AUSPICE (Bar Plot)
plot3 <- ggplot(data, aes(x = reorder(AUSPICE, -table(AUSPICE)[AUSPICE]))) +
  geom_bar(fill = "skyblue", alpha = 0.8) +
  coord_flip() +
  labs(
    title = "Distribution of AUSPICE",
    x = "AUSPICE",
    y = "Count"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 9),
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 8)
  )

# 4. Distribution of Building Types (Bar Plot)
plot4 <- ggplot(data, aes(x = reorder(bldg_type, -table(bldg_type)[bldg_type]))) +
  geom_bar(fill = "skyblue", alpha = 0.8) +
  coord_flip() +
  labs(
    title = "Distribution of Building Types",
    x = "Building Type",
    y = "Count"
  ) +
  theme_minimal() +
  theme(
    axis.text.y = element_text(size = 5),
    plot.title = element_text(size = 8)
  ) # Reduce title text size

# 5. Distribution of Ward (Bar Plot)
# Create a bar plot for ward variable
plot5 <- ggplot(data, aes(x = ward)) +
  geom_bar(fill = "skyblue", alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "Distribution of Observations by Ward",
    x = "Ward",
    y = "Count"
  ) +
  theme(
    axis.text.x = element_text(size = 8), # Rotate x-axis labels for readability
    plot.title = element_text(size = 8)
  )

# Increase plot area and use grid.arrange
combined_plot <- grid.arrange(plot1, plot2, plot3, plot4, plot5, ncol = 2)
