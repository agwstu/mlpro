pacman::p_load(data.table, tidyverse)

year_df <- read.csv('YearPredictionMSD.txt', header = FALSE)

target <- year_df %>% select(V1)

covariates <- year_df %>% select(-V1)

timbre_average <- covariates %>% select(V2:V13)
timbre_covariance <- covariates %>% select(V14:V91)

# accordingly to the dataset description the first 12 columns are timbre average
# Let's check what are the characteristics across these two group of features

summary(timbre_average)

train <- year_df %>% slice_head(n = 463715)

test <- year_df %>% slice_tail(n = 51630)

year_df <- year_df %>%
  rename(year = V1)