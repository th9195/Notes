## ZooKeeper集群搭建

​		Zookeeper集群搭建指的是ZooKeeper分布式模式安装。通常由2n+1台server组成。这是因为为了保证Leader选举（基于Paxos算法的实现）能过得到多数的支持，所以ZooKeeper集群的数量一般为奇数。

​		Zookeeper运行需要java环境，所以需要提前安装jdk。对于安装leader+follower模式的集群，大致过程如下：

- 配置主机名称到IP地址映射配置

- 修改ZooKeeper配置文件

- 远程复制分发安装文件

- 设置myid

- 启动ZooKeeper集群

  

如果要想使用Observer模式，可在对应节点的配置文件添加如下配置：

​		peerType=observer  

其次，必须在配置文件指定哪些节点被指定为Observer，如：

​		server.1:node1:2181:3181:observer  

其次，必须在配置文件指定哪些节点被指定为 Observer，如：

​		server.1:localhost:2181:3181:observer



这里，我们安装的是leader+follower模式

| 服务器IP       | 主机名 | myid的值（每个zk的编号） |
| -------------- | ------ | ------------------------ |
| 192.168.88.161 | node1  | 1                        |
| 192.168.88.162 | node2  | 2                        |
| 192.168.88.163 | node3  | 3                        |



### 第一步：下载ZK的压缩包下载网址如下



http://archive.apache.org/dist/zookeeper/
我们在这个网址下载我们使用的zk版本为3.4.6
下载完成之后，上传到我们的linux的/export/software路径下准备进行安装



### 第二步：解压

在node1主机上，解压zookeeper的压缩包到/export/server路径下去，然后准备进行安装

``` shell
cd /export/software
tar -zxvf zookeeper-3.4.6.tar.gz -C /export/server/

```



### 第三步：修改配置文件

``` shell
在node1主机上，修改配置文件
cd /export/server/zookeeper-3.4.6/conf/
cp zoo_sample.cfg zoo.cfg
mkdir -p /export/server/zookeeper-3.4.6/zkdatas/
vim  zoo.cfg

修改以下内容
#Zookeeper的数据存放目录
dataDir=/export/server/zookeeper-3.4.6/zkdatas
# 保留多少个快照
autopurge.snapRetainCount=3
# 日志多少小时清理一次
autopurge.purgeInterval=1
# 集群中服务器地址
server.1=node1:2888:3888
server.2=node2:2888:3888
server.3=node3:2888:3888
```



### 第四步：添加myid配置

在node1主机的/export/server/zookeeper-3.4.6/zkdatas/这个路径下创建一个文件，文件名为myid ,文件内容为1

``` shell
echo 1 > /export/server/zookeeper-3.4.6/zkdatas/myid 
```



### 第五步：安装包分发并修改myid的值

在node1主机上，将安装包分发到其他机器
第一台机器上面执行以下两个命令

``` shell
scp -r  /export/server/zookeeper-3.4.6/ node2:/export/server/
scp -r  /export/server/zookeeper-3.4.6/ node3:/export/server/
```



第二台机器上修改myid的值为2

``` shell
echo 2 > /export/server/zookeeper-3.4.6/zkdatas/myid
```



第三台机器上修改myid的值为3

``` shell
echo 3 > /export/server/zookeeper-3.4.6/zkdatas/myid
```



### 第六步：三台机器启动zookeeper服务

三台机器分别启动zookeeper服务
这个命令三台机器都要执行

``` shell
/export/server/zookeeper-3.4.6/bin/zkServer.sh start
```



三台主机分别查看启动状态

``` shell
/export/server/zookeeper-3.4.6/bin/zkServer.sh  status
```



停止命令

``` shell
/export/server/zookeeper-3.4.6/bin/zkServer.sh stop
```



查看版本命令

``` shell
[root@node1 ~]# /export/server/zookeeper-3.4.6/bin/zkServer.sh  -version
JMX enabled by default
Using config: /export/server/zookeeper-3.4.6/bin/../conf/zoo.cfg
Usage: /export/server/zookeeper-3.4.6/bin/zkServer.sh {start|start-foreground|stop|restart|status|upgrade|print-cmd}
[root@node1 ~]# 
```

