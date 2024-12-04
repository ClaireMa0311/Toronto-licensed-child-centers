#### Preamble ####
# Purpose: Downloads and saves the Licened Child Care Centers dataset from Open Data Toronto
# Author: Claire Ma
# Date: 25 November 2024
# Contact: minglu.ma@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `opendatatoronto` and 'tidyverse' packages must be installed and loaded
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(readr)


#### Download data ####
# Search for a specific package on OpenDataToronto by keyword ("Marriage Licence Statistics")
marriage_licence_packages <- search_packages("Licensed Child Care Centres")
marriage_licence_packages
# Retrieve a list of all resources (datasets) available within the found package
marriage_licence_resources <- marriage_licence_packages %>%
  list_package_resources()
# Display the list of resources available in the "Marriage Licence Statistics" package
marriage_licence_resources
# Download the .csv dataset
marriage_licence_statistics <- marriage_licence_resources[3,] %>%
  get_resource()
marriage_licence_statistics
write_csv(marriage_licence_statistics, "../data/01-raw_data/raw_data.csv")


#### Save data ####
marriage_licence_statistics
write_csv(marriage_licence_statistics, "../data/01-raw_data/raw_data.csv")

         
