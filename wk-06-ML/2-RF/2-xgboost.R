
library(readr)
library(xgboost)
library(ROCR)


d <- read_csv("wk-06-ML/data/airline100K.csv")

set.seed(123)
N <- nrow(d)
idx <- sample(1:N, 0.6*N)
d_train <- d[idx,]
d_test <- d[-idx,]


X <- Matrix::sparse.model.matrix(dep_delayed_15min ~ . - 1, data = d)
X_train <- X[idx,]
X_test <- X[-idx,]


# random forest with xgboost
system.time({
  n_proc <- parallel::detectCores()
  md <- xgboost(data = X_train, label = ifelse(d_train$dep_delayed_15min=='Y',1,0),
                nthread = n_proc, nround = 1, max_depth = 20,
                num_parallel_tree = 500, subsample = 0.632,
                colsample_bytree = 1/sqrt(length(X_train@x)/nrow(X_train)),
                save_period = NULL)
})



phat <- predict(md, newdata = X_test)

rocr_pred <- prediction(phat, d_test$dep_delayed_15min)
performance(rocr_pred, "auc")@y.values[[1]]

