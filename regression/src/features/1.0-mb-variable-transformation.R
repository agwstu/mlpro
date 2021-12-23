pacman::p_load(tidymodels, tidyverse, parsnip)
options(device = "windows")

setwd("C:\\Users\\Mateusz\\OneDrive\\Dokumenty\\GitHub\\mlpro")

# loading data

timbre_average_data <- read.csv("regression\\data\\interim\\timbre_average_data.csv")

timbre_covariance_data <- read.csv("regression\\data\\interim\\timbre_covariance_data.csv")

target_data <- read.csv("regression\\data\\interim\\target_data.csv")

# logarithmical transformation
timbre_covariance_with_target_data <-
  timbre_covariance_data %>%
    add_column(year = target_data %>% pull(year))

simple_recipe <-
  recipe(year ~ .,
         data = timbre_covariance_with_target_data) %>%
    step_log(V15, base = 10)

simple_recipe

rf_model <- rand_forest()

rf_wflow <-
  workflow() %>%
    add_model(rf_model) %>%
    add_recipe(simple_recipe)

rf_fit <- fit(rf_wflow,
              timbre_covariance_with_target_data)

# moving averages

# meta-features

# interactions
