# apache Phoenix介绍

​		apache Phoenix主要是基于Hbase一款软件, 提供了一种全新(SQL)的方式来操作hbase中数据, 从而降低了使用hbase的门槛, 并且 Phoenix提供了各种优化措施



- Apache Phoenix让Hadoop中支持低延迟OLTP（on Lone transaction processing）联机事务处理和业务操作分析。
  - 提供标准的SQL以及完备的ACID[**事务支持**]()
  - 通过利用HBase作为存储，让NoSQL数据库具备通过有模式的方式读取数据，我们可以使用SQL语句来操作HBase，例如：创建表、以及插入数据、修改数据、删除数据等。
  - Phoenix通过 **[协处理器]()** 在服务器端执行操作，最小化客户机/服务器数据传输；（在服务器上过滤结果）
  - Apache Phoenix可以很好地与其他的Hadoop组件整合在一起，例如：Spark、Hive、Flume以及MapReduce
- **使用Phoenix 是否会影响HBase的性能呢?** 
  - Phoenix不会影响HBase性能，反而会提升HBase性能（可以使用二级索引）
  - Phoenix将SQL查询编译为本机HBase扫描
  - 确定scan的key的最佳startKey和endKey
  - 编排scan的并行执行
  - 将WHERE子句中的谓词推送到服务器端
  - 通过协处理器执行聚合查询
  - 用于提高非行键列查询性能的**[二级索引]()**
  - 统计数据收集，以改进并行化，并指导优化之间的选择
  - 跳过扫描筛选器以优化IN、LIKE和OR查询
  - 行键加盐保证分配均匀，负载均衡

# 安装Phoenix

请查看pyoenix 安装文档

E:\笔记\MyNotes\Notes\大数据\04-HBase\05-Phoenix\pyoenix安装