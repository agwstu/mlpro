pacman::p_load(data.table, tidyverse)

# loading data to R (MB)
raw_data <- read.csv('regression\\data\\raw\\YearPredictionMSD.txt',
                     header = FALSE)

raw_data <- raw_data %>%
  rename(year = V1)

# Split variables into continous and discrete
# This task occurred to be something more connected to splitting into target and X variables.
# X variables might be splitted into more granular level.
target_data <- raw_data %>% select(year)

target_data %>% write.csv("regression\\data\\interim\\target_data.csv",
                                  row.names = FALSE)

covariates_data <- raw_data %>% select(-year)

timbre_average_data <- covariates_data %>% select(V2:V13)

timbre_average_data %>% write.csv("regression\\data\\interim\\timbre_average_data.csv",
                                  row.names = FALSE)

timbre_covariance_data <- covariates_data %>% select(V14:V91)

timbre_covariance_data %>% write.csv("regression\\data\\interim\\timbre_covariance_data.csv",
                                  row.names = FALSE)

# accordingly to the dataset description the first 12 columns are timbre average
# Let's check what are the characteristics across these two group of features
summary(timbre_average_data)

train_data <- raw_data %>% slice_head(n = 463715)

train_data %>% write.csv("regression\\data\\interim\\train_data.csv",
                                     row.names = FALSE)

test_data <- raw_data %>% slice_tail(n = 51630)

test_data %>% write.csv("regression\\data\\interim\\test_data.csv",
                                     row.names = FALSE)

# Handling missing values

raw_data %>% summarise(across(everything(), ~sum(is.na(.))))

# there are no missing values across columns and in the whole dataset

# Spotting duplicates

(raw_data %>% dim())[1] - n_distinct(raw_data)

# There 214 duplicates in the data