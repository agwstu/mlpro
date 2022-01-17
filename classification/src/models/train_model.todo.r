library(tidyverse)
library(MASS)
library(tree)
library(caret)
library(rpart)
library(rpart.plot)
library(rattle)
library(pROC)
library(here)
library(e1071)
library(gbm)
library(xgboost)
library(fastAdaboost)
#devtools::install_github("nivangio/adaStump")
library(adaStump)
library(dplyr)
library(tibble)
library(readr)



#Agata - Loading Data
df <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/dataset_31_credit-g.csv")

df %>% glimpse()

table(df$class)/length(df$class)

# Dividing data into training and testing sample

set.seed(123)
training_obs <- createDataPartition(df$class, 
                                    p = 0.7, 
                                    list = FALSE) 
df.train <- df[training_obs,]
df.test  <- df[-training_obs,]
table(df.train$class)/length(df.train$class)
table(df.test$class)/length(df.test$class)
### Formula 

x_names <- colnames(df[, -21])
y_name <- "class"
Y_frmla <- paste(y_name, "~")
frmla <- paste0(Y_frmla, do.call(paste, list(x_names, collapse = "+")))

tree1 <- rpart(frmla, data = df.train, method = "class")
tree1
rpart.plot(tree1)
summary(tree1)


tree2 <- rpart(frmla,
        data = df.train,
        method = "class",
        parms = list(split = 'information'))

fancyRpartPlot(tree2)

pred.tree2 <- predict(tree2, df.train, type = "class")
head(pred.tree2)

confusionMatrix(data = pred.tree2, # predictions
                # actual values
                reference = as.factor(df.train$class),
                # definitions of the "success" label
                positive = "good") 
printcp(tree2)

opt <- which.min(tree2$cptable[, "xerror"])
cp <- tree2$cptable[opt, "CP"]

tree2.p  <- prune(tree2, cp = cp)
fancyRpartPlot(tree2.p)

pred.tree2 <- predict(tree2, df.train)
pred.tree2.p <- predict(tree2.p, df.train)

### ROC curve
ROC.train.tree2 <- roc(as.numeric(df.train$class == "good"), pred.tree2[,1])
ROC.train.tree2.p <- roc(as.numeric(df.train$class == "good"), pred.tree2.p[,1])

list(
  ROC.train.tree2  = ROC.train.tree2,
  ROC.train.tree2.p = ROC.train.tree2.p
) %>%
  pROC::ggroc(alpha = 0.5, linetype = 1, size = 1) + 
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), 
               color = "grey", 
               linetype = "dashed") +
  labs(subtitle = paste0("Gini TRAIN: ",
                         "tree4 = ", 
                         round(100*(2 * auc(ROC.train.tree2) - 1), 1), "%, ",
                         "tree4p = ", 
                         round(100*(2 * auc(ROC.train.tree2.p) - 1), 1), "% ")) +
  theme_bw() + coord_fixed() +
  # scale_color_brewer(palette = "Paired") +
  scale_color_manual(values = RColorBrewer::brewer.pal(n = 4, 
                                                       name = "Paired")[c(1, 3)])


pred.test.tree2  <- predict(tree2, 
                            df.test)
pred.test.tree2.p <- predict(tree2.p, 
                            df.test)
ROC.test.tree2  <- roc(as.numeric(df.test$class == "good"), 
                       pred.test.tree2[, 1])
ROC.test.tree2.p <- roc(as.numeric(df.test$class == "good"), 
                       pred.test.tree2.p[, 1])

list(
  ROC.train.tree2  = ROC.train.tree2,
  ROC.test.tree2   = ROC.test.tree2,
  ROC.train.tree2.p = ROC.train.tree2.p,
  ROC.test.tree2.p  = ROC.test.tree2.p
) %>%
  pROC::ggroc(alpha = 0.5, linetype = 1, size = 1) + 
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), 
               color = "grey", 
               linetype = "dashed") +
  labs(subtitle = paste0("Gini TRAIN: ",
                         "tree2 = ", 
                         round(100*(2 * auc(ROC.train.tree2) - 1), 1), "%, ",
                         "tree2p = ", 
                         round(100*(2 * auc(ROC.train.tree2.p) - 1), 1), "% ",
                         "Gini TEST: ",
                         "tree2 = ", 
                         round(100*(2 * auc(ROC.test.tree2) - 1), 1), "%, ",
                         "tree2p = ", 
                         round(100*(2 * auc(ROC.test.tree2.p) - 1), 1), "% "
  )) +
  theme_bw() + coord_fixed() +
  scale_color_brewer(palette = "Paired")

#Variable importance 

tree2.importance <- tree2$variable.importance
tree2.importance

par(mar = c(5.1, 6.1, 4.1, 2.1))
barplot(rev(tree2.importance), # vactor
        col = "blue",  # colors
        main = "imporatnce of variables in model tree4",
        horiz = T,  # horizontal type of plot
        las = 1,    # labels always horizontally 
        cex.names = 0.6)

#in this case five most important predictors are: checking status, purpose, duration, savings_status, credit_amount





