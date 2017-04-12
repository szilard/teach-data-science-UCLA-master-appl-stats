
library(ggplot2)
library(dplyr)
set.seed(123)

n <- 30
sigma <- 0.5    # try 0.5, 0.1, 1.5  (noise/signal ratio)
# sigma vs best deg:  0.1-9  0.5-7 1.5-5

M <- 100
d_err <- data.frame()
for (m in 1:M) {

x <- seq(from = 0, to = 4*pi, length = n)     # x
y <- sin(x) + rnorm(n, sd = sigma)            # y = f(x) + eps

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
}

d_err <- d_err %>% group_by(deg) %>% 
  summarize(err_train = mean(err_train), err_test = mean(err_test)) 

ggplot(d_err) + geom_line(aes(x = deg, y = err_train), color = "blue") +
  geom_line(aes(x = deg, y = err_test, ymin = 0), color = "red") 

d_err[d_err$err_test==min(d_err$err_test),]$deg   # best `deg`



