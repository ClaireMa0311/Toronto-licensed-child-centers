# Analysis of Toronto Licensed Child Centers Subsidy Allocation

## Overview

The study employs a logistic regression model to examine how key factors—such as governance structure, participation in the Canada-Wide Early Learning and Child Care (CWELCC) program, and licensed capacity—affect the likelihood of receiving government subsidies.

The analysis highlights that centers governed by non-profit organizations are significantly more likely to receive subsidies, reflecting the policy preference for funding entities that prioritize social goals over profit motives. Participation in the CWELCC program emerged as the strongest predictor of subsidy allocation, emphasizing the strategic alignment of funding decisions with national and provincial affordability initiatives. Additionally, larger centres with higher licensed capacities were found to be moderately more likely to secure subsidies, showcasing the role of operational scale in meeting public demand.

These findings highlight the need to align funding with governance models, policy goals, and operational characteristics to enhance subsidy effectiveness. The study offers insights for policymakers to ensure equitable resource allocation and support accessible, affordable child care in urban areas.

Some of the R code used to create this work was adapted from https://github.com/RohanAlexander/starter_folder.git.

## File Structure

The repo is structured as:
- `data/00-simulated_data` contains the simulated data for testing purpose.
- `data/01-raw_data` contains raw data used in this investigation.
- `data/02-analysis_data` contains cleaned data used in this investigation.
- `models` contains fitted models and an API of the final chosen model.
- `other` contains copies of LLM conversations, literature, and sketches of the dataset and graphs featured in this report.
- `paper` contains the Quarto file used to generate the PDF, and a file with the paper's references. Since there is rendering problem paper.pdf is lacted outside of this folder.
- `scripts` contains R scripts for simulating, downloading, cleaning, testing, visualizing and modeling the data.

## Statement on LLM usage

Aspects of the code and writing were written with the help of the AI tool, ChatGPT. The entire chat history is available in inputs/llms/usage.txt.
