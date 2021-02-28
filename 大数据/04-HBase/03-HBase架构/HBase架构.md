# 1- HBase 架构图

图片：

​	E:\笔记\MyNotes\Notes\大数据\04-HBase\03-HBase架构\images\01-hbase集群架构.png

![01-hbase集群架构](E:\笔记\MyNotes\Notes\大数据\04-HBase\03-HBase架构\images\01-hbase集群架构.png)

# 2- HMaster 主节点

​		主节点一般有 单个节点、 一主一备、一主多备。 但是一般使用的是**一主一备**

## 2-1 作用

- 管理所有的从节点；

- 分配region; 









# 3- HRegionServer从节点

​		HRegionServer 一般都是一个集群，有多个HRegionServer;

## 3-1 作用

- 管理HMaster 分配过来的region;

- 负责数据的读写操作；

- 负责和主节点进行通信（zookeeper）；

  

## 3-2 从节点结构

- HRegionServer = 1个HLog + n 个Region;
- Region = n个store模块；
- store = 1个memStore + n 个 storefile;





## 3-3 HRegionServer结构详情

### 3-3-1 HLog

- HLog 也叫做 WAL (预写日志)；
- 在写数据之前先写日志并保存；
- HLog 日志是直接追加的方式写到HDFS 磁盘中；
- 如果内存的数据丢失可以在HLog 中找到；



### 3-3-2 memstore 内存空间flush机制

- 默认大小128M;
- 写满128M 或者 一个小时候 就溢写（flush）到一个文件storeFile(小Hfile)；



### 3-3-4 文件合并compact机制

- 当storefile 达到一定数量后就会合并storeFile生成一个大的Hfile文件；（compact合并压缩机制）

- storefile 一般有3个以上就会合并；



### 3-3-5 大HFile 文件切分机制（split）

- 当HFile 被合并到一定大后就会被切分；
- 阈值：10GB；
- 具体切分大小计算公式：Min( region 个数的平方 * 128M，10Gb);
- HFile 被切分后就会生成两个新的region，之前的region挂掉；
- 一个region只能管理一个大的HFile;



### 3-3-6 region

- region是对表的水平划分；
- 默认情况下，一个表在初始创建时只有一个region;
- 一个region只能被一个regionserver 所管理； 
- 一个regionserver可以管理多个region;
- 一个region只能管理一个大的HFile文件；



### 3-3-7 store模块

- store 是对表的垂直划分；
- 一个store模块就代表一个列族；
- 列族的数量决定了在一个region 中store模块的数量；
- store 模块越多，在读取数据的时候跨越文件读取就越复杂，导致磁盘IO变大，导致效率降低。（**这就是不建议在建表时创建多个列族**）