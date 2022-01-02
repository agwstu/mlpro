pacman::p_load(data.table, tidyverse, GGally, ggcorrplot, lubridate,
               ggtext)

timbre_average_data <- read.csv("regression\\data\\interim\\timbre_average_data.csv")

corr_average <- timbre_average_data %>%
        mutate(year = target_data) %>%
        cor()

ggcorrplot(corr_average, hc.order = TRUE, type = "lower", lab = TRUE)

high_corr_columns <- corr_covariance %>%
        as_tibble() %>%
        mutate(row_name = c(timbre_covariance_data %>% names(), "year")) %>%
        relocate(row_name) %>%
        pivot_longer(-row_name) %>%
        filter(name == 'year') %>%
        filter(value > 0.05) %>%
        pull(row_name)

corr_covariance <- timbre_covariance_data %>%
        mutate(year = target_data) %>%
        select(all_of(high_corr_columns)) %>%
        cor()

ggcorrplot(corr_covariance,
           hc.order = TRUE,
           type = "lower",
           lab = TRUE,
           method = 'circle',
           lab_size = 3)

timbre_average_data %>%
  mutate(year = target_data) %>%
  mutate(century = if_else(year <= 2000, 'XX', 'XXI')) %>%
  group_by(century) %>%
  count() %>%
  ggplot(aes(x = century, y = n)) +
  geom_bar(stat = "identity") +
  ggtitle('Distributions of the songs across centuries') +
  xlab('Century') +
  ylab('Count') +
  theme_minimal() +
  theme(legend.position = 'bottom')  +
  guides(fill = guide_legend(nrow = 2,byrow = TRUE)) +
  scale_fill_grey()

timbre_average_data %>%
  mutate(year = target_data %>% pull(year)) %>%
  mutate(decade = as.factor(floor(year/10)*10)) %>%
  rename(loudness = V2) %>%
  select(loudness, decade) %>%
  ggplot(aes(x= decade, y = loudness, group=decade, fill = decade)) +
  geom_boxplot()