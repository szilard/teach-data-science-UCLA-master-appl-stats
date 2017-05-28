
set.seed(123)
iris_shuff <- iris[sample(nrow(iris)),]

d <- iris_shuff[,-5]

dd <- dist(d)
hc <- hclust(dd, method = "average")
dend <- as.dendrogram(hc)
plot(dend)
rm(dd, hc, dend)

dend <- as.dendrogram(hclust(dist(d), method = "average"))
plot(dend)

#library(dplyr)
library(magrittr)
dend <- d %>% dist %>% hclust(method = "average") %>% as.dendrogram
plot(dend)


library(dendextend)

dend %>% set("labels", NA) %>% plot
dend %>% set("labels", NA) %>% set("branches_k_color", k = 3) %>% plot
dend %>% set("labels", NA) %>% set("branches_k_color", k = 4) %>% plot

dend %>% set("labels", NA) %>% hang.dendrogram(0) %>% plot



# for this problem we know the "true" clusters
c0_rn <- iris[,5]    # index by orig iris row numbers

dend %>% set("labels", NA) %>% 
  set("leaves_pch", 1) %>% set("leaves_cex", 0.4) %>%  
  set("leaves_col", as.numeric(c0_rn[as.numeric(labels(dend))])) %>% 
  hang.dendrogram(0) %>% plot

ck3 <- cutree(dend, k = 3)
table(c0_rn[as.numeric(names(ck3))], ck3)

for (m in c("average","complete","single")) {
d %>% dist %>% hclust(method = m) %>% as.dendrogram %>% 
  set("labels", NA) %>% 
  set("leaves_pch", 1) %>% set("leaves_cex", 0.4) %>%  
  set("leaves_col", as.numeric(c0_rn[as.numeric(labels(dend))])) %>% 
  hang.dendrogram(0) %>% plot(main = m)
}  
  
# more analysis
# https://cran.r-project.org/web/packages/dendextend/vignettes/Cluster_Analysis.html
  
