
set.seed(123)
iris_shuff <- iris[sample(nrow(iris)),]

d <- iris_shuff[,-5]

# assume we know k=3
km <- kmeans(d, 3)
km
km$centers

pairs(d)
pairs(d, col = km$cluster)


# usually k is unknown

# cluster number indices
# http://www.jstatsoft.org/index.php/jss/article/view/v061i06/v61i06.pdf
library(NbClust)
nb <- NbClust(d, method = "kmeans", 
              min.nc = 2, max.nc = 10, index = "all")
nb
#table(nb$Best.nc["Number_clusters",])

#table( nb$Best.partition[order(as.numeric(names(nb$Best.partition)))], 
#  km$cluster[order(as.numeric(names(km$cluster)))] )


# for this problem we know the "true" clusters
c0 <- iris_shuff[,5]

table(c0, km$cluster)

pairs(d, col = km$cluster)
pairs(d, col = c0)

