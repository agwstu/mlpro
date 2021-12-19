pacman::p_load(data.table, tidyverse, normtest, exactRankTests)

# timbre average data
timbre_average_data <- read.csv("regression\\data\\interim\\timbre_average_data.csv")

target_data <- read.csv("regression\\data\\interim\\target_data.csv")

timbre_average_data_with_target <- timbre_average_data %>%
  add_column(year = target_data)

#### Two independent (not paired) samples
source("regression\\src\\utils\\t_test_across_centuries.R")

t_test_test_across_centuries(timbre_average_data_with_target,
                             'V2')
# Mean of variable V2 across centuries is different
t_test_test_across_centuries(timbre_average_data_with_target,
                             'V7')
# Mean of variable V7 across centuries is different

# timbre covariance data
timbre_covariance_data <- read.csv("regression\\data\\interim\\timbre_covariance_data.csv")

timbre_covariance_data_with_target <- timbre_covariance_data %>%
  add_column(year = target_data)

#### Two independent (not paired) samples
source("regression\\src\\utils\\t_test_across_centuries.R")

t_test_test_across_centuries(timbre_covariance_data_with_target,
                             'V21')
# Mean of variable V21 across centuries is different
t_test_test_across_centuries(timbre_covariance_data_with_target,
                             'V15')
# Mean of variable V15 across centuries is different