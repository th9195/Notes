# Archive档案的使用

​		HDFS并不擅长存储小文件，因为每个文件最少一个block，每个block的元数据都会在NameNode占用内存，如果存在大量的小文件，它们会吃掉NameNode节点的大量内存。
​		<span style="color:red;background:white;font-size:20px;font-family:楷体;">**Hadoop Archives**</span>可以有效的处理以上问题，它可以<span style="color:red;background:white;font-size:20px;font-family:楷体;">**把多个文件归档成为一个文件**</span>，归档成一个文件后还可以透明的访问每一个文件。



# 如何创建Archive

``` sql
Usage: hadoop archive -archiveName name -p <parent> <src>* <dest>
```

- -archiveName是指要**创建的存档的名称**。比如test.har，archive的名字的扩展名应该是*.har。
- -p参数**指定文件存档文件**（src）的相对路径。

​		例如：如果你只想存档一个目录/config下的所有文件:

``` sql
hadoop archive -archiveName test.har -p /config /outputdir
```

这样就会在/outputdir目录下创建一个名为test.har的存档文件。





## 如何查看Archive

​	首先我们来看下创建好的har文件。使用如下的命令：

``` sql
hadoop fs -ls /outputdir/test.har
```

​		这里可以看到har文件包括：两个**索引文件**，多个**part文件**（本例只有一个）以及一个标识成功与否的文件。<span style="color:red;background:white;font-size:20px;font-family:楷体;">**part文件是多个原文件的集合**</span>，根据index文件去找到原文件。
​		例如上述的/input目录下有很多小的xml文件。进行archive操作之后，这些小文件就归档到test.har里的part-0一个文件里。

``` sql
hadoop fs -cat /outputdir/test.har/part-0
```



- archive作为文件系统层暴露给外界。所以所有的fs shell命令都能在archive上运行，但是要使用不同的URI。Hadoop Archives的URI是：

``` sql
har://scheme-hostname:port/archivepath/fileinarchive   
```



- scheme-hostname格式为**hdfs-域名:端口**，如果没有提供scheme-hostname，它会使用默认的文件系统。这种情况下URI是这种形式：

``` sql
har:///archivepath/fileinarchive
```

- 如果用har uri去访问的话，索引、标识等文件就会隐藏起来，只显示创建档案之前的原文件：
  查看归档文件中的小文件,使用har uri

``` sql
hadoop fs -ls har://hdfs-node1:8020/outputdir/test.har
```



- 
  查看归档文件中的小文件,不使用har uri


``` sql
hadoop fs -ls har:///outputdir/test.har
```

 

- 查看har归档文件中小文件的内容

``` sql
hadoop fs -cat har:///outputdir/test.har/core-site.xml
```



## 如何解压Archive

``` sql
hadoop fs -mkdir /config2
hadoop fs -cp har:///outputdir/test.har/*    /config2
```

查看HDFS页面，发现/config2目录中已经有解压后的小文件了



## Archive注意事项

1. Hadoop archives是特殊的档案格式。
   1. 一个Hadoop archive对应一个文件系统目录。
   2. Hadoop archive的扩展名是*.har；
2. 创建archives**本质是运行一个Map/Reduce任务**，所以应该在Hadoop集群上运行创建档案的命令，要提前启动Yarn集群； 
3. 创建archive文件要消耗和原文件一样多的硬盘空间；
4. archive文件**不支持压缩**，尽管archive文件看起来像已经被压缩过；
5. archive文件一旦创建就无法改变，要修改的话，需要创建新的archive文件。事实上，一般不会再对存档后的文件进行修改，因为它们是定期存档的，比如每周或每日；
6. 当创建archive时，源文件不会被更改或删除；



# Snapshot快照的使用

​		快照顾名思义，就是相当于对hdfs文件系统做一个备份，可以通过快照对指定的文件夹设置备份，**但是添加快照之后，并不会立即复制所有文件，而是指向同一个文件。当写入发生时，才会产生新文件**。
HDFS 快照（HDFS Snapshots）是文件系统在某个时间点的只读副本。可以在文件系统的子树或整个文件系统上创建快照。快照的常见用途主要包括数据备份，防止用户误操作和容灾恢复。



## 快照使用基本语法

- 开启指定目录的快照功能

``` sql
hdfs dfsadmin  -allowSnapshot  路径 
```



- 禁用指定目录的快照功能（默认就是禁用状态）

``` sql
hdfs dfsadmin  -disallowSnapshot  路径
```



- 给某个路径创建快照snapshot

``` sql
hdfs dfs -createSnapshot  路径
```



- 指定快照名称进行创建快照snapshot

``` sql
hdfs dfs  -createSanpshot 路径 名称    
```



- 给快照重新命名

``` sql
hdfs dfs  -renameSnapshot  路径 旧名称  新名称
```



- 列出当前用户所有可快照目录

``` sql
hdfs lsSnapshottableDir  
```



- 恢复快照

``` sql
hdfs dfs -cp -ptopax  快照路径  恢复路径
```



- 删除快照snapshot

``` sql
hdfs dfs -deleteSnapshot <path> <snapshotName> 
```



## 快照操作实际案例

1、开启指定目录的快照

``` sql
hdfs dfsadmin -allowSnapshot /config
```



2、对指定目录创建快照
注意：创建快照之前，先要允许该目录创建快照

``` sql
hdfs dfs -createSnapshot /config
```



通过web浏览器访问快照
http://node1:50070/explorer.html#/config/.snapshot/
3、指定名称创建快照

``` sql
hdfs dfs -createSnapshot /config mysnap1
```



4、重命名快照

``` sql
hdfs dfs -renameSnapshot /config  mysnap1 mysnap2
```



5、列出当前用户所有可以快照的目录

``` sql
hdfs lsSnapshottableDir
```



6、恢复快照

``` sql
hdfs dfs -cp -ptopax /config/.snapshot/mysnap1  /config3
```



7、删除快照

``` sql
hdfs dfs -deleteSnapshot /config  mysnap1
```

  