#####################################
### Classification: Preprocessing ###
#####################################

#Libraries

library(tidyverse)
library(ggpubr)
library(rstatix)
library(compare)
library(corrplot)
library(Hmisc)
library(smbinning)

#Agata - Loading Data
df <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/dataset_31_credit-g.csv")

#Mateusz - Loading Data
pacman::p_load(tidyverse)
df <- read.csv("classification\\data\\raw\\dataset_31_credit-g.csv")


##############################################################################
########### EDA


#division variables into FACTORS and NUMERIC variables
colnames(df)
summary(df_f)

nums <- sapply(df_f, is.numeric) 
#apply() applying function {is.numeric} to all elements of an object {base}
df.n<-df_f[,nums]

fact <- sapply(df_f, is.factor)
df.f<-df_f[,fact]





# DISCRETIZATION - FINE CLASSING


percentile <- apply(X = df.n, MARGIN=2, FUN=function(x) round(quantile(x, seq(0.1,1,0.1), na.rm=TRUE),2))
# apply() - applying a function for each column or row of a data frame
# x= object
# MARGIN= 1 - rows, 2 columns, c(1,2) both
# FUN= function 
# function(x) round(quantile(x, seq(0.1,1,0.1), na.rm=TRUE),2) own function definition

# what if number of levels is less than 10, is there any sense to calculate deciles?
# it is important for smbinning(), function we would discuss later on

# unique values per column
unique<-apply(df.n, MARGIN=2, function(x) length(unique(x)))

# selecting only columns with more than 10 unique levels
numeric<-colnames(df.n[which(unique>=10)])
#<10 levels
num_as_fact<-colnames(df.n[which(unique<10 & unique>1 )])
#single variance variables out?
#sometimes missing as 2 level?


# binariZation wrt percentiles 
options(scipen=999) 
#turning off mathematical notation


# Binarization for numeric vars with >10 levels 


# function cut()
# x - numeric vector to be binarized
# breaks - breaks
# labels - labeling (for charts)

# changing vars into factors, where levels <10 

for (m in numeric) {
  
  df.n[,paste(m,"_fine", sep="")]<-cut(
    x=as.matrix(df.n[m]), 
    breaks=c(-Inf,unique(percentile[,m])), 
    labels =c(paste("<=",unique(percentile[,m])))
  ) 
}

df.f[,paste(num_as_fact,"_fine",sep="")]<-sapply(df.n[,num_as_fact],as.factor)

df.f
df.n

# Weight of Evidence calculation using smbinning

# in smbinning 0 means bad, --> reverting definition of gb flag

df.f[,"DEF"] <- ifelse(df.f$class == "good", 1, 0)


df.n$def_woe <- (1- df.f$DEF)
df.n$def <- df.f$DEF

#List for WoE etc.
WOE<-list()

#Data frame for Information Value
IV<-data.frame(VAR=character(), IV=integer())

#Choosing vars with _fine suffix 
df.n_fine<-df.n[ ,grepl(pattern="_fine" , x=names(df.n))]


smbinning.eda(df.n, rounding = 3, pbar = 1)
#basic descriptive statistics



# Opening pdf file to store charts
pdf(file="WoE_numeric.pdf",paper="a4")
getwd()
# Choice of vars to be analysed
names.n<-colnames(df.n[,!names(df.n) %in% c(colnames(df.n_fine),"def","def_woe")])

#Set up progress bar

total_pb <- length(names.n)
pb<- txtProgressBar(min = 0, max = total_pb, style = 3)
# min, max - extreme values for progress bar
# style=3 fraction of task that are done


# smbinning.custom(df, y, x, cuts)
# df - data frame
# y - GB flag
# x - risk factors
# cuts - cut-offs

i<-names.n[1]

for (i in names.n) {
  
  # rows and columns at a chart
  par(mfrow=c(2,2))
  
  results<- smbinning.custom(df = df.n, y="def_woe", x=i, cuts=unique(percentile[,i]))
  
  # Relevant plots (2x2 Page) 
  
  # BOXPLOT
  boxplot(df.n[,i] ~ df.n$def, 
          horizontal=T, frame=F, col="lightgray",main="Distribution") 
  mtext(i,3) 
  # Frequency plot 
  smbinning.plot(results,option="dist",sub=i)
  # Bad rate fractions
  smbinning.plot(results,option="badrate",sub=i) 
  # WoE
  smbinning.plot(results,option="WoE",sub=i)
  
  # IV row binding
  IV<-rbind(IV, as.data.frame(cbind("VAR"=i, "IV"=results$ivtable[results$ivtable$Cutpoint=="Total", "IV"])))
  
  # Saving data 
  d<-results$ivtable[,c("Cutpoint","WoE","PctRec")]
  # Total row removal  
  d<-d[d$Cutpoint!="Total",]
  # Ordering wrt WoE - for gini etc. calculation
  d<-d[with(d, order(d$WoE)),]
  # Id 
  d$numer<-11:(nrow(d)+10)
  # Saving WoE in list 
  WOE[[i]]<-d
  
  #Update progess bar  
  setTxtProgressBar(pb,  min(grep(i, names.n)))
}
close(pb)
dev.off()





###two sample t test 
















###Correlation
### Dla tych zmiennych przyjac korelacje Kendala
### miara V cramera 




#Correlation plot


f <- function(x) factor(x, levels= unique(x))

f.df <- as.tibble(df) %>%
  mutate_if(is.character, f) %>%
  mutate_if(is.factor, as.numeric) 



perfect_cor <-   function (var1, var2) {
  all(rowSums(as.matrix(table(df[[var1]], df[[var2]])) > 0) == 1)
}
perfect_cor <- Vectorize(perfect_cor)


res2<-rcorr(as.matrix(f.df))
flattenCorrMatrix(res2$r, res2$P)


corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.01, insig = "blank")


