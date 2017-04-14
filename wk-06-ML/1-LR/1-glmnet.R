
library(readr)
library(glmnet)
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


system.time({
  md <- glmnet( X_train, d_train$dep_delayed_15min, family = "binomial", lambda = 0)
})
## stats:glm very slow!!!


phat <- predict(md, newx = X_test, type = "response")

rocr_pred <- prediction(phat, d_test$dep_delayed_15min)
performance(rocr_pred, "auc")@y.values[[1]]






