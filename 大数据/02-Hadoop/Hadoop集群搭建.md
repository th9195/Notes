## Hadoop集群搭建



### 集群简介

​		HADOOP集群具体来说包含两个集群：HDFS集群和YARN集群，两者逻辑上分离，但物理上常在一起。

​		**HDFS集群负责海量数据的存储**，集群中的角色主要有：
​				NameNode、DataNode、SecondaryNameNode

​		**YARN集群负责海量数据运算时的资源调度**，集群中的角色主要有：
​				ResourceManager、NodeManager

​		那mapreduce是什么呢？它其实是一个分布式运算编程框架，是应用程序开发包，由用户按照编程规范进行程序开发，后打包运行在HDFS集群上，并且受到YARN集群的资源调度管理。



### 集群部署方式

Hadoop部署方式分三种：

- 1、Standalone mode（独立模式）

​		独立模式又称为单机模式，仅1个机器运行1个java进程，主要用于调试。

- 2、Pseudo-Distributed mode（伪分布式模式）

​		伪分布模式也是在1个机器上运行HDFS的NameNode和DataNode、YARN的 ResourceManger和NodeManager，但分别启动单独的java进程，主要用于调试。

- 3、Cluster mode（群集模式）-单节点模式-高可用HA模式

​		集群模式主要用于生产环境部署。会使用N台主机组成一个Hadoop集群。这种部署模式下，主节点和从节点会分开部署在不同的机器上。



​		本课程搭建的是集群模式，以三台主机为例，以下是集群规划:

| 主机组件          | node1(192.168.88.161) | node2(192.168.88.162) | node3(192.168.88.163) |
| ----------------- | --------------------- | --------------------- | --------------------- |
| NameNode          | 是                    | 否                    | 否                    |
| SecondaryNamenode | 否                    | 是                    | 否                    |
| DataNode          | 是                    | 是                    | 是                    |
| ResourceManager   | 是                    | 否                    | 否                    |
| NodeManager       | 是                    | 是                    | 是                    |







### Hadoop安装包目录结构

#### 解压hadoop-2.7.5.tar.gz，目录结构如下：

|         |                                                              |
| ------- | ------------------------------------------------------------ |
| bin     | Hadoop最基本的管理脚本和使用脚本的目录，这些脚本是sbin目录下管理脚本的基础实现，用户可以直接使用这些脚本管理和使用Hadoop |
| etc     | Hadoop配置文件所在的目录，包括core-site,xml、hdfs-site.xml、mapred-site.xml等从Hadoop1.0继承而来的配置文件和yarn-site.xml等Hadoop2.0新增的配置文件 |
| include | 对外提供的编程库头文件（具体动态库和静态库在lib目录中），这些头文件均是用C++定义的，通常用于C++程序访问HDFS或者编写MapReduce程序 |
| lib     | 该目录包含了Hadoop对外提供的编程动态库和静态库，与include目录中的头文件结合使用 |
| libexec | 各个服务对用的shell配置文件所在的目录，可用于配置日志输出、启动参数（比如JVM参数）等基本信息 |
| sbin    | Hadoop管理脚本所在的目录，主要包含HDFS和YARN中各类服务的启动/关闭脚本 |
| share   | Hadoop各个模块编译后的jar包所在的目录，官方自带示例          |



### Hadoop配置文件修改

​		Hadoop安装主要就是配置文件的修改，一般在主节点进行修改，完毕后scp下发给其他各个从节点机器。
   	**注意,以下所有操作都在node1主机进行。**



#### 1- hadoop-env.sh

- 介绍
  		文件中设置的是Hadoop运行时需要的环境变量。JAVA_HOME是必须设置的，即使我们当前的系统中设置了JAVA_HOME，它也是不认识的，因为Hadoop即使是在本机上执行，它也是把当前的执行环境当成远程服务器。

- 配置

``` shell
	cd  /export/server/hadoop-2.7.5/etc/hadoop
	vim  hadoop-env.sh
	添加以下内容:
	export JAVA_HOME=/export/server/jdk1.8.0_241
```



#### 2- core-site.xml

- 介绍
  		hadoop的核心配置文件，有默认的配置项core-default.xml。
  core-default.xml与core-site.xml的功能是一样的，如果在core-site.xml里没有配置的属性，则会自动会获取core-default.xml里的相同属性的值。

- 配置
  在该文件中的<configuration>标签中添加以下配置,
  <configuration>
        在这里添加配置
  </configuration>

``` sql
cd  /export/server/hadoop-2.7.5/etc/hadoop
vim  core-site.xml

```

- 配置内容如下:

```xml


<!-- 用于设置Hadoop的文件系统，由URI指定 -->
<property>
    <name>fs.defaultFS</name>
    <value>hdfs://node1:8020</value>
</property>
<!-- 配置Hadoop存储数据目录,默认/tmp/hadoop-${user.name} -->
<property>
	<name>hadoop.tmp.dir</name>
	<value>/export/server/hadoop-2.7.5/hadoopDatas/tempDatas</value>
</property>
<!--  缓冲区大小，实际工作中根据服务器性能动态调整 -->
 <property>
	   <name>io.file.buffer.size</name>
	   <value>4096</value>
 </property>

<!--  开启hdfs的垃圾桶机制，删除掉的数据可以从垃圾桶中回收，单位分钟 -->
 <property>
	   <name>fs.trash.interval</name>
	   <value>10080</value>
 </property>
```

#### 3- hdfs-site.xml

- 介绍
  		HDFS的核心配置文件，主要配置HDFS相关参数，有默认的配置项hdfs-default.xml。
  hdfs-default.xml与hdfs-site.xml的功能是一样的，如果在hdfs-site.xml里没有配置的属性，则会自动会获取hdfs-default.xml里的相同属性的值。

- 配置
  在该文件中的<configuration>标签中添加以下配置,
  <configuration>
        在这里添加配置
  </configuration>

- 

  ``` shell
  cd  /export/server/hadoop-2.7.5/etc/hadoop
  vim  hdfs-site.xml
  ```

- 配置一下内容

  ``` xml
  <!-- 指定SecondaryNameNode的主机和端口 -->
    <property>
    		<name>dfs.namenode.secondary.http-address</name>
    		<value>node2:50090</value>
    </property>
    <!-- 指定namenode的页面访问地址和端口 -->
    <property>
    	<name>dfs.namenode.http-address</name>
    	<value>node1:50070</value>
    </property>
    <!-- 指定namenode元数据的存放位置 -->
    <property>
    	<name>dfs.namenode.name.dir</name>
    	<value>file:///export/server/hadoop-2.7.5/hadoopDatas/namenodeDatas</value>
    </property>
    <!--  定义datanode数据存储的节点位置 -->
    <property>
    	<name>dfs.datanode.data.dir</name>
    	<value>file:///export/server/hadoop-2.7.5/hadoopDatas/datanodeDatas</value>
    </property>	
    <!-- 定义namenode的edits文件存放路径 -->
    <property>
    	<name>dfs.namenode.edits.dir</name>
    	<value>file:///export/server/hadoop-2.7.5/hadoopDatas/nn/edits</value>
    </property>
  
  <!-- 配置检查点目录 -->
  <property>
  	<name>dfs.namenode.checkpoint.dir</name>
  	<value>file:///export/server/hadoop-2.7.5/hadoopDatas/snn/name</value>
  </property>
  
  <property>
  	<name>dfs.namenode.checkpoint.edits.dir</name>
  	<value>file:///export/server/hadoop-2.7.5/hadoopDatas/dfs/snn/edits</value>
  </property>
  <!-- 文件切片的副本个数-->
  <property>
  	<name>dfs.replication</name>
  	<value>3</value>
  </property>
  
  <!-- 设置HDFS的文件权限-->
  <property>
  	<name>dfs.permissions</name>
  	<value>false</value>
  </property>
  <!-- 设置一个文件切片的大小：128M-->
  <property>
  	<name>dfs.blocksize</name>
  	<value>134217728</value>
  </property>
  <!-- 指定DataNode的节点配置文件 -->
  <property>
  		 <name> dfs.hosts </name>
  		 <value>/export/server/hadoop-2.7.5/etc/hadoop/slaves </value>
  </property>
  ```

  

#### 4- mapred-site.xml

- 介绍
  MapReduce的核心配置文件，Hadoop默认只有个模板文件mapred-site.xml.template,需要使用该文件复制出来一份mapred-site.xml文件

- 配置
  cd  /export/server/hadoop-2.7.5/etc/hadoop
  cp mapred-site.xml.template mapred-site.xml
  在mapred-site.xml文件中的<configuration>标签中添加以下配置,
  <configuration>
    在这里添加配置
  </configuration>

  ``` shell
  vim  mapred-site.xml
  ```

  

- 配置一下内容:

```xml
<!-- 指定分布式计算使用的框架是yarn -->
<property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
</property>
<!-- 开启MapReduce小任务模式 -->
<property>
	<name>mapreduce.job.ubertask.enable</name>
	<value>true</value>
</property>

<!-- 设置历史任务的主机和端口 -->
<property>
	<name>mapreduce.jobhistory.address</name>
	<value>node1:10020</value>
</property>

<!-- 设置网页访问历史任务的主机和端口 -->
<property>
	<name>mapreduce.jobhistory.webapp.address</name>
	<value>node1:19888</value>
</property>
```

#### 5- mapred-env.sh

​		在该文件中需要指定JAVA_HOME,将原文件的JAVA_HOME配置前边的注释去掉，然后按照以下方式修改:

``` shell
cd  /export/server/hadoop-2.7.5/etc/hadoop
vim  mapred-env.sh

export JAVA_HOME=/export/server/jdk1.8.0_241
```



#### 6- yarn-site.xml

- 介绍

  YARN的核心配置文件,在该文件中的<configuration>标签中添加以下配置,
  <configuration>
          在这里添加配置
  </configuration>

- 配置

``` shell
cd  /export/server/hadoop-2.7.5/etc/hadoop
vim  yarn-site.xml
```



- 添加以下配置：
  

```xml
<!-- 配置yarn主节点的位置 -->
<property>
    <name>yarn.resourcemanager.hostname</name>
    <value>node1</value>
</property>
<property>
	<name>yarn.nodemanager.aux-services</name>
	<value>mapreduce_shuffle</value>
</property>

<!-- 开启日志聚合功能 -->
<property>
	<name>yarn.log-aggregation-enable</name>
	<value>true</value>
</property>
<!-- 设置聚合日志在hdfs上的保存时间  7天-->
<property>
	<name>yarn.log-aggregation.retain-seconds</name>
	<value>604800</value>
</property>
<!-- 设置yarn集群的内存分配方案  4G-->
<property>    
	    <name>yarn.nodemanager.resource.memory-mb</name>    
	    <value>2048</value>
</property>
<property>  
    	 <name>yarn.scheduler.minimum-allocation-mb</name>
     	<value>2048</value>
</property>
<property>
	<name>yarn.nodemanager.vmem-pmem-ratio</name>
	<value>2.1</value>
</property>
```



#### 7- slaves

- 1、介绍
  slaves文件里面记录的是集群主机名。一般有以下两种作用：

  

  - ​	一是：配合一键启动脚本如start-dfs.sh、stop-yarn.sh用来进行集群启动。这时候slaves文件里面的主机标记的就是从节点角				色所在的机器。

  - ​	二是：可以配合hdfs-site.xml里面dfs.hosts属性形成一种白名单机制。

  

  ​		dfs.hosts指定一个文件，其中包含允许连接到NameNode的主机列表。必须指定文件的完整路径名,那么所有在slaves中的主机才可以加入的集群中。如果值为空，则允许所有主机。

- 配置

  ``` shell
  cd  /export/server/hadoop-2.7.5/etc/hadoop
  vim  slaves
  删除slaves中的localhost，然后添加以下内容:
  node1
  node2
  node3
  ```

  

### 数据目录创建和文件分发

   注意,以下所有操作都在node1主机进行。
1、目录创建
创建Hadoop所需目录

``` shell
mkdir -p /export/server/hadoop-2.7.5/hadoopDatas/tempDatas
mkdir -p /export/server/hadoop-2.7.5/hadoopDatas/namenodeDatas
mkdir -p /export/server/hadoop-2.7.5/hadoopDatas/datanodeDatas
mkdir -p /export/server/hadoop-2.7.5/hadoopDatas/nn/edits
mkdir -p /export/server/hadoop-2.7.5/hadoopDatas/snn/name
mkdir -p /export/server/hadoop-2.7.5/hadoopDatas/dfs/snn/edits
```



### 文件分发

将配置好的Hadoop目录分发到node2和node3主机。

 ``` shell
scp -r /export/server/hadoop-2.7.5/ node2:/export/server/
 scp -r /export/server/hadoop-2.7.5/ node3:/export/server/
 ```



### 配置Hadoop的环境变量

注意，三台机器都需要执行以下命令

vim  /etc/profile

添加以下内容:

``` shell
export HADOOP_HOME=/export/server/hadoop-2.7.5
export PATH=:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
```



#### 配置完成之后生效

source /etc/profile

### 启动集群

#### 启动方式

要启动Hadoop集群，需要启动HDFS和YARN两个集群。
注意：**首次启动HDFS时，必须对其进行格式化操作**。本质上是一些清理和准备工作，因为此时的HDFS在物理上还是不存在的。
在node1上执行格式化指令

``` shell
hadoop namenode -format  # 首次启动HDFS时，必须对其进行格式化操作
```



#### 单节点逐个启动

- 在node1主机上使用以下命令启动HDFS NameNode：

``` shell
hadoop-daemon.sh start namenode
```



- 在node1、node2、node3三台主机上，分别使用以下命令启动HDFS DataNode：

``` shell
hadoop-daemon.sh start datanode
```



- 在node1主机上使用以下命令启动YARN ResourceManager：

``` shell
yarn-daemon.sh  start resourcemanager
```



- 在node1、node2、node3三台主机上使用以下命令启动YARN nodemanager：

``` shell
yarn-daemon.sh start nodemanager
```



以上脚本位于/export/server/hadoop-2.7.5/sbin目录下。如果想要停止某个节点上某个角色，只需要把命令中的 **start** 改为 **stop** 即可。



#### 脚本一键启动

- 启动、关闭HDFS

``` shell
start-dfs.sh
stop-dfs.sh
```



- 启动、关闭Yarn

``` shell
start-yarn.sh
stop-yarn.sh
```



- 启动、关闭历史任务服务进程

``` shell
mr-jobhistory-daemon.sh start historyserver
mr-jobhistory-daemon.sh stop historyserver
```



启动之后，使用jps命令查看相关服务是否启动，jps是显示Java相关的进程命令。

node1

``` shell
[root@node1 bin]# jps
18896 Jps
8321 QuorumPeerMain
15137 ResourceManager
14883 DataNode
15651 JobHistoryServer
14745 NameNode
15242 NodeManager
[root@node1 bin]# 
```

node2

``` shell
[root@node2 logs]# jps
11504 SecondaryNameNode
11400 DataNode
11579 NodeManager
7246 QuorumPeerMain
14303 Jps
[root@node2 logs]# 
```

node3

``` shell
[root@node3 ~]# jps
11510 NodeManager
11400 DataNode
7354 QuorumPeerMain
13886 Jps
[root@node3 ~]# 

```

#### 一键启动、关闭hdfs和yarn

注意： **这两个命令可以一键启动HDFS和 YARN , 但是无法启动 启动历史任务服务进程**

- 启动 start-all.sh

``` shell
[root@node1 bin]# start-all.sh
This script is Deprecated. Instead use start-dfs.sh and start-yarn.sh
Starting namenodes on [node1]
node1: starting namenode, logging to /export/server/hadoop-2.7.5/logs/hadoop-root-namenode-node1.out
node1: starting datanode, logging to /export/server/hadoop-2.7.5/logs/hadoop-root-datanode-node1.out
node3: starting datanode, logging to /export/server/hadoop-2.7.5/logs/hadoop-root-datanode-node3.out
node2: starting datanode, logging to /export/server/hadoop-2.7.5/logs/hadoop-root-datanode-node2.out
Starting secondary namenodes [node2]
node2: starting secondarynamenode, logging to /export/server/hadoop-2.7.5/logs/hadoop-root-secondarynamenode-node2.out
starting yarn daemons
starting resourcemanager, logging to /export/server/hadoop-2.7.5/logs/yarn-root-resourcemanager-node1.out
node3: starting nodemanager, logging to /export/server/hadoop-2.7.5/logs/yarn-root-nodemanager-node3.out
node2: starting nodemanager, logging to /export/server/hadoop-2.7.5/logs/yarn-root-nodemanager-node2.out
node1: starting nodemanager, logging to /export/server/hadoop-2.7.5/logs/yarn-root-nodemanager-node1.out
[root@node1 bin]# 

```



- 关闭 stop-all.sh

``` shell
[root@node1 bin]# stop-all.sh
This script is Deprecated. Instead use stop-dfs.sh and stop-yarn.sh
Stopping namenodes on [node1]
node1: stopping namenode
node1: stopping datanode
node3: stopping datanode
node2: stopping datanode
Stopping secondary namenodes [node2]
node2: stopping secondarynamenode
stopping yarn daemons
stopping resourcemanager
node1: stopping nodemanager
node3: stopping nodemanager
node2: stopping nodemanager
no proxyserver to stop
```





### 集群的页面访问

#### IP访问

一旦Hadoop集群启动并运行，可以通过web-ui进行集群查看，如下所述：

- 查看NameNode页面地址:

``` html
http://192.168.88.161:50070/ 
```

![01-NameNode页面](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\01-NameNode页面.png)



- 查看Yarn集群页面地址:

``` html
http://192.168.88.161:8088/cluster 
```

![02-查看Yarn集群页面](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\02-查看Yarn集群页面.png)



- 查看MapReduce历史任务页面地址:

``` html
http://192.168.88.161:19888/jobhistory
```



![03-MapReduce历史任务页面](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\03-MapReduce历史任务页面.png)

#### 主机名访问

请注意，以上的访问地址只能使用IP地址，如果想要使用主机名，则对Windows进行配置。
配置方式:

``` xml
1、打开Windows的C:\Windows\System32\drivers\etc目录下hosts文件
2、在hosts文件中添加以下域名映射
192.168.88.161  node1  node1.itcast.cn
192.168.88.162  node2  node2.itcast.cn
192.168.88.163  node3  node3.itcast.cn
```



配置完之后，可以将以上地址中的IP替换为主机名即可访问，如果还不能访问，则需要重启Windows电脑，比如访问NameNode，可以使用http://node1:50070/ 。



### Hadoop初体验

#### HDFS使用

- 从Linux本地上传一个文本文件到hdfs的/目录下

``` shell
在/export/data/目录中创建a.txt文件，并写入数据
cd /export/data/
touch a.txt
echo "hello" > a.txt 

#将a.txt上传到HDFS的根目录
hadoop fs -put a.txt  /
```



- 通过页面查看

 通过NameNode页面.进入HDFS：http://node1:50070/  查看文件是否创建成功.

![04-HDFS页面](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\04-HDFS页面.png)

#### 运行mapreduce程序

在Hadoop安装包的share/hadoop/mapreduce下有官方自带的mapreduce程序。我们可以使用如下的命令进行运行测试。
示例程序jar:
       hadoop-mapreduce-examples-2.7.5.jar
计算圆周率

``` shell
 hadoop jar hadoop-mapreduce-examples-2.7.5.jar pi 2 100000000
```

结果：

``` shell
[root@node1 mapreduce]# cd /export/server/hadoop-2.7.5/share/hadoop/mapreduce/
[root@node1 mapreduce]# hadoop jar hadoop-mapreduce-examples-2.7.5.jar pi 2 100000000
Number of Maps  = 2
Samples per Map = 100000000
Wrote input for Map #0
Wrote input for Map #1
Starting Job
21/01/06 17:08:14 INFO client.RMProxy: Connecting to ResourceManager at node1/192.168.88.161:8032
21/01/06 17:08:14 INFO input.FileInputFormat: Total input paths to process : 2
21/01/06 17:08:14 INFO mapreduce.JobSubmitter: number of splits:2
21/01/06 17:08:15 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1609922570342_0001
21/01/06 17:08:15 INFO impl.YarnClientImpl: Submitted application application_1609922570342_0001
21/01/06 17:08:15 INFO mapreduce.Job: The url to track the job: http://node1:8088/proxy/application_1609922570342_0001/
21/01/06 17:08:15 INFO mapreduce.Job: Running job: job_1609922570342_0001
21/01/06 17:08:25 INFO mapreduce.Job: Job job_1609922570342_0001 running in uber mode : true
21/01/06 17:08:25 INFO mapreduce.Job:  map 0% reduce 0%
21/01/06 17:08:28 INFO mapreduce.Job:  map 50% reduce 0%
21/01/06 17:08:30 INFO mapreduce.Job:  map 100% reduce 0%
21/01/06 17:08:32 INFO mapreduce.Job:  map 100% reduce 100%
21/01/06 17:08:32 INFO mapreduce.Job: Job job_1609922570342_0001 completed successfully
21/01/06 17:08:32 INFO mapreduce.Job: Counters: 52
	File System Counters
		FILE: Number of bytes read=170
		FILE: Number of bytes written=350
		FILE: Number of read operations=0
		FILE: Number of large read operations=0
		FILE: Number of write operations=0
		HDFS: Number of bytes read=1459
		HDFS: Number of bytes written=411137
		HDFS: Number of read operations=62
		HDFS: Number of large read operations=0
		HDFS: Number of write operations=12
	Job Counters 
		Launched map tasks=2
		Launched reduce tasks=1
		Other local map tasks=2
		Total time spent by all maps in occupied slots (ms)=5327
		Total time spent by all reduces in occupied slots (ms)=1443
		TOTAL_LAUNCHED_UBERTASKS=3
		NUM_UBER_SUBMAPS=2
		NUM_UBER_SUBREDUCES=1
		Total time spent by all map tasks (ms)=5327
		Total time spent by all reduce tasks (ms)=1443
		Total vcore-milliseconds taken by all map tasks=5327
		Total vcore-milliseconds taken by all reduce tasks=1443
		Total megabyte-milliseconds taken by all map tasks=5454848
		Total megabyte-milliseconds taken by all reduce tasks=1477632
	Map-Reduce Framework
		Map input records=2
		Map output records=4
		Map output bytes=36
		Map output materialized bytes=56
		Input split bytes=284
		Combine input records=0
		Combine output records=0
		Reduce input groups=2
		Reduce shuffle bytes=56
		Reduce input records=4
		Reduce output records=0
		Spilled Records=8
		Shuffled Maps =2
		Failed Shuffles=0
		Merged Map outputs=2
		GC time elapsed (ms)=481
		CPU time spent (ms)=6950
		Physical memory (bytes) snapshot=1206673408
		Virtual memory (bytes) snapshot=9288056832
		Total committed heap usage (bytes)=1131413504
	Shuffle Errors
		BAD_ID=0
		CONNECTION=0
		IO_ERROR=0
		WRONG_LENGTH=0
		WRONG_MAP=0
		WRONG_REDUCE=0
	File Input Format Counters 
		Bytes Read=236
	File Output Format Counters 
		Bytes Written=97
Job Finished in 18.256 seconds
Estimated value of Pi is 3.14159368000000000000
[root@node1 mapreduce]# 
```



​		关于圆周率的估算，感兴趣的可以查询资料蒙特卡洛方法来计算Pi值，计算命令中2表示计算的线程数，100000000表示投点数，该值越大，则计算的pi值越准确。

