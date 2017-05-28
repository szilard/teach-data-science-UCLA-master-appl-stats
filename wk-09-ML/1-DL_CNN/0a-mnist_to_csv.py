
from keras.datasets import mnist
import numpy as np

(X_train, y_train), (X_test, y_test) = mnist.load_data()

np.savetxt("X_train.csv",X_train.reshape(60000,28*28), fmt="%u", delimiter=',')
np.savetxt("X_test.csv",X_test.reshape(10000,28*28), fmt="%u", delimiter=',')
np.savetxt("y_train.csv",y_train, fmt="%u")
np.savetxt("y_test.csv",y_test, fmt="%u")


