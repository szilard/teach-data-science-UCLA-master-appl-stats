

## adapted from https://github.com/dmlc/mxnet/blob/master/docs/tutorials/r/mnistCompetition.md


library(readr)
library(mxnet)
library(magrittr)


train.x <- data.matrix(read_csv('wk-09-ML/1-DL_CNN/X_train.csv', col_names = FALSE))
test.x  <- data.matrix(read_csv('wk-09-ML/1-DL_CNN/X_test.csv',  col_names = FALSE))
train.x <- t(train.x/255)
test.x  <- t(test.x/255)
train.y <- read_csv('wk-09-ML/1-DL_CNN/y_train.csv', col_names = FALSE)[[1]]
test.y  <- read_csv('wk-09-ML/1-DL_CNN/y_test.csv',  col_names = FALSE)[[1]]

train.array <- train.x
dim(train.array) <- c(28, 28, 1, ncol(train.x))
test.array <- test.x
dim(test.array) <- c(28, 28, 1, ncol(test.x))


# data <- mx.symbol.Variable('data')
# conv1 <- mx.symbol.Convolution(data = data, kernel = c(4,4), num_filter = 32)
# relu1 <- mx.symbol.Activation(data = conv1, act_type = "relu")
# pool1 <- mx.symbol.Pooling(data = relu1, pool_type = "max", kernel = c(2,2))
# conv2 <- mx.symbol.Convolution(data = pool1, kernel = c(3,3), num_filter = 16)
# relu2 <- mx.symbol.Activation(data = conv2, act_type = "relu")
# pool2 <- mx.symbol.Pooling(data = relu2, pool_type = "max", kernel = c(2,2))
# drop1 <- mx.symbol.Dropout(data = pool2, p = 0.2) 
#
# flatten1 <- mx.symbol.Flatten(data = drop1)
# fc1 <- mx.symbol.FullyConnected(data = flatten1, num_hidden = 128)
# relu3 <- mx.symbol.Activation(data = fc1, act_type = "relu")
# fc2 <- mx.symbol.FullyConnected(data = relu3, num_hidden = 64)
# relu4 <- mx.symbol.Activation(data = fc2, act_type = "relu")
# fc3 <- mx.symbol.FullyConnected(data = relu4, num_hidden = 10)
# model_spec <- mx.symbol.SoftmaxOutput(data = fc3)


model_spec <- mx.symbol.Variable('data') %>%
  mx.symbol.Convolution(kernel = c(4,4), num_filter = 32) %>% mx.symbol.Activation(act_type = "relu") %>%
  mx.symbol.Pooling(pool_type = "max", kernel = c(2,2)) %>%
  mx.symbol.Convolution(kernel = c(3,3), num_filter = 16) %>% mx.symbol.Activation(act_type = "relu") %>%
  mx.symbol.Pooling(pool_type = "max", kernel = c(2,2)) %>%
  mx.symbol.Dropout(p = 0.2)  %>%
  mx.symbol.Flatten() %>%
  mx.symbol.FullyConnected(num_hidden = 128) %>% mx.symbol.Activation(act_type = "relu") %>%
  mx.symbol.FullyConnected(num_hidden = 64) %>% mx.symbol.Activation(act_type = "relu") %>%
  mx.symbol.FullyConnected(num_hidden = 10) %>% mx.symbol.SoftmaxOutput()


## n_gpu <- as.integer(system("nvidia-smi -L | wc -l", intern = TRUE))
n_gpu <- 1   

device.gpu <- lapply(0:(n_gpu-1),mx.gpu)
mx.set.seed(0)


tic <- proc.time()
model <- mx.model.FeedForward.create(model_spec, X = train.array, y = train.y,
               initializer = mx.init.normal(0.1),
               eval.metric = mx.metric.accuracy,
               ##optimizer = mxnet:::mx.opt.sgd(learning.rate = 0.05, momentum = 0.9, wd = 1e-5),  ## bug?
               learning.rate = 0.05, momentum = 0.9, wd = 1e-5,
               ctx = device.gpu, 
               num.round = 10, array.batch.size = 128,
               epoch.end.callback = mx.callback.log.train.metric(100))
print(proc.time() - tic)


preds <- predict(model, test.array)
pred.label <- max.col(t(preds)) - 1
cat("Error rate:", sum(pred.label!=test.y)/length(test.y)*100, "%\n")


