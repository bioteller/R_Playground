#### R class s2 ####
# Xiaobo Li
# 2020-4-4
# Handouts:
# 演示代码：https://github.com/bioteller/R_Playground
# 参考材料：https://www.jianshu.com/p/a71c52d9e42e

#### 1.过程控制 ####
#### 1.1 循环 ####
# for 循环
for(i in letters){
  print(i)
}


mat1 <- c(1:12)
dim(mat1) <- c(3:4)
print(mat1)

# 每一行的和，

m <- c()
for (i in 1:nrow(mat1)){
  m[i] <- sum(mat1[i,])
} 
print(m)

rowSums(mat1)

M <- apply(mat1,1,FUN = function(x) 1+x)

apply(mat1,1,sum)


lst <-list(a=c(1,2,3),b=c(4,5,6))
lst
rbind(lst)

df <- as.data.frame(t(mat1))
df$V1

sapply(as.data.frame(t(mat1)),sum)



as.data.frame(t(mat1))[[1]]

n <- lapply(mat1,sum)


(v <- structure(10*(5:8), names = LETTERS[1:4]))

f2 <- function(x, y) outer(rep(x, length.out = 3), y)
(a2 <- sapply(v, f2, y = 2*(1:5), simplify = "array"))



# while循环
i=1
while(i <= 10){
  print(i)
  i=i+1 
} 

#### 1.2 条件 ####
i <- 1
if(i == 1){
  print("Hello World") 
}
[1] "Hello World"

# If-else 语句
i <- 2
if(i == 1){
  print("Hello World!") 
}else{
  print("Goodbye World!") 
}

if(i == 1){
  print("Hello World!") 
}else{
  print("Goodbye World!") 
}


products = c("denovo", "reseq")
for (i in products){
  print(
    switch(i,
           tr  = "转录调控",
           reseq = "重测序",
           denovo    = "从头组装",
           other  = "其他"
    )
  )
}
i <- "deo"
k <- ifelse(i == "reseq","yes",ifelse(i == "denovo","d","no"))

#### 2.自定义函数 ####
product = function(x = "tr"){
  for (i in x){
    return(
      switch(i,
             tr  = "转录调控",
             reseq = "重测序",
             denovo    = "从头组装",
             other  = "其他"
      )
    )
  }
}
products = c("denovo", "reseq")

out <- product(products)
product()


#### 3.基础画图工具 ####
#### 3.1 散点图 ####
plot(c(1:10),col=rainbow(10),pch=seq(1,20,2),cex=c(1:10))
abline(h=c(2:8),col=c("red","blue"))
abline(v=c(2:8),col=c("red","blue"))
abline(2,3)
text(1,7,"adfwegt",col="blue")

dotchart(c(1:10),seq(1,20,2),col=rainbow(3))
abline(a=c(1,2),b=c(5,7 ),h=c(3,4),col=rainbow(3))
abline(h=c(2:8),col=c("red","blue"))
abline(v=c(2:8),col=c("red","blue"))
legend(x=2,y=7,legend = c("a","b"),pch=c(15,16),col=c("red","blue"))

#### 3.2 柱状图 ####
# shell 

# C202SC18101777,RRA,PE150,20190923,P202SC18101777-01-F001
# C202SC18101777,RRA,PE150,20191203,P202SC18101777-01-F003
# C202SC19020292,Pre-made,PE150,20200320,P202SC19020292-01-F001
# C202SC19020292,Pre-made,PE150,20200320,P202SC19020292-01-F002
# C202SC19020292,Pre-made,PE150,20200320,P202SC19020292-01-F003
# C202SC19030568,RRA,PE150,20200224,P202SC19030568-01-F002
# C202SC19050149,Pre-made,PE150,20200303,P202SC19050149-01-F002
# C202SC19050729,Pre-made,PE150,20200320,P202SC19050729-01-F003
# C202SC19060224,Pre-made,PE150,20200406,P202SC19060224-01-F001

# sed "/\./,/g" 

pl <- read.csv("autop.lst2",header = F)
head(pl)
colnames(pl) <- c("Contract","type","Stratgy","date","batchID")
dim(pl)
pl$month <- strtrim(pl$date,6)
head(pl)
u <- table(pl$type,pl$month)
barplot(u,legend.text = rownames(u),args.legend = list(x=2,y=250,title="TYPE"),col = rainbow(7))

#### 3.3 饼图 ####
k <- table(pl$type)
pie(k)
fan.plot(k[names(k) %in% c("Pre-made","10XRNA")],labels =names(k[names(k) != "Pre-made"]),radius = 0.5)

summary(mtcars)
table(cut(mtcars$mpg,seq(10,30,by=10,)))

