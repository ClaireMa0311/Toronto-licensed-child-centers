#### Preamble ####
# Purpose: Simulate Licened Child Care Centers dataset 
# Author: Claire Ma
# Date: 25 November 2024 
# Contact: minglu.ma@mail.utoronto.ca 
# License: MIT
# Pre-requisites: The `dplyr` package must be installed and loaded
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
# Load necessary library
library(dplyr)

#### Simulate data ####

# Set seed for reproducibility
set.seed(1008047418)

# Simulate dataset
n <- 1000  # Number of observations
simulated_data <- data.frame(
  ward = sample(1:25, n, replace = TRUE),  # Wards ranging from 1 to 25
  AUSPICE = sample(
    c("Non Profit Agency", "Commercial Agency", "Other"), 
    n, replace = TRUE, prob = c(0.7, 0.2, 0.1)  # Adjust probabilities for three categories
  ),  # AUSPICE categories
  bldg_type = sample(
    c("Catholic Elementary (French)", "Catholic Elementary School", 
      "Catholic High School", "Church", "Commercial Building", 
      "Community College/University", "Community Health Centre", 
      "Community Rec/Centre - Board Run", "Community/Rec Centre - City", 
      "Community/Recreation Centre", "High Rise Apartment", "Hospital/Health Centre",
      "House", "Industrial Building", "Low Rise Apartment", "Office Building", "Other", 
      "Place of Worship", "Private Elementary School", "Public (school closed)", 
      "Public Elementary School", "Public Elementary Special", "Public High School", 
      "Public Middle School", "Purpose Built", "Synagogue"),
    n, replace = TRUE
  ),  # Building types
  cwelcc_flag = sample(0:1, n, replace = TRUE, prob = c(0.2, 0.8)),  # CWELCC flag (mostly 1)
  TOTSPACE = round(runif(n, 14, 200)),  # Total space (random range 20 to 200)
  subsidy = sample(0:1, n, replace = TRUE, prob = c(0.3, 0.7))  # Subsidy (mostly 1)
)

# Display first few rows of the simulated dataset
head(simulated_data)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
