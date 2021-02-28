# HDFS的高可用机制

## HDFS高可用介绍

- 在Hadoop 中，NameNode 所处的位置是非常重要的，整个HDFS文件系统的元数据信息都由NameNode 来管理，NameNode的可用性直接决定了Hadoop 的可用性，一旦NameNode进程不能工作了，就会影响整个集群的正常使用。 

- 在典型的HA集群中，两台独立的机器被配置为NameNode。在工作集群中，NameNode机器中的一个处于Active状态，另一个处于Standby状态。Active NameNode负责群集中的所有客户端操作，而Standby充当从服务器。Standby机器保持足够的状态以提供快速故障切换（如果需要）。

![08-HDFS高可用机制-01](.\image\08-HDFS高可用机制-01.png)

## 组件介绍

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**Active NameNode 和 Standby NameNode**</span>：两台 NameNode 形成互备，一台处于 Active 状态，为主 NameNode，另外一台处于 Standby 状态，为备 NameNode，只有主 NameNode 才能对外提供读写服务。

 

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**主备切换控制器ZKFC( ZKFailoverController)**</span>：ZKFailoverController 作为独立的进程运行，对 NameNode 的主备切换进行总体控制。ZKFailoverController 能及时检测到 NameNode 的健康状况，在主 NameNode 故障时借助 Zookeeper 实现自动的主备选举和切换。

 

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**Zookeeper 集群**</span>：为主备切换控制器提供主备选举支持。

 

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**元数据信息共享存储系统**</span>：共享存储系统是实现 NameNode 的高可用最为关键的部分，共享存储系统保存了 NameNode 在运行过程中所产生的 HDFS 的元数据。主 NameNode 和备用NameNode 通过共享存储系统实现元数据同步。在进行主备切换的时候，新的主 NameNode 在确认元数据完全同步之后才能继续对外提供服务。

- 原信息共享存储系统主要用于保存 EditLog，并不保存 FSImage 文件。FSImage 文件还是在 NameNode 的本地磁盘上。共享存储采用多个称为 JournalNode 的节点组成的 JournalNode 集群来存储 EditLog。每个 JournalNode 保存同样的 EditLog 副本。每次 NameNode 写 EditLog 的时候，除了向本地磁盘写入 EditLog 之外，也会并行地向 JournalNode 集群之中的每一个 JournalNode 发送写请求，只要大多数 的 JournalNode 节点返回成功就认为向 JournalNode 集群写入 EditLog 成功。如果有 2N+1 台 JournalNode，那么根据大多数的原则，最多可以容忍有 N 台 JournalNode 节点挂掉。

 

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**DataNode 节点**</span>：除了通过共享存储系统共享 HDFS 的元数据信息之外，主 NameNode 和备 NameNode 还需要共享 HDFS 的数据块和 DataNode 之间的映射关系。DataNode 会同时向主 NameNode 和备 NameNode 上报数据块的位置信息。

 

## NameNode 的主备切换实现

- NameNode 主备切换主要由 <span style="color:red;background:white;font-size:20px;font-family:楷体;">**ZKFailoverController、HealthMonitor 和 ActiveStandbyElector **</span>这 3 个组件来协同实现：

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**ZKFailoverController**</span> 作为 NameNode 机器上一个独立的进程启动 (在 hdfs 启动脚本之中的进程名为 zkfc)，启动的时候会创建 HealthMonitor 和 ActiveStandbyElector 这两个主要的内部组件，ZKFailoverController 在创建 HealthMonitor 和 ActiveStandbyElector 的同时，也会向 HealthMonitor 和 ActiveStandbyElector 注册相应的回调方法。

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**HealthMonitor**</span>  主要负责检测 NameNode 的健康状态，如果检测到 NameNode 的状态发生变化，会回调 ZKFailoverController 的相应方法进行自动的主备选举。

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**ActiveStandbyElector**</span>  主要负责完成自动的主备选举，内部封装了 Zookeeper 的处理逻辑，一旦 Zookeeper 主备选举完成，会回调 ZKFailoverController 的相应方法来进行 NameNode 的主备状态切换。

- NameNode 实现主备切换的流程如图 2 所示，有以下几步：
  1. HealthMonitor 初始化完成之后会启动内部的线程来定时调用对应 NameNode 的 HAServiceProtocol RPC 接口的方法，对 NameNode 的健康状态进行检测。
  2. HealthMonitor 如果检测到 NameNode 的健康状态发生变化，会回调 ZKFailoverController 注册的相应方法进行处理。
  3. 如果 ZKFailoverController 判断需要进行主备切换，会首先使用 ActiveStandbyElector 来进行自动的主备选举。
  4. ActiveStandbyElector 与 Zookeeper 进行交互完成自动的主备选举。
  5. ActiveStandbyElector 在主备选举完成后，会回调 ZKFailoverController 的相应方法来通知当前的 NameNode 成为主 NameNode 或备 NameNode。
  6. ZKFailoverController 调用对应 NameNode 的 HAServiceProtocol RPC 接口的方法将 NameNode 转换为 Active 状态或 Standby 状态。

## NameNode 的主备切换流程图

![08-HDFS高可用机制-02](.\image\08-HDFS高可用机制-02.png)

## 高可用集群环境搭建

### 集群运行服务规划

|             | node1       | node2           | node3            |
| ----------- | ----------- | --------------- | ---------------- |
| zookeeper   | zk          | zk              | zk               |
| HDFS        | JournalNode | JournalNode     | JournalNode      |
| NameNode    | NameNode    |                 |                  |
| ZKFC        | ZKFC        |                 |                  |
| DataNode    | DataNode    | DataNode        |                  |
| YARN        |             | ResourceManager | ResourceManager  |
| NodeManager | NodeManager | NodeManager     |                  |
| MapReduce   |             |                 | JobHistoryServer |

请查看手册：

<span style="color:red;background:white;font-size:20px;font-family:楷体;">**.\高可用集群搭建手册\04_HDFS高可用集群搭建.docx**</span>