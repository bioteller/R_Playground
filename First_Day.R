#### 向量 ####
vec1 <- c(1,4,7,9,13,17,19,23,29) 
vec1[c(5,6,7)]; vec1[5:7] # 得到的结果是一样的 都是 c(13,17,19)
which(vec1==19)
vec1[c(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE,FALSE)]

#### 戏说数字  ####
rnorm(2)
set.seed(12345)
x <- rnorm(5)
x
y <- rnorm(5)
y

abs(-9)

####  字符串处理函数 ####
## 1
str1 <- "GB_PAG denovo.1"
strsplit(str1," ")

strsplit(str1,"[ _]")
strsplit(str1,"[.]")

## 2
str1 <- "Novogene GB_PAG"
str2 <- "Pb-assembly"
paste(str1,str2,sep="_")

product <- c("QC","assembly","annotation")
num <- c(1,2)
paste(num,product)
paste(str1,product)

## 计算字符串长度：nchar( )
nchar(str1)
# 顺便说一下计算数组和数据框长度的方法
nchar(product)
length(product)

m <- runif(12,10,20)
mtx1 <- matrix(m,nrow = 3,ncol = 4)
dim(mtx1)
nrow(mtx1);ncol(mtx1)

dim(m) <-c(3,4)
class(m)

# 字符串截取函数：substr( )及substring( )
substr("GB_PAG",4,6)
substring("GB_PAG", 1:3, 4:5)
strsplit("GB_PAG","")

substring("ATATCTGCCGTATGA", c(1,3,5), c(4,6,9))

# chartr

x <- "MiXed cAsE 123 ii"
chartr("ise", "why", x)
chartr("ACTG","TGAC","ATATCTGCCGTATGA")
chartr("ACTG","atcg","ATATCTGCCGTATGA")

# 大小写转换函数
news <- "The number of coronavirus cases in the United States has topped 300,000, with more than 8,000 fatalities."
toupper(news)
tolower(news)
casefold(news,upper = vice)


# 一个小练习

df_lst <- read.table("PJNAME.txt",header = F,col.names = "PJ_name",stringsAsFactors = F)
head(df_lst)
strsplit(df_lst[1,1],"[.]")

x = c()
for (i in df_lst$PJ_name){
  x <- rbind(x,strsplit(i[1],"[.]")[[1]])
}
x
df_proj <- as.data.frame(x)
colnames(df_proj) <- c("ContactID","Type","SeqStra","InnitalDate","BatchID")

pie(table(df_proj$Type))
barplot(table(df_proj$ContactID))
hist(table(df_proj$ContactID),freq = T)
