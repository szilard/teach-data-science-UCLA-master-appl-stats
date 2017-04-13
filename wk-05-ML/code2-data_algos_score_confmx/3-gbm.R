
library(gbm)
set.seed(123)

# read data, split train/test 1-machine_learning_code/2-trees+ensembles/0-data.R
dim(d_train)
dim(d_test)

# gbm needs numeric y
d_train_ynum <- d_train
d_train_ynum$spam <- ifelse(d_train_ynum$spam=="1",1,0)

md <- gbm(spam ~ ., data = d_train_ynum, distribution = "bernoulli",
          n.trees = 100, interaction.depth = 10, shrinkage = 0.01)
md

yhat <- predict(md, d_test, n.trees = 100) 
table(ifelse(yhat>0,1,0), d_test$spam)

args(gbm)

md <- gbm(spam ~ ., data = d_train_ynum, distribution = "bernoulli",
          n.trees = 100, interaction.depth = 10, shrinkage = 0.01,
          cv.folds = 5)
gbm.perf(md, plot.it = TRUE)

md <- gbm(spam ~ ., data = d_train_ynum, distribution = "bernoulli",
          n.trees = 100, interaction.depth = 10, shrinkage = 0.3,
          cv.folds = 5)
gbm.perf(md, plot.it = TRUE)
md

yhat <- predict(md, d_test, n.trees = 100) 
table(ifelse(yhat>0,1,0), d_test$spam)

yhat <- predict(md, d_test, n.trees = gbm.perf(md, plot.it = FALSE)) 
table(ifelse(yhat>0,1,0), d_test$spam)


