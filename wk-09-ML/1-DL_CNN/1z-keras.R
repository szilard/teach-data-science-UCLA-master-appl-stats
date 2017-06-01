
library(keras)

mnist <- dataset_mnist()
X_train <- mnist$train$x
y_train <- mnist$train$y
X_test <- mnist$test$x
y_test <- mnist$test$y

X_train <- array(as.numeric(X_train), dim = c(dim(X_train)[[1]], 28, 28, 1))
X_test <- array(as.numeric(X_test), dim = c(dim(X_test)[[1]], 28, 28, 1))
input_shape <- c(28, 28, 1)

X_train <- X_train / 255
X_test <- X_test / 255
y_train <- to_categorical(y_train, 10)
y_test <- to_categorical(y_test, 10)


model <- keras_model_sequential()
model %>%
  layer_conv_2d(filters = 32, kernel_size = c(4,4), activation = 'relu', input_shape = input_shape) %>% 
  layer_max_pooling_2d(pool_size = c(2, 2)) %>% 
  layer_conv_2d(filters = 16, kernel_size = c(3,3), activation = 'relu', input_shape = input_shape) %>% 
  layer_max_pooling_2d(pool_size = c(2, 2)) %>% 
  layer_dropout(rate = 0.2) %>% 
  layer_flatten() %>% 
  layer_dense(units = 128, activation = 'relu') %>% 
  layer_dense(units = 64, activation = 'relu') %>% 
  layer_dense(units = 10, activation = 'softmax')

model %>% compile(
  loss = loss_categorical_crossentropy,
  optimizer = optimizer_sgd(lr = 0.05, momentum = 0.9, decay = 1e-5),
  metrics = c('accuracy')
)

system.time({
model %>% fit(X_train, y_train, batch_size = 128, epochs = 10, verbose = 1)
})

scores <- model %>% evaluate(X_test, y_test, verbose = 0)
cat('Error rate:', scores[[2]], '%\n')


