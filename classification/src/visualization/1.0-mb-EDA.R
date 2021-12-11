pacman::p_load(tidyverse)
# Mateusz - Loading Data
raw_data <- read.csv("classification\\data\\raw\\dataset_31_credit-g.csv")
raw_data %>% head()

# one-dimensional plots (etc. ecdf, density)

pdf_duration <- table(raw_data$duration)
barplot(pdf_duration)
ecdf_duration <-  ecdf(raw_data$duration)
plot(ecdf_duration)

pdf_age <- density(raw_data$age)
plot(pdf_age)