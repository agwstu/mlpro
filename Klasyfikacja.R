#####################
### Klasyfikacja ####
#####################

#install.packages("DescTools")

### Libraries

packages_vector <- c(
  "lmtest", "zoo", "lattice", "pROC", "forcats", "RColorBrewer", "devtools", "smbinning", 
  "sqldf", "ggplot2", "scales", "Formula", "partykit", "plyr", "dplyr", "caTools", "tidyr", "gridExtra", "pcaPP", "ggrepel","readr", "woeBinning", "caTools", "magrittr")

package.check <- lapply(packages_vector, FUN = function(x) {
  if(!require(x, character.only = TRUE)) {
    install.packages(x, dependencies = TRUE)
  }
})

# Setting graphs areas
resetPar <- function() {
  dev.new()
  op <- par(no.readonly = TRUE)
  dev.off()
  op
}

par(resetPar()) 
par(xpd = T, mfrow=c(1,1))


####Loading data 

YearPredictionMSD <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/YearPredictionMSD.txt", header=FALSE)

str(YearPredictionMSD)
####wszystkie zmienne są numeryczne 
#### nie ma nazw kolumn, będzie trzeba je nadać

table(is.na(YearPredictionMSD))
### no NA's in data 

dane <- as_tibble(YearPredictionMSD)

#Pre - analysis

#Basic descriptive statistics
summary(dane)

#skewness & kurtosis
#install.packages("moments")
library(moments)
skewness(dane$V2) # tutaj wstawić zmienną objaśnianą
kurtosis(dane$V2) # tutaj wstawić zmienną objaąnian
hist(dane$V2, breaks="Scott")


##to bardzo długo chodzi, bo mamy dużo zmiennnych
## tutaj sa statystyki opisowe dla każdej zmiennej 
desc_r <- Desc(dane)

####gitgitgit
