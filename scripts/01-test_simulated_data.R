#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Licened Child Care Centers
# Author: Claire Ma
# Date: 25 November 2024
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# 1. Test if values in `ward` are greater than 0
ward_test <- all(data$ward > 0)
cat("Test 1: All values in 'ward' are greater than 0:", ward_test, "\n")

# 2. Test if values in `TOTSPACE` (Total Space) are greater than 0
totspace_test <- all(data$TOTSPACE > 0)
cat("Test 2: All values in 'TOTSPACE' are greater than 0:", totspace_test, "\n")

# 3. Test if values in `subsidy` are either 0 or 1
subsidy_test <- all(data$subsidy %in% c(0, 1))
cat("Test 3: All values in 'subsidy' are either 0 or 1:", subsidy_test, "\n")

# 4. Test if values in `cwelcc_flag` are either 0 or 1
cwelcc_flag_test <- all(data$cwelcc_flag %in% c(0, 1))
cat("Test 4: All values in 'cwelcc_flag' are either 0 or 1:", cwelcc_flag_test, "\n")

# Combine results
if (ward_test & totspace_test & subsidy_test & cwelcc_flag_test) {
  cat("All tests passed! The dataset meets the specified conditions.\n")
} else {
  cat("One or more tests failed. Please inspect the dataset for issues.\n")
}
