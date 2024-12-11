#### Preamble ####
# Purpose: Cleans the raw data
# Author: Claire Ma
# Date: 25 November 2024
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `dplyr`, `arrow`, and 'readr' packages must be installed and loaded
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
library(dplyr)
library(readr)
library(arrow)

#### Clean data ####
data <- read.csv("data/01-raw_data/raw_data.csv")

# Relevant columns
relevant_columns <- c("ward", "AUSPICE", "bldg_type", "cwelcc_flag", "TOTSPACE", "subsidy")

# Data Cleaning: Select, clean, and encode data
cleaned_data <- data %>%
  select(all_of(relevant_columns)) %>%
  drop_na() %>%
  mutate(
    # Collapse sparse levels in bldg_type
    bldg_type = case_when(
      bldg_type %in% c(
        "Public Elementary (French)", "Community/Rec Centre - Private",
        "Community/Rec Centre AOCC", "Multi Human Services Facility"
      ) ~ "Other",
      TRUE ~ bldg_type
    ),
    # Collapse sparse levels in AUSPICE
    AUSPICE = case_when(
      AUSPICE == "Public (City Operated) Agency" ~ "Other",
      TRUE ~ AUSPICE
    ),
    # Convert binary flags to numeric
    cwelcc_flag = ifelse(cwelcc_flag == "Y", 1, 0), # Convert to numeric 0/1
    subsidy = ifelse(subsidy == "Y", 1, 0) # Ensure numeric 0/1 encoding for subsidy
  )

#### Save data ####
write_parquet(cleaned_data, "data/02-analysis_data/analysis_data.parquet")
