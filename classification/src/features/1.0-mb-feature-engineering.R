pacman::p_load(tidyverse)

raw_data <- read.csv("classification\\data\\raw\\dataset_31_credit-g.csv")

raw_data %>%
  mutate(duration_in_years = round(duration/12) + 1) %>%
  select(duration_in_years) %>%
  write.csv("classification\\data\\interim\\duration_in_years.csv",
            row.names = FALSE)
