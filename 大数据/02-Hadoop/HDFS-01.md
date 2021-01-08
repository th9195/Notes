# HDFS分布式文件系统

## HDFS概述



### DFS

1. 分布式文件系统
2. 多台计算机共同来存储文件

### HDFS 

1. HDFS是分布式文件系统的一种；
2. HDFS 来自于google GFS 论文；
3. 适合存大文件；
4. 一次写入多次读取	不适合修改；
5. 延迟高；



## HDFS结构

- ​	四个基本组件: 
  - HDFS Client；
  - NameNode （老大） ；
  - DataNode （小弟）；
  - Secondary NameNode

### Client：就是客户端。

1. **文件切分**。文件上传 HDFS 的时候，Client 将文件切分成 一个一个的Block，然后进行存储；
2. 与 NameNode 交互，获取文件的位置信息；
3. 与 DataNode 交互，读取或者写入数据；
4. Client 提供一些命令来管理 和访问HDFS，比如启动或者关闭HDFS；



### NameNode：

​	就是 master，它是一个主管、管理者。

1. 管理 HDFS 的名称空间  （对外界提供  **一个**  完整的访问路径）(元数据)

2. 管理数据块（Block）映射信息 (元数据)

3. 配置副本策略 （存多少个副本）

4. 处理客户端读写请求。



### 元数据

​	内存：

​	存储数据的相关信息  权限 大小 日期 拥有者 block 信息

​	block 信息：

​			block1 : node1  node2(副本)  node3(副本)

​			block2 : node2  node1(副本)  node3 (副本)

​			block3 : node3  node1(副本)  node2 (副本)



### DataNode：

​	就是Slave。NameNode 下达命令，DataNode 执行实际的操作。

1. 存储实际的数据块。block块	
2. 执行数据块的读/写操作。
3. 定时向namenode汇报block信息

### Secondary NameNode：

​	并非 NameNode 的热备。当NameNode 挂掉的时候，它并不能马上替换 NameNode 并提供服务。

1. 辅助 NameNode，分担其工作量。
2. 定期合并 fsimage和fsedits，并推送给NameNode。
3. 在紧急情况下，可辅助恢复 NameNode。



## HDFS的数据读写流程



### HDFS写数据流程











![01-文件的写入流程](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\01-文件的写入流程.png)

### HDFS读数据流程







![02-文件的读取过程](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\02-文件的读取过程.png)













​	