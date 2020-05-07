# Projects trait

rm(list=ls())
setwd("~/Nutstore Files/.symlinks/Nutstore/Novogene/training/R")
library(data.table)
#  library(Rsamtools)
library(ggplot2)
library(gridExtra)

filesam <- fread("test_ever.sam")
head(filesam,1)

fastas <- filesam$V10[1:1000]
length(fastas)

GC <- function(x){
  gc <- nchar(gsub(pattern = "[ATat]",replacement = "",x))
  pgc <- floor(10000*gc/nchar(x))/100
  return(pgc)
}

pgc1 <- unlist(lapply(fastas,FUN=GC))

length(pgc1)

pbqc <- data.frame(row.names = filesam$V1[1:1000],GC=pgc1,length=nchar(filesam$V10)[1:1000])
head(pbqc)

ln_quan <- as.data.frame(quantile(pbqc$length))
ln_quan$lable <- paste0(rownames(ln_quan),":",ln_quan$`quantile(pbqc$length)`,"bp")
colnames(ln_quan) <- c("len","label")


scatter <- ggplot(pbqc,aes(x=GC,y=length)) +
  geom_point(pch=21,fill=alpha("red",0.2),color=alpha("black",0)) +
  theme(axis.title = element_blank(),axis.text = element_blank()) +
  geom_hline(yintercept = ln_quan$len,color=alpha("gray",0.8)) +
  geom_text(data = ln_quan,aes(x=5,y=len,label=label),size=3,hjust=0,vjust=-0.5)

top <- ggplot(pbqc,aes(x=GC)) + 
  geom_histogram(fill="red",color="red") +
  theme(axis.title.y= element_blank(),axis.text.y = element_blank())

right <- ggplot(pbqc,aes(x=length)) + 
  geom_histogram(fill="red",color="red") +
  coord_flip() +
  theme(axis.title.x= element_blank(),axis.text.x = element_blank())

empty <- ggplot() +
  theme(panel.background = element_rect(fill="white"))

j <- gridExtra::grid.arrange(top,empty,scatter,right, ncol=2, nrow=2,widths=c(4,1),heights=c(1,4))
plot(j)

qclen <- pbqc$length
qclen <- sort(qclen,decreasing = T)[1:40]

labels <- pbqc[which(pbqc$length %in% qclen),]
labels <- labels[order(labels$length,decreasing = T),]
labels$angle <- 90-360 * (c(1:nrow(labels))-0.5) / nrow(labels)

dim(labels)

ggplot(data.frame(),aes(x=c(1:length(qclen)),y=qclen)) +
  geom_bar(stat = "identity",fill = rainbow(length(qclen))) +
  ylim(c(-5000,labels[1,2]*1.2)) +
  coord_polar() + 
  theme(panel.background = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        panel.grid = element_blank(),
        axis.ticks = element_blank()) +
  geom_text(data=labels,
            mapping = aes(x=c(1:nrow(labels)),y=length,label=paste0(length,"bp")),
            angle=labels$angle,size=3,hjust=-0.2) 



pie <- fread("snp.table.xls",data.table = F)[1:12,]
exon_id <- grep("Exonic",x = pie$Category)
small <- pie[exon_id,]
large <- pie[-exon_id,]
large <- rbind(large, c("Exon",sum(pie[exon_id,2])))
sum(pie[grep("Exonic",x = pie$Category),2])

draw <- large[which(large$O2_110_5 >0),]

par(mfrow=c(1,2))
pie(as.numeric(draw$O2_110_5),labels=draw$Category)
legend(1,1,pie$Category)
pie(as.numeric(small$O2_110_5),labels=small$Category,radius=0.3)
?pie
draw$label <- cumsum(draw$O2_110_5)
draw$id <- as.factor(1:nrow(draw))
library(ggrepel)

left <- ggplot(draw[draw$id,],aes(x=1,y=as.numeric(O2_110_5),fill=Category)) + 
  geom_bar(stat="identity",position = "stack",show.legend = F) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  geom_label_repel(draw,mapping = aes(x=1,y=label-50000,label=Category),parse = T,show.legend = F,size=2)  +
  coord_polar(theta = "y") 


small$label <- cumsum(small[c(3,1,2,4,5),2])
draws<-small[which(small$O2_110_5 !=0),]
draws$Category<-gsub(pattern = " ", replacement = "_",draws$Category)
 right <- ggplot(draws,aes(x=1,y=as.numeric(O2_110_5),fill=Category)) + 
   geom_bar(stat="identity",position = "stack",show.legend = F) +
   theme(panel.background = element_blank(),
         panel.grid = element_blank(),
         axis.title = element_blank(),
         axis.text = element_blank(),
         axis.ticks = element_blank())+
   geom_label_repel(draws,mapping = aes(x=1,y=label-500,label=Category),parse = T,show.legend = F,size=2)  +
   coord_polar(theta = "y")
 
grid.arrange(left,right,ncol=2,widths=c(5,3))

library(dplyr)
draws$label <- c(36071,36215,35066,92680)

 draws %>% mutate(Category,percent_rank(Category)) %>% select(Category,everything()) %>%
  ggplot(aes(x=0,y=as.numeric(O2_110_5),fill=Category)) + 
  geom_bar(stat="identity",position = "stack",show.legend = F) +
  theme(panel.background = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  geom_label_repel(mapping = aes(x=c(0.35),y=label-O2_110_5/2,label=Category),
                   show.legend = F,
                   min.segment.length = 0,size=2,
                   nudge_x = 0.1,nudge_y = 4,force = 1) +
  coord_polar(theta = "y")


  ggplot(draws,aes(x=1,y=as.numeric(O2_110_5),fill=Category)) + 
  geom_bar(stat="identity",position = "stack",show.legend = F)

