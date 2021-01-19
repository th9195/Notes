### 配置Windows下Hadoop环境

​	在windows上做HDFS客户端应用开发，需要设置Hadoop环境,而且要求是windows平台编译的Hadoop,不然会报以下的错误:

#### 缺少winutils.exe

​	Could not locate executable null \bin\winutils.exe in the hadoop binaries 

#### hadoop.dll

​	Unable to load native-hadoop library for your platform… using builtin-Java classes where applicable 

#### 搭建步骤

- 第一步：将已经编译好的Windows版本Hadoop解压到到一个没有中文没有空格的路径下面

- 第二步：在windows上面配置hadoop的环境变量： HADOOP_HOME，并将%HADOOP_HOME%\bin添加到path中

![img](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\windows-hadoop环境变量-01.jpg) 

![img](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\windows-hadoop环境变量-02.jpg) 

 

- 第三步：把hadoop2.7.5文件夹中bin目录下的hadoop.dll文件放到系统盘:  C:\Windows\System32 目录