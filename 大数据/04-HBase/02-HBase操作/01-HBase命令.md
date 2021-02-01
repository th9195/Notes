# 1- 启动与关闭

- 启动start-hbase.sh 

``` shell
[root@node1 ~]# start-hbase.sh 
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/export/server/hadoop-2.7.5/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/export/server/hbase-2.1.0/lib/client-facing-thirdparty/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
running master, logging to /export/server/hbase-2.1.0/logs/hbase-root-master-node1.out
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/export/server/hadoop-2.7.5/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/export/server/hbase-2.1.0/lib/client-facing-thirdparty/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
node3: running regionserver, logging to /export/server/hbase-2.1.0/bin/../logs/hbase-root-regionserver-node3.out
node1: running regionserver, logging to /export/server/hbase-2.1.0/bin/../logs/hbase-root-regionserver-node1.out
node2: running regionserver, logging to /export/server/hbase-2.1.0/bin/../logs/hbase-root-regionserver-node2.out
[root@node1 ~]#
```

- 关闭 stop-hbase.sh

``` shell
[root@node1 ~]# stop-hbase.sh 
stopping hbase............
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/export/server/hadoop-2.7.5/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/export/server/hbase-2.1.0/lib/client-facing-thirdparty/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
[root@node1 ~]# 

```

# 2- 进入HBase shell

- hbase shell

``` shell
[root@node1 ~]# hbase shell
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/export/server/hadoop-2.7.5/share/hadoop/common/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/export/server/hbase-2.1.0/lib/client-facing-thirdparty/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
HBase Shell
Use "help" to get list of supported commands.
Use "exit" to quit this interactive shell.
Version 2.1.0, re1673bb0bbfea21d6e5dba73e013b09b8b49b89b, Tue Jul 10 17:26:48 CST 2018
Took 0.0097 seconds    
```

# 3- 查看状态

- status

``` sql
hbase(main):001:0> status
1 active master, 0 backup masters, 3 servers, 0 dead, 1.0000 average load
Took 0.8161 seconds                                                                                            
hbase(main):002:0> 
```



# 4- hbase的相关操作_shell命令

## 4-1 hbase的基本shell操作

### 4-1-1 查看hbase中所有的表:  list

### 4-1-2 如何创建一个表

### 4-1-3 如何添加数据

### 4-1-4 如何查看某一条数据

### 4-1-5 扫描整个表的数据

###  4-1-6 rowkey的范围查询

### 4-1-7 过滤器操作

#### 4-1-7-1 ValueFilter: 列值过滤器

#### 4-1-7-2 列名过滤器: QualifierFilter

#### 4-1-7-3 rowkey的前缀过滤器: PrefixFilter

### 4-1-8 修改数据															

### 4-1-9 删除数据

### 4-1-10 删除一个列族

### 4-1-11 清空表

### 4-1-12 删除表

### 4-1-13 统计表中有多少行数据

### 4-1-14 将数据文件添加到表中

## 4-2 hbase的高级shell命令

### 4-2-1 whoami: 显示当前hbase的登录用户名

### 4-2-2 describe: 显示表详细结构信息

### 4-2-3 exists : 判断表是否存在

### 4-2-4 如何添加一个新的列族