# 周五R测试的内容：

> 我们经过了四周的分享，把R的整理数据，基础画图，ggplot2 画图以及从分析数据到报告的过程进行了了解。我们现在已经基本可以用到课堂内容进行数据矩阵的整理最后画出能用于文字发表的图

考核的内容也是这一过程的应用：我打算用两个Fig的生成进行考核，第一个是散点图[60%]，第二个是折线图(也可以使用散点图展示)[40%]。
我将从结果顺利展示[30%]，代码顺利运行[30%]，执行效率[15%],和代码规范[25%]四个方面进行评价。

--------
### Task.1 Generate a volcano graph for DEG data. (difficulty:* ;60%)
![Figure.1](https://github.com/bioteller/R_Playground/blob/master/BlackFriday/Fig1.png)
1. Read the data into R from github repo. 
```sh
ask xiaobo for datapath
```
2. Please draw a scatter graph (log2FoldChange vs -log(p.adj)) by R base-tools or ggplot2. (need collate and compute in advance)
3. Color the dots in red, green for up- or down-regulated genes whose p.adj < 0.05, while gray for rest.
4. Title the graph as "Figure.1 Volcano Graph"
5. (optional) Add a horizon line in gray showing p.adj = 0.05
6. (optional) Encapsulation if possible.

--------

### Task.2 Generate a GC distribution map. (difficulty:*** ;40%)
![Figure.2](https://github.com/bioteller/R_Playground/blob/master/BlackFriday/Fig2.png)
1. Read the data into R from github repo.
```sh
ask xiaobo for datapath
```
2. Please draw a line chart (x=pos,y=base%) by R base-tools or ggplot2. (need collate and compute in advance)
3. Title the graph as "Figure.2 GC distribution"
4. (optional) Encapsulation if possible.

FYI: might need melt() function to change the wide- to long-format matrix, and then use ggplot2 for ploting.
```R
head(original)
##        N       A       C       T       G pos
## 1 0.00044 0.21212 0.26264 0.05120 0.47360   1
## 2 0.00000 0.18766 0.28970 0.32026 0.20238   2
## 3 0.00000 0.19334 0.32042 0.27598 0.21026   3
## 4 0.00000 0.14242 0.38242 0.32514 0.15002   4
## 5 0.00000 0.33694 0.17736 0.30862 0.17708   5
## ...
## 149 0e+00 0.21234 0.20236 0.30840 0.27690 149
## 150 0e+00 0.21130 0.19410 0.32916 0.26544 150

df <- melt(original,id.vars=c("pos"))
head(df)
##  pos variable   value
## 1   1        N 0.00044
## 2   2        N 0.00000
## 3   3        N 0.00000
## ...
## 150 150      G 0.24000
## 150 150      T 0.36000

ggplot(df,aes(x=pos,y=value,group=variable,color=variable)) 
  + geom_line()
```
