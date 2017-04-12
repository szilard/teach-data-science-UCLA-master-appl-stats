
library(randomForest)
set.seed(123)

# read data, split train/test 1-machine_learning_code/2-trees+ensembles/0-data.R
dim(d_train)
dim(d_test)

md <- randomForest(spam ~ ., data = d_train, ntree = 100)
md
plot(md)

phat <- predict(md, d_test, type = "prob")[,"1"]
table(ifelse(phat>0.5,1,0), d_test$spam)


