
library(readr)
library(e1071)
library(ROCR)

set.seed(123)


d <- read_csv("wk-06-ML/data/airline100K.csv")

set.seed(123)
N <- 10000   
idx <- sample(1:N, 0.6*N)
d_train <- d[idx,]
d_test <- d[setdiff(1:N,idx),]


X <- Matrix::sparse.model.matrix(dep_delayed_15min ~ . - 1, data = d)
X_train <- X[idx,]
X_test <- X[setdiff(1:N,idx),]



system.time({
  md <- svm(x = X_train, y = as.factor(d_train$dep_delayed_15min), 
            kernel = "radial", gamma = 0.1, cost = 1,
            probability = TRUE)
})


phat <- attr(predict(md, newdata = X_test, probability = TRUE), "probabilities")[,"Y"]

rocr_pred <- prediction(phat, d_test$dep_delayed_15min)
performance(rocr_pred, "auc")@y.values[[1]]


