pacman::p_load(data.table, tidyverse)

raw_data <- read.csv('regression\\data\\raw\\YearPredictionMSD.txt',
                     header = FALSE)

raw_data <- raw_data %>%
  rename(year = V1)

target_data <- raw_data %>% select(year)

covariates_data <- raw_data %>% select(-year)

timbre_average_data <- covariates_data %>% select(V2:V13)
timbre_covariance_data <- covariates_data %>% select(V14:V91)

# accordingly to the dataset description the first 12 columns are timbre average
# Let's check what are the characteristics across these two group of features
summary(timbre_average_data)

train_data <- raw_data %>% slice_head(n = 463715)

test_data <- raw_data %>% slice_tail(n = 51630)

# handling missing values across columns

raw_data %>% summarise(across(everything(), ~sum(is.na(.))))

# there are no missing values across columns and in the whole dataset

# Spotting duplicates

(raw_data %>% dim())[1] - n_distinct(raw_data)

# There 214 duplicates in the data