

## adapted from https://github.com/fchollet/keras/blob/master/examples/mnist_cnn.py


from __future__ import print_function
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Convolution2D, MaxPooling2D, Dense, Flatten, Dropout
from keras.optimizers import SGD
from keras.utils import np_utils
from keras import backend as K
import numpy as np
import time


np.random.seed(123)  


(X_train, y_train), (X_test, y_test) = mnist.load_data()

if K.image_dim_ordering() == 'th':
    X_train = X_train.reshape(X_train.shape[0], 1, 28, 28)
    X_test = X_test.reshape(X_test.shape[0], 1, 28, 28)
    input_shape = (1, 28, 28)
else:
    X_train = X_train.reshape(X_train.shape[0], 28, 28, 1)
    X_test = X_test.reshape(X_test.shape[0], 28, 28, 1)
    input_shape = (28, 28, 1)

X_train = X_train.astype('float32') / 255
X_test = X_test.astype('float32') / 255
Y_train = np_utils.to_categorical(y_train, 10)
Y_test = np_utils.to_categorical(y_test, 10)


model = Sequential()
model.add(Convolution2D(32, (4, 4), input_shape = input_shape, activation = 'relu'))
model.add(MaxPooling2D(pool_size = (2,2)))
model.add(Convolution2D(16, (3, 3), activation = 'relu'))
model.add(MaxPooling2D(pool_size = (2,2)))
model.add(Dropout(0.2))

model.add(Flatten())
model.add(Dense(128, activation = 'relu'))
model.add(Dense(64, activation = 'relu'))
model.add(Dense(10, activation = 'softmax'))
sgd = SGD(lr=0.05, decay=1e-5, momentum=0.9)
model.compile(loss = 'categorical_crossentropy', optimizer = sgd, metrics = ['accuracy'])


start = time.time()
model.fit(X_train, Y_train, batch_size = 128, epochs = 10)
end = time.time()
print('Train time:', end - start, 'sec')


metrics = model.evaluate(X_test, Y_test, verbose=0)
print('Error rate:', 100*(1-metrics[1]), '%')

