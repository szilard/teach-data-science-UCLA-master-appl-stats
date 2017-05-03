
library(ggplot2)
set.seed(123)

n <- 30
sigma <- 0.5     

x <- seq(from = 0, to = 4*pi, length = n)     # x
y <- sin(x) + rnorm(n, sd = sigma)            # y = f(x) + eps

d_err <- data.frame()
for (deg in 1:20) {
  
dpoly_xy <- data.frame(poly(x,deg), y)        # expand x poly
md <- lm(y ~ ., dpoly_xy)                     # f^ 

err_train <- sqrt(mean((y - predict(md, dpoly_xy))^2))    

# test set:
n_test <- 1000
x_test <- runif(n_test, min = 0, max = 4*pi)       
y_test <- sin(x_test) + rnorm(n_test, sd = sigma)
dpoly_xtest <- data.frame(predict(poly(x,deg),x_test))    # expand x_test poly 

err_test <- sqrt(mean((y_test - predict(md, dpoly_xtest))^2))

d_err <- rbind(d_err, data.frame(deg, err_train, err_test))
}

ggplot(d_err) + geom_line(aes(x = deg, y = err_train), color = "blue") +
  geom_line(aes(x = deg, y = err_test, ymin = 0), color = "red")


