# homework-3 

# VCF的展示，用QUAL和DEPTH画图

# ggplot2 画
library(data.table)
library(stringr)

homework3 <- fread("SRR4238038_filtered.vcf",data.table = F)
head(homework3)

hw3 <- function(x) {
 
}


plotly::ggplotly(p)
