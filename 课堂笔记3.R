#### R class s3 ####
# Xiaobo Li
# 2020-4-4
# Handouts:
# 演示代码：https://github.com/bioteller/R_Playground


log(c(1,2,3)+12)

rm(list=ls())
library(ggplot2)
library(car)
#### 1.直方图 ###
data <- mtcars
head(data)
ggplot(data, aes(x=rownames(data),y=hp,fill=gear)) +
  geom_bar(stat = "identity") + 
  scale_fill_gradient(low="gray",high="red") +
  labs(x="HP (horse power)",y = "caar",title = "cars") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45,vjust = -0.0000001,hjust = 0.35)) 
  

ggplot(data, aes(x=hp)) +
  stat_bin(binwidth = 100) 

#### 2.散点图 ####
ggplot(data2, aes(x=hp,y=cyl,fill=mpg,color=gear)) +
  geom_point(pch=21,size=5,alpha=0.5) +
  scale_fill_gradient(low='gray',high='red') +
  scale_color_gradient(low='yellow',high='blue') +
  scale_x_continuous(breaks = c(100,200,300),labels = letters[1:3],limits = quantile(data2$hp,probs = c(0,1))) +
  scale_y_continuous(position = "right",breaks = c(2,4,6,8), labels = LETTERS[1:4],limits = c(2,8)) +
  labs(x="horse power",y="cylinda") + 
  guides(color=F, fill=guide_legend(override.aes = list(color=c("yellow","blue"),fill=c("white","red"))))+
  ggtitle("Figure.1 Car Facility") 

head(diamonds)

ggplot(diamonds,aes(x=carat,y=price)) + 
  geom_point(pch=21,fill = 'lightblue', color= "", alpha = 0.03) + 
  ggtitle("dimands Wang")+
  theme(panel.background = element_rect(fill = "black",color = "white"),
        panel.grid.major = element_line(colour = "lightyellow",size = 2),
        panel.grid.minor = element_line(colour = "gold",size = 1),
        axis.title.x = element_text(size = 13,colour = "red",angle = 45),
        plot.background = element_rect(fill = "gray"),
        title = element_text(face = "bold",hjust = 0.5))



# 密度
# Data
a <- data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 10, 1.2) )
b <- data.frame( x=rnorm(20000, 14.5, 1.9), y=rnorm(20000, 14.5, 1.9) )
c <- data.frame( x=rnorm(20000, 9.5, 1.9), y=rnorm(20000, 15.5, 1.9) )
data <- rbind(a,b,c)
head(data)
ggplot(data, aes(x=x, y=y) ) +
  geom_density_2d()


ggplot(data, aes(x=x, y=y) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon")


ggplot(data, aes(x=x, y=y) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white")



ggplot(data, aes(x=x, y=y) ) +
  stat_density_2d(aes(fill = ..density..), geom = "raster", contour = FALSE) +
#  scale_fill_distiller(palette= "Spectral", direction=1)+
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(
    legend.position='none'
  )

####  fan  ####
data <- data.frame(
  individual=paste( "GB_PAG ", seq(1,60), sep=""),
  value=sample( seq(10,100), 60, replace=T))
head(data)
data$id <- seq(1, nrow(data))
angle <- 90 - 360 * (data$id-0.5) /nrow(data)
ggplot(data, aes(x=as.factor(id), y=value)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
    geom_bar(stat="identity", fill=alpha(rainbow(60), 0.3)) +
    ylim(-40,120) +
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      plot.margin = unit(rep(-1,4), "cm") 
    ) +
    coord_polar(start = 0) +
    geom_text(data=data, aes(x=id, y=value+10, label=individual), color="black", fontface="bold",alpha=0.6, size=2.5, angle= angle, inherit.aes = FALSE ) 

#### circle ####
#devtools::install_github("mattflor/chorddiag")
library(chorddiag)

# Create dummy data
m <- matrix(c(11975,  5871, 8916, 2868,
              1951, 10048, 2060, 6171,
              8010, 16145, 8090, 8045,
              1013,   990,  940, 6907),
            byrow = TRUE,
            nrow = 4, ncol = 4)

# A vector of 4 colors for 4 groups
haircolors <- c("black", "blonde", "brown", "red")
dimnames(m) <- list(have = haircolors,
                    prefer = haircolors)
groupColors <- c("#000000", "#FFDD89", "#957244", "#F26223")

# Build the chord diagram:
chorddiag(m, groupColors = groupColors, groupnamePadding = 20)


# save the widget
 library(htmlwidgets)
 saveWidget(p, file="chord_interactive.html")

 
#### 词云 ####
#BiocManager::install("wordcloud2")
library(wordcloud2) 
wordcloud2(data=demoFreq, size=1.6)

library(jsonlite)
jsonmessage<-read_json("1.txt",simplifyVector = FALSE)
head(jsonmessage$returndata)

p <- unlist(lapply(jsonmessage$returndata,FUN = function(x) x$projectdesc))
library(stringr)
p2 <- str_match(string = p,pattern = "^([A-Za-z]*)-([A-Za-z]*)-([A-Za-z0-9]*)-")
p2 <- p2[order(p2[,2]),]
tmp <- p2[31:65,2] 
p2[31:65,2] <- p2[31:65,3]
p2[31:65,3] <- tmp
nation = as.data.frame(table(p2[,2]))
nation2 = nation
nation2[,2] = floor(log2(nation2[,2])) #ceiling
wordcloud2(data=nation2,shape = "N")
location = as.data.frame(table(p2[,3]))
wordcloud2(data=location,backgroundColor = "gold")


nation2$id <- seq(1, nrow(nation2))
angle <- 90 - 360 * (nation2$id-0.5) /nrow(nation2)
ggplot(nation2, aes(x=as.factor(id), y=Freq)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_bar(stat="identity", fill=alpha(rainbow(6), 0.3)) +
  ylim(-3,10) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar(start = 0) +
  geom_text(data=nation2, aes(x=id, y=3, label=Var1), color="black", fontface="bold",alpha=0.6, size=2.5, angle= angle, inherit.aes = FALSE ) 

location$id <- seq(1, nrow(location))
angle <- 90 - 360 * (location$id-0.5) /nrow(location)
ggplot(location, aes(x=as.factor(id), y=Freq)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_bar(stat="identity", fill=alpha(rainbow(52), 0.3)) +
  ylim(-2,15) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar(start = 0) +
  geom_text(data=location, aes(x=id, y=Freq+1, label=Var1), color="navy", fontface="bold",alpha=0.6,hjust=-0.1, size=2.5, angle= angle, inherit.aes = FALSE ) 

pc <-unlist(lapply(jsonmessage$returndata,FUN = function(x) x$operatemanagerdesc))
pc2 <- as.data.frame(table(pc))
wordcloud2(pc2)



bi <-unlist(lapply(jsonmessage$returndata,FUN = function(x) x$informationleader))
bi2 <- as.data.frame(table(bi))
wordcloud2(bi2)
    
bi2$id <- seq(1, nrow(bi2))
angle <- 90 - 360 * (bi2$id-0.5) /nrow(bi2)
p<- ggplot(bi2, aes(x=as.factor(id), y=Freq)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  geom_bar(stat="identity", fill=alpha(rainbow(26), 0.3)) +
  ylim(-2,50) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  coord_polar(start = 0) +
  geom_text(data=bi2, aes(x=id, y=Freq+1, label=bi), color="navy", fontface="bold",alpha=0.6,hjust=-0.1, size=2.5, angle= angle, inherit.aes = FALSE ) 

#BiocManager::install("maps")
#BiocManager::install("mapproj")
library(maps)
library(mapproj)
wd <- map_data("world")
data <- world.cities
data[data$country.etc == "USA",]
ggplot() +
  geom_polygon(data = wd, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3)+
  geom_point( data=data.frame(), aes(x=41.08,y=-81.52)) +
  theme_void() + ylim(50,59)  #coord_map() 


ke t
