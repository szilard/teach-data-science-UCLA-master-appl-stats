
set.seed(123)

n <- 30
sigma <- 0.5

x <- seq(from = 0, to = 4*pi, length = n)   # x
y <- sin(x) + rnorm(n, sd = sigma)          # y = f(x) + eps

plot(y ~ x)                                         # y ~ x
lines(sin(x) ~ x, col = "red")                      # f(x) ~ x  

deg <- 20    # try: 5, 4, 8, 20   (complexity of the model)
dpoly_xy <- data.frame(poly(x,deg), y)      # expand x poly
md <- lm(y ~ ., dpoly_xy)                   # f^ 

lines(predict(md, dpoly_xy) ~ x, col = "#0000ff")      # f^(x) ~ x
#lines(predict(md, dpoly_xy) ~ x, col = "#5555ff")      # f^(x) ~ x
#lines(predict(md, dpoly_xy) ~ x, col = "magenta")      # f^(x) ~ x
#lines(predict(md, dpoly_xy) ~ x, col = "#aaaaff")      # f^(x) ~ x
