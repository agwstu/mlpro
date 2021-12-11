##################################
###  Regression: Preprocessing ###
##################################

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


####Loading data : Agata

dane <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/YearPredictionMSD.txt", header=FALSE)

str(dane)
####wszystkie zmienne są numeryczne 
#### nie ma nazw kolumn, będzie trzeba je nadać


# Handling NAs 
table(is.na(dane))
#result:
### no NA's in data 

dane <- as_tibble(dane)

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

getwd()
wd_eda <- "/Users/agatawytrykowska/Desktop/studia/magisterka/3sem/ML2/mlpro/regression/src/visualization"
setwd(wda)

## Opening pdf file to store charts
pdf(file = "desc_stats_reg.pdf", paper = "a4")

desc_r <- DescTools::Desc(dane)

# one-dimentional plots  
histogram <- apply(dane,2, function(x) hist(x, breaks = 100))

# to bardzo dlugo sie mieli
ecdf <- apply(dane, 2, function(x) plot(ecdf(x), verticals = TRUE))

dev.off()

XXL <- c(1:9, c(-1,1)*1e300)
hh <- hist(XXL, "FD")




####gitgitgit
