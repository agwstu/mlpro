pacman::p_load(tidyverse)
df <- read.csv("classification\\data\\raw\\dataset_31_credit-g.csv")
features <- df %>% names()
type <- c('qualitative', 'quantitative', 'qualitative', 'qualitative',
          'quantitative', 'qualitative', 'qualitative', 'quantitative',
         'qualitative', 'qualitative', 'quantitative', 'qualitative',
         'quantitative', 'qualitative', 'qualitative', 'quantitative',
         'qualitative', 'quantitative', 'qualitative', 'qualitative',
          'qualitative')
specific_type <- c('discrete', 'discrete', 'discrete', 'discrete',
                   'continuous', 'discrete', 'discrete', 'continuous',
                   'discrete', 'discrete', 'discrete', 'discrete',
                   'discrete', 'discrete', 'discrete', 'discrete',
                   'discrete', 'discrete', 'discrete', 'discrete',
                   'discrete')
scales <- c('ordinal', 'ordinal', 'nominal', 'nominal',
           'ratio', 'ordinal', 'ordinal', 'ratio',
           'nominal', 'nominal', 'ratio', 'nominal',
           'ratio', 'nominal', 'nominal', 'ordinal',
           'ordinal', 'discrete', 'nominal', 'nominal',
           'nominal')
pretty_names <- c('Status of existing checking account', 'Duration in month',
                  'Credit history', 'Purpose of taking a credit', 'Credit amount',
                  'Savings account/bonds', 'Present employment since',
                  'Installment rate in percentage of disposable income',
                  'Personal status and sex', 'Other debtors / guarantors',
                  'Present residence since', 'Property',
                  'Age in years', 'Other installment plans',
                  'Housing', 'Number of existing credits at this bank',
                  'Job', 'Number of people being liable to provide maintenance for',
                  'Telephone', 'Foreign worker', 'Class of a customer')
dictionary <- tibble(features = features,
                     general_type = type,
                    specific_type = specific_type,
                     scale = scales,
                     pretty_name = pretty_names)
dictionary