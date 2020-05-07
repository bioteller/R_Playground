# homework-3 

# ggplot2 画
library(data.table)
library(stringr)
library(ggplot2)

rm(list=ls)
homework3 <- fread("SRR4238038_filtered.vcf",data.table = F)
head(homework3)

str_match(homework3$SRR4238038,pattern = "^[0-9/]*:[0-9,]*:([0-9]{1,})")[1:10,2]

hw3 <- function(x) {
  home3 <- x
  home3$DP <- as.numeric(str_match(home3$SRR4238038,pattern = "^[0-9/]*:[0-9,]*:([0-9]*)")[,2])
  home3 <- home3[which(!is.na(home3$DP)),]
  home3$cluster = dbscan::dbscan(home3[,c("QUAL","DP")],eps = "25",minPts = 70)$cluster

  p <-ggplot(home3,aes(x=QUAL,y=DP,fill=as.factor(cluster))) +
    geom_point(pch=21,color="",alpha=0.2,size=2) + 
    theme_light() 
  print(p)
  return(home3)
}

res <- hw3(homework3)


print(p)


p <- ggplot(data.frame(),aes(x=c(1:10),y=c(12:21))) + 
  geom_point()
plotly::ggplotly(p)
