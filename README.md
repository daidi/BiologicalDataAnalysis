Biological Data Analysis
====
##Introduction And Main Function
This is a JSP Project used to analysis Biological Data which comes from University of California Santa Cruz (UCSC) .

这是一个用于进行生物大数据分析的JSP项目，生物数据来自美国加州大学圣克鲁兹分校。

The whole project contains two main functions :

First , it can analysis the big data of biological ,then parse it and translate it to the curve chart to make people easy find what it really shows .Also , it will generate it into a matrix ,which could be further handled with algorithms ,I made a button for users ,so you can download the result easily.

Second , it could handle the result of analysis which mentioned before ,and use the algorithms to handle the result .For the choose of data mining algorithm depends on different situation we use this project ,so I made a FP-growth algorithm for show only . And to make the algorithm more flexible and easy to understand ,I use WEKA to solve this ,so you can modify it easily . 

You can find more detail in the project , such as mutil-process , if you are interested in this repo .

##System Introduction
This web server is an online tool that allows you to use large reference epigenome datasets for your own analysis. The dataset consists of  18 cell types ,262 kinds of histone modification data,and about 260000 transictions.  

To fully explore the spatial and combinatorial patterns in ChIP-profiling data, this web server enable users to query, detect and visualize potentially meaningful patterns. We developed a user-friendly graphical interface for quick navigation and analysis of histone modification peak for specific genomic locations, function regions in various cellular contexts. 

##Function Introduction：
* Query：Given the specific location, users can search the genomic region of interest and obtain the histone modification information. More conveniently, by submitting a file, the web server can execute a batch of search.  
 
* Visualize: Through a series of line, bar figures, this web server enable users to visualize the query result intuitively. 
 
* Analyze:  By introducing the association rule tool (FP-growth), we further analyze the histone modification data. The aim is to identify the combinatorial histone modification pattern in the functional regions.  

##ScreenShots/截图：

1.homepage/首页
![image](https://github.com/daidi/BiologicalDataAnalysis/raw/master/img/homepage.png)

2.query/数据查询
![image](https://github.com/daidi/BiologicalDataAnalysis/raw/master/img/query.png)

3.chart/图表展示
![image](https://github.com/daidi/BiologicalDataAnalysis/raw/master/img/chart.png)

4.result/结果展示
![image](https://github.com/daidi/BiologicalDataAnalysis/raw/master/img/result.png)

5.analysis/数据分析
![image](https://github.com/daidi/BiologicalDataAnalysis/raw/master/img/analysis.png)
