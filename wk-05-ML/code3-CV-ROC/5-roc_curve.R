
library(randomForest)
library(ROCR)
library(ggplot2)
set.seed(123)

# read data, split train/test 0-data.R
dim(d_train)
dim(d_test)

md <- randomForest(spam ~ ., data = d_train, ntree = 100)
md

phat <- predict(md, d_test, type = "prob")[,"1"]
table(ifelse(phat>0.5,1,0), d_test$spam)
sum(ifelse(phat>0.5,1,0)!=d_test$spam)/nrow(d_test)


# ROCR: http://rocr.bioinf.mpi-sb.mpg.de/

rocr_obj <- prediction(phat, d_test$spam)
class(rocr_obj)
plot(performance(rocr_obj, "err"))            # err vs cutoff

plot(performance(rocr_obj, "tpr", "fpr"))     # ROC curve
plot(performance(rocr_obj, "tpr", "fpr"), 
     xlim = c(0,0.2), ylim = c(0.8,1))        # ROC curve
performance(rocr_obj, "auc")                  # AUC
performance(rocr_obj, "auc")@y.values[[1]]    # AUC

plot(performance(rocr_obj, "tpr", "fpr"), colorize=TRUE)     # ROC curve
plot(performance(rocr_obj, "tpr", "fpr"), colorize=TRUE,
     xlim = c(0,0.2), ylim = c(0.8,1))                       # ROC curve

d_phat <- data.frame(phat, spam = d_test$spam)
ggplot(d_phat) + geom_density(aes(x = phat, color = as.factor(spam)))







