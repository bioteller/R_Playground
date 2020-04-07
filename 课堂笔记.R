#### R class s1 ####
# Xiaobo Li
# 2020-4-7
# Handouts:
# 演示代码：https://github.com/bioteller/R_Playground
# 参考材料：https://www.jianshu.com/p/974430e9a662

#### 00.安装Rstudio ####
# Rstudio[v1.25] https://rstudio.com/products/rstudio/download/
# R[v4.0] https://www.r-project.org
# CRAN https://cran.r-project.org/mirrors.html
# bioconductor http://www.bioconductor.org

sessionInfo()
rm(list=ls())
# 如果想用一个包必须先要安装和加载。一般来说，一个包会有很多依赖的包，这些依赖的包也会相互引用，
# 最终就形成了一个庞大繁杂的社区，对于R来说可能是 r-cran，对于我们生物计算信息来说更加喜欢使用
# bioconductor。在这样的社区里面 我们只需要关系最终使用的是什么包，其中的相互依赖，相互做用的包
# 的内在关系，社区以及为我们统计整合，我们直接安装 就安装了这个包所需要的整个生态。很方便是吧。
# 安装R包通常使用下面的语句， 你要有写入的权限
install.packages('PackageName')
install.packages('data.table')
# 安装之后我们就可以对其进行加载 然后使用其中的函数 方法和过程
library('PackageName')
library(data.table)
# 升级包可以选择从头安装或者，但是你要有较高的权限
update.packages('data.table')

# 还有能让我们十分开心的bioconductor社区
# 首先我们需要安装bioconductor对包管理的包
install.packages('BiocManager')
# 安装之后我们就可以安装任何在Bioconductor维护的包了
BiocManager::install('PackageName')

# 还有一种常用的包不规范或者时间紧 或者只是内部使用而没能进入任何社区，他们把包传到一个自己
# 的服务器或者公共区域进行维护，譬如 github
install.packages('devtools') 
devtools::install_github("bioteller/NovoEnrich")
library(NovoEnrich)

#借此机会 也推下我维护的这两个包
install.packages("devtools")
devtools::install_github("bioteller/scolocate.XL")

#### 01.向量 ####
# 向量是个很奇怪的存在，叫她向量是因为她的翻译是如此，其实日常工作中还是习惯叫一维数组。例如：
# `vec1 <- c(1,4,7,9,13,17,19,23,29) ` 
# 或者
# `vec2 <- c('reseq','tr','denovo')`
# 数组可以被整个或部分截取(下标在R中是从1开始的)

vec1 <- c(1,4,7,9,13,17,19,23,29) 
vec1[c(5,6,7)]; vec1[5:7] # 得到的结果是一样的 都是 c(13,17,19)
which(vec1==19)
vec1[c(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE,FALSE)]

#### 02.戏说数字  ####
# 在工作中总是要生存一些随机数字，荷塘算法就需要这样的操作。
# 取10个 随机数字要求是小于10的正整数,如：
# `runif(10, min=0, max=10)`
# 对数据还有一些四舍五入和其他的数据操作，这些内置函数都能涵盖，如：
# ` floor(num); ceiling(num);round(num,4); abs(num)`
# 提了随机函数 顺便提一句 抽取，放回抽取和 不放回抽取 
# `sample（x,n,replace=F,prob=NULL）`
# set.seed()这个函数能够固定下你的随机方案，这样就能实现随机的可重复。

runif(10, min=0, max=10)
rnorm(2)
set.seed(12345)
x <- rnorm(5)
set.seed(12345)
y <- rnorm(5)

x;y

abs(-9)

#### 03.字符串处理函数 ####

# 字符串处理在R语言中并不是十分强项 但是其使用的频率也很高。尽管R语言提供了很多字符串操作函数，
# 但是我们在实际使用的时候 还是会优先使用stringr等文字处理包，以下是基础包常用的字符串函数。
# 字符串分割函数：strsplit( )
# 字符串分割是我们常用的功能，在R里面字符串处理其实是弱项，但是也是有一些基础功能是比较常用的，
# 譬如按照分隔符分割字符串成列表的strsplit
str1 <- "GB_PAG denovo.1"

strsplit(str1," ")
strsplit(str1,".")

# 如果想按照两个分隔符分割字符串的时候，那可能需要多次split，然而这个strsplit却出人意料的支持
# 正则的写法，这就为这个函数扩展了更多用途。我先抛个砖引个更大的砖。
strsplit(str1,"[ _]")
strsplit(str1,"[.]")

# 字符串连接函数：paste( )，paste0()
str1 <- "Novogene GB_PAG"
str2 <- "Pb-assembly"
paste(str1,str2,sep="")
paste(str1,str2,sep="-")
paste0(str1,str2)

# paste字符串和数组，甚至数组和数组会怎么样的，其实 试试便知。
product <- c("QC","assembly","annotation")
num <- c(1,2)
length(num)
length(product)
paste(num,product)
paste(str1,product)

## 计算字符串长度：nchar( )
# 计算字符串的长度，同样的如果给定一个数组，会返回每个元素的字符长度。

nchar(str1)
# 计算数组和数据框长度的方法
nchar(product)
length(product)


# 内容不够矩阵来凑，顺便看下如何确定矩阵的长宽。
m <- runif(12,10,20)
m
mtx1 <- matrix(m,nrow = 3,ncol = 4)
dim(mtx1)
mtx1
nrow(mtx1);ncol(mtx1)

dim(m) <-c(3,4)
m
m[1,2]
m[c(1:2),]
class(m)
colnames(m) <- c("col1","col2","col3","col4")
row.names(m) <- c("sample1","sample2","sample3")
m
m["sample1",c("col2","col3")]

# dataframe数据框
df_m <-as.data.frame(m)
class(df_m)
colnames(df_m) <- c("col1","col2","col3","col4")
df_m[,c("col2","col3")]
df_m$col2

# 字符串截取函数：substr( )及substring( )
substr("GB_PAG",4,6)
substring("GB_PAG", c(1:3), c(4:5))
#strsplit("GB_PAG","")

substring("ATATCTGCCGTATGA", c(1,3,5), c(4,6,9))

# chartr

x <- "MiXed cAsE 123 ii"
chartr("iXe", "why", x)
chartr("ise", "why", x)
chartr("ACTG","TGAC","ATATCTGCCGTATGA")
chartr("ACTG","atcg","ATATCTGCCGTATGA")
# "".join([1,2,3])
paste(rev(strsplit("ATATCTGCCGTATGA","")[[1]]),collapse = "")

# 大小写转换函数
news <- "The number of coronavirus cases in the United States has topped 300,000, with more than 8,000 fatalities."
toupper(news)
tolower(news)
casefold(news,upper = F)

#### 04.读入外部文件 ####
# 我们要做自己的统计分析计算过程，就要进行输入 输入的方式有好多种，其中最有效的就是
# 直接写进去，这样肯定是最方便也是最不靠谱的一种方式，读入文件可以方便的衔接其他软
# 件们也方便分享等。
# read.csv和read.table有啥不一样
df_lst <- read.table("./PJNAME.txt",header = F, col.names = "PJ_name",stringsAsFactors = F)


#此外现在有比较不错的就是 基于c开发的快速读入文件的包data.table::fread, 能极速读入超大文件。

#### 05.绘图 ####
# R语言基础包帮助直接使用：help（funciton）查找，本节对萌新友好，从最简单的点图开始吧。
# 5.1 点图
library(car)
dotchart(mtcars$mpg,labels = row.names(mtcars),cex = .7,
         main = "Gas Mileage",
         xlab = "MPG")
head(mtcars)
pie_cyl <- table(mtcars$cyl)

pie(pie_cyl)





