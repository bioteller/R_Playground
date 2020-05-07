## 周五R检测的内容：

> 我们经过了四周的分享，吧R的整理数据，基础画图，ggplot2 画图以及从分析数据到报告的过程进行了了解。我们现在已经基本可以用到课堂内容进行数据矩阵的整理最后画出能用于文字发表的图

考核的内容也是这一过程的应用：我打算用两个Fig的生成进行考核，第一个是散点图[60%]，第二个是折线图(也可以使用散点图展示)[40%]。
我将从结果顺利展示[30%]，代码顺利运行[30%]，执行效率[15%],和代码规范[25%]四个方面进行评价。

--------
Task.1 Generate a volcano graph for DEG data. (difficulty:* ;60%)
![Figure.1](https://github.com/bioteller/R_Playground/blob/master/BlackFriday/Fig1.png)
1. Read the data into R from github repo. 
```sh
wget https://github.com/bioteller/R_Playground/blob/master/BlackFriday/exam.csv
```
2. Please draw a scatter graph (log2FoldChange vs -log(p.adj)) by R base-tools or ggplot2. (need collate and compute in advance)
3. Color the dots in red, green for up- or down-regulated genes whose p.adj < 0.05, while gray for rest.
4. Title the graph as "Figure.1 Volcano Graph"
5. (optional) Add a horizon line in gray showing p.adj = 0.05
6. (optional) Encapsulation if possible.

Task.2 Generate a GC distribution map. (difficulty:*** ;40%)
![Figure.2](https://github.com/bioteller/R_Playground/blob/master/BlackFriday/Fig2.png)
1. Read the data into R from github repo.
```sh
wget https://github.com/bioteller/R_Playground/raw/master/BlackFriday/RT4_CKDL200148623-1a_H7HGGCCX2_L5_1.fastq
wget https://github.com/bioteller/R_Playground/raw/master/BlackFriday/RT4_CKDL200148623-1a_H7HGGCCX2_L5_2.fastq
```
2. Please draw a line chart (x=pos,y=base%) by R base-tools or ggplot2. (need collate and compute in advance)
3. Title the graph as "Figure.2 GC distribution"
4. (optional) Encapsulation if possible.

