
library(h2o)

h2o.init(nthreads=-1)


dx <- h2o.importFile("wk-06-ML/data/airline100K.csv")

dx_split <- h2o.splitFrame(dx, ratios = 0.6, seed = 123)
dx_train <- dx_split[[1]]
dx_test <- dx_split[[2]]


Xnames <- names(dx_train)[which(names(dx_train)!="dep_delayed_15min")]

system.time({
  md <- h2o.glm(x = Xnames, y = "dep_delayed_15min", training_frame = dx_train, 
                family = "binomial", alpha = 1, lambda = 0)
})



h2o.auc(h2o.performance(md, dx_test))


md

## inspect in flow

