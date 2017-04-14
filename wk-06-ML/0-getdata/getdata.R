
# 100K rows from the airline data set
# see https://github.com/szilard/benchm-ml

data_url <- "https://s3.amazonaws.com/benchm-ml--main/train-0.1m.csv"
data_localfile <- "wk-06-ML/data/airline100K.csv"
download.file(data_url, data_localfile)

