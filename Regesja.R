###### Klasyfikacja ########
########################

###Loading data

data_r <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/dataset_31_credit-g.csv")


# Wyświetlenie typów danych
str(data_r)

### Classification: Preprocessing


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


### Opisanie skali danych 
# checking_status- skala przedziałowa
# duration - skala ilorazowa
# credit history - skala nominalna
# purpose - skala nominalna
# credit_amount - skala ilorazowa
# saving_status - skala przedzialowa
# employment  - skala przedzialowa
# installment_commitment - skala porządkowa 
# personal_status - skala nominalna 
# other_parties - nie wiem ?
# residence_since - ilorazowa ?
# property_magnitude - nominalna ?
# age - absolutna 
# other_paument_plans - nomianlna?
# housing - nominalna 
# existing_credits - ilorazowa ?
# job - nominalna 
# num_dependents ?
# own telephone - nomianlna
# foreign_woreker - nominalna
# class - nominalna 

### Handling na 

table(is.na(data_r))




