pacman::p_load(tidyverse, ggcorrplot)
options(device = "windows")
setwd("C:\\Users\\Mateusz\\OneDrive\\Dokumenty\\GitHub\\mlpro")

# loading data

timbre_average_data <- read.csv("regression\\data\\interim\\timbre_average_data.csv")

timbre_covariance_data <- read.csv("regression\\data\\interim\\timbre_covariance_data.csv")

target_data <- read.csv("regression\\data\\interim\\target_data.csv")

corr_average <- timbre_average_data %>%
  mutate(year = target_data) %>%
  cor()

corr_covariance <- timbre_covariance_data %>%
  mutate(year = target_data) %>%
  cor()

# two-dimensional plots (etc. correlations)

ggcorrplot(corr_average,
           hc.order = TRUE,
           type = "lower",
           lab = TRUE)

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

# statistical analysis (two-samples t-test etc.)

## Does timbre covariance and average differ across centuries?
## We choose the most correlated variables with the target since we would like
## to learn more about them from the statistical point of view.
## For the average timbre the most correlated variable is V2
## while for the covariance timbre the one that is the most associated is V22.

pacman::p_load(Rcpp, rcompanion, psych, exactRankTests,
               DescTools, normtest, lattice, RVAideMemoire)

xx_century <- timbre_average_data %>%
  mutate(year = target_data) %>%
  filter(year <= 2000) %>%
  pull(V2)

xxi_century <- timbre_average_data %>%
  mutate(year = target_data) %>%
  filter(year > 2000) %>%
  pull(V2)

var.test(x = xx_century, y =xxi_century)

# We follow the null hypothesis since p-value is above 0.26
# True ratio of variances is equal to 1

t.test(x = xx_century, y = xxi_century, conf.int = 0.95, var.equal = TRUE)
# We reject the null hypothesis and assume that true difference in means
# is not equal to 0.

# Covariance data
xx_century <- timbre_covariance_data %>%
  mutate(year = target_data) %>%
  filter(year <= 2000) %>%
  pull(V22)

xxi_century <- timbre_covariance_data %>%
  mutate(year = target_data) %>%
  filter(year > 2000) %>%
  pull(V22)

exactRankTests::ansari.exact(xx_century, xxi_century)

mood.test(xx_century, xxi_century, data = Data, conf.int = 0.95, exact=T)
# Wilcoxon test can answer the question whether the variables in both groups
# have the same median. Both tests produce the NA results in p-value.
var.test(x = xx_century, y =xxi_century)

# We reject the null hypothesis. Variable have significantly different
# variances.

t.test(x = xx_century, y = xxi_century, conf.int = 0.95, var.equal = FALSE)

# The most correlated variable for timbre covariance differs across centuries in both mean and variance.