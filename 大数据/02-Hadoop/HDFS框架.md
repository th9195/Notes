# HDFS的架构

- HDFS采用Master/Slave架构，一个HDFS集群有两个重要的角色，分别是Namenode和Datanode。Namenode是管理节点，负责管理文件系统的命名空间(namespace)以及客户端对文件的访问。Datanode是实际存储数据的节点。HDFS暴露了文件系统的命名空间，用户能够以操作文件的形式在上面操作数据。

- HDFS的四个基本组件:<span style="color:red;background:white;font-size:18px;font-family:楷体;">HDFS Client、NameNode、DataNode和Secondary NameNode</span>。

![07-HDFS框架](.\image\07-HDFS框架.png)

## Client：

​	就是客户端。

- 文件切分。文件上传 HDFS 的时候，Client 将文件切分成 一个一个的Block，然后进行存储；
- 与 NameNode 交互，获取文件的位置信息。
- 与 DataNode 交互，读取或者写入数据。
- Client 提供一些命令来管理 和访问HDFS，比如启动或者关闭HDFS。



## NameNode：

​	就是 master，它是一个主管、管理者。

- 管理 HDFS 的名称空间；
- 管理数据块（Block）映射信息；
- 配置副本策略；
- 处理客户端读写请求；



## DataNode：

​	就是Slave。NameNode 下达命令，DataNode 执行实际的操作。

- 存储实际的数据块。block块
- 执行数据块的读/写操作。
- 定时向namenode汇报block信息；



## Secondary NameNode：

​		并非 NameNode 的热备。当NameNode 挂掉的时候，它并不能马上替换 NameNode 并提供服务。

- 辅助 NameNode，分担其工作量。
- 定期合并 fsimage和fsedits，并推送给NameNode。
- 在紧急情况下，可辅助恢复 NameNode。