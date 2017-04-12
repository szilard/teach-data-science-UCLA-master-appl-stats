
library(glmnet)
library(MASS)

set.seed(123)

n1 <- 300
n2 <- 1000
p <- 100
p0 <- 10
sigma <- 1

# assume we know true model/coefs
b <- c(rep(1,p0),rep(0,p-p0))
X1 <- matrix(rnorm(n1*p),n1,p)  # train
X2 <- matrix(rnorm(n2*p),n2,p)  # test
y1 <- X1 %*% b + rnorm(n1) * sigma 
y2 <- X2 %*% b + rnorm(n2) * sigma

# plain lin.regr.
md <- lm(y1 ~ X1 + 0) 
plot(coef(md))
lines(b)
y2p <- X2 %*% coef(md)
sqrt(mean((y2-y2p)^2))

# plain lin. regr. with glmnet
md <- glmnet(X1, y1, lambda = 0, intercept = FALSE)
y2p <- predict(md, X2)
sqrt(mean((y2-y2p)^2))
# to match lm:
md <- glmnet(X1, y1, lambda = 0, intercept = FALSE, thresh = 1e-12)
y2p <- predict(md, X2)
sqrt(mean((y2-y2p)^2))

# lasso
md <- glmnet(X1, y1, lambda = 0.05, intercept = FALSE)
y2p <- predict(md, X2)
sqrt(mean((y2-y2p)^2))

plot(coef(md))
lines(b)
sum(coef(md)!=0)

# best lambda
md <- cv.glmnet(X1, y1, intercept = FALSE)
plot(md)
md
y2p <- predict(md, X2)
sqrt(mean((y2-y2p)^2))

plot(coef(md))
lines(b)
sum(coef(md)!=0)

