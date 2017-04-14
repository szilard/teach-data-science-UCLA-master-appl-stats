
library(gbm)
set.seed(123)

# read data, split train/test 0-data.R
dim(d_train)
dim(d_test)

# gbm needs numeric y
d_train_ynum <- d_train
d_train_ynum$spam <- ifelse(d_train_ynum$spam=="1",1,0)

args(gbm)

md <- gbm(spam ~ ., data = d_train_ynum, distribution = "bernoulli",
          n.trees = 100, interaction.depth = 10, shrinkage = 0.3)

# train err
yhat <- predict(md, d_train, n.trees = md$n.trees) 
sum(ifelse(yhat>0,1,0)!=d_train$spam)/nrow(d_train)

# test err
yhat <- predict(md, d_test, n.trees = md$n.trees) 
sum(ifelse(yhat>0,1,0)!=d_test$spam)/nrow(d_test)


# cross validation manually 
# model evaluation only, no model selection (based on optimal n_trees)
K <- 5
folds <- sample(rep(1:K, nrow(d_train)/K))
folds
table(folds)

err_fold <- numeric(K)
for (k in 1:K) {

  d_fold_train <- d_train_ynum[folds!=k,]
  d_fold_test  <- d_train_ynum[folds==k,]
  
  md <- gbm(spam ~ ., data = d_fold_train, distribution = "bernoulli",
          n.trees = 100, interaction.depth = 10, shrinkage = 0.3)
  
  yhat <- predict(md, d_fold_test, n.trees = md$n.trees)
  err_fold[k] <- sum(ifelse(yhat>0,1,0)!=d_fold_test$spam)/nrow(d_fold_test)

}
# cv err
mean(err_fold)


# build-in cross validation (+model selection)
md <- gbm(spam ~ ., data = d_train_ynum, distribution = "bernoulli",
          n.trees = 100, interaction.depth = 10, shrinkage = 0.3,
          cv.folds = 5)
gbm.perf(md, plot.it = TRUE)
md
names(md)




