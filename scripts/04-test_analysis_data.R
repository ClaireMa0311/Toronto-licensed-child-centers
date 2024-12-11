#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned Licened Child Care Centers dataset
# Author: Claire Ma
# Date: 25 November 2024
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `arrow` and `testthat` packages must be installed and loaded
# - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `Child_Center_Analysis` rproj

#### Workspace setup ####
library(arrow)
library(testthat)

data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Test data ####
# Test if the data was successfully loaded
if (exists("data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####
# Test if values in `ward` are greater than 0
test_that("All values in 'ward' are greater than 0", {
  expect_true(all(data$ward > 0))
})

# Test if values in `TOTSPACE` (Total Space) are greater than 0
test_that("All values in 'TOTSPACE' are greater than 0", {
  expect_true(all(data$TOTSPACE > 0))
})

# Test if values in `subsidy` are either 0 or 1
test_that("All values in 'subsidy' are either 0 or 1", {
  expect_true(all(data$subsidy %in% c(0, 1)))
})

# Test if values in `cwelcc_flag` are either 0 or 1
test_that("All values in 'cwelcc_flag' are either 0 or 1", {
  expect_true(all(data$cwelcc_flag %in% c(0, 1)))
})
