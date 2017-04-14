
library(rpart)
set.seed(123)

# read data, split train/test 0-data.R
dim(d_train)
dim(d_test)

md <- rpart(spam ~ ., data = d_train)
md
plot(md, uniform = TRUE, compress = TRUE)
text(md, use.n = TRUE, cex = 0.7)

phat <- predict(md, d_test)[,"1"]
table(ifelse(phat>0.5,1,0), d_test$spam)

args(rpart.control)
md <- rpart(spam ~ ., data = d_train, control = rpart.control(maxdepth = 2))
plot(md, uniform = TRUE, compress = TRUE)
text(md, use.n = TRUE, cex = 0.7)


