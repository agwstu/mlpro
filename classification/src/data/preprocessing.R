#####################################
### Classification: Preprocessing ###
#####################################


###

###Libraries
#install.packages("tidyverse")
#install.packages('ggpubr')
#install.packages('rstatix')
library(tidyverse)
library(ggpubr)
library(rstatix)
library(compare)
library(corrplot)
library(Hmisc)
library(smbinning)

#Agata - Loading Data
df <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/dataset_31_credit-g.csv")


#Handling NAs 
dim(df)
table(is.na(df))
#no NAs

# Spotting variables' duplicates
table(duplicated(df))

# no duplicates in data

###transformation of variables changing variables into factor
str(df)
sapply(df, table)

df_f <- as.data.frame(unclass(df), stringsAsFactors = TRUE) # Convert all columns into factors
sapply(df_f, class)

df_f %>% as_tibble()

table(df_f$checking_status)