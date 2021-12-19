pacman::p_load(tidyverse, ggthemes)
# Mateusz - Loading Data
raw_data <- read.csv("classification\\data\\raw\\dataset_31_credit-g.csv")
raw_data %>% head()

# one-dimensional plots (etc. ecdf, density)
# duration
pacman::p_load(tidyverse)

raw_data <- read.csv("classification\\data\\raw\\dataset_31_credit-g.csv")

duration_in_years_vec <- read.csv("classification\\data\\interim\\duration_in_years.csv") %>%
  pull(duration_in_years)

interim_data <- raw_data %>%
  add_column(duration_in_years = duration_in_years_vec)

ggplot(data = interim_data, aes(x = duration_in_years_vec)) +
  geom_histogram(aes(y = ..density..)) +
  stat_density(geom = 'line', color = 'red', size = 1) +
  stat_function(fun = dnorm,
                color = 'blue',
                size = 1,
                geom = 'line',
                args = list(mean = mean(interim_data$duration_in_years_vec),
                            sd = sd(interim_data$duration_in_years_vec)))

# credit_amount, age, existing_credits, num_dependents