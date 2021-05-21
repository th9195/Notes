# sqoop的相关内容



## sqoop的基本介绍

​	sqoop是一款apache开源产品, 主要是用于数据的导入导出的工具, 负责将数据在RDBMS和hadoop之间数据导入导出

​	导入: 从RDBMS到hadoop  

​	导出:从Hadoop到RDBMS





## Sqoop抽取的两种方式

​	对于Mysql数据的采集，通常使用Sqoop来进行。

​	通过Sqoop将关系型数据库数据到Hive有两种方式，<span style="color:red;background:white;font-size:20px;font-family:楷体;">**一种是原生Sqoop API，一种是使用HCatalog API。**</span>两种方式略有不同。

​	HCatalog方式与Sqoop方式的参数基本都是相同，只是个别不一样，都是可以实现Sqoop将数据抽取到Hive。

### 区别

- 数据格式支持

  Sqoop方式支持的数据格式较少，<span style="color:red;background:white;font-size:20px;font-family:楷体;">**HCatalog支持的数据格式多，包括RCFile, ORCFile, CSV, JSON和SequenceFile等格式。**</span>

- 数据覆盖

  Sqoop方式允许数据覆盖，HCatalog不允许数据覆盖，每次都只是追加。

- 字段名

  Sqoop方式比较随意，不要求源表和目标表字段相同(字段名称和个数都可以不相同)，<span style="color:blue;background:white;font-size:20px;font-family:楷体;">**它抽取的方式是将字段按顺序插入，**</span>比如目标表有3个字段，源表有一个字段，它会将数据插入到Hive表的第一个字段，其余字段为NULL。

  但是HCatalog不同，<span style="color:red;background:white;font-size:20px;font-family:楷体;">**源表和目标表字段名需要相同，字段个数可以不相等，如果字段名不同，抽取数据的时候会报NullPointerException错误。**</span>HCatalog抽取数据时，会将字段对应到相同字段名的字段上，哪怕字段个数不相等。



## 使用sqoop完成数据导入操作

### 查看mysql中所有的数据库

```shell
sqoop list-databases --connect jdbc:mysql://192.168.52.150:3306 --username root --password 123456
```

### 查看mysql中某个库下所有的表

```shell
sqoop list-tables --connect jdbc:mysql://hadoop01:3306/scm --username root --password 123456
```

> 注意:
>
> ​    当忘记某个属性的时候, 可以通过使用  --help方式查询

### 从mysql中将数据导入到HDFS(全量导入)

```shell
命令1:
sqoop import \
--connect jdbc:mysql://hadoop01:3306/test \
--username root --password 123456 \
--table emp 

通过测试发现, 只需要指定输入端, 即可将数据导入HDFS中, 默认情况下, 将数据导入到所操作用户对应家目录下, 建立一个与导入表同名的目录, 同时发现表中有几条数据, sqoop默认就会启动几个map来读取数据, 默认分割符号为 逗号

如何减少map的数量呢?  只需要添加  -m的参数即可
sqoop import \
--connect jdbc:mysql://hadoop01:3306/test \
--username root --password 123456 \
--table emp \
-m 1

如果想使用两个map呢? 建议添加--split-by 表示按照那个字段进行分割表数据
sqoop import \
--connect jdbc:mysql://hadoop01:3306/test \
--username root --password 123456 \
--table emp \
--split-by id \
-m 2

想要修改其默认的分割符号: 更改为 空格
sqoop import \
--connect jdbc:mysql://hadoop01:3306/test \
--username root --password 123456 \
--table emp \
--fields-terminated-by ' ' \
--split-by id \			
-m 2

想要指定某个目的地:  --target-dir (指定目的地)  和   --delete-target-dir(目的地目录存在, 先删除)
sqoop import \
--connect jdbc:mysql://hadoop01:3306/test \
--username root --password 123456 \
--table emp \
--fields-terminated-by ' ' \
--target-dir '/sqoop_emp' \
--delete-target-dir \
--split-by id \
-m 2
```

### 使用sqoop导入到hive中(全量导入)

```shell
第一步: 在hive中先建立目标表 
    create database sqooptohive;
    use sqooptohive;
    create table sqooptohive.emp_hive(
    	id int,
    	name string,
    	deg string,
    	salary int ,
    	dept string
    ) row format delimited fields terminated by '\t' stored as orc;

第二部: 执行数据导入操作:  HCataLog
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/test \
--username root \
--password 123456 \
--table emp \
--fields-terminated-by '\t' \
--hcatalog-database sqooptohive \
--hcatalog-table emp_hive \
-m 1



属性说明:
--hcatalog-database  指定数据库名称
--hcatalog-table   指定表的名称

注意:  使用此种方式, 在hive中建表的时候, 必须保证hive表字段和对应mysql表的字段名称保持一致

```

* 5) 使用where条件的方式, 导入数据到HDFS(条件导入):

```shell
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/test \
--username root \
--password 123456 \
--table emp_add \
--target-dir /sqoop/emp_add \
--delete-target-dir \
-m 1  \
--where "city = 'sec-bad'"
```

* 6)  使用SQL方式将数据导入到HDFS(条件导入)

```shell
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/test \
--username root \
--password 123456 \
--query 'select phno from emp_conn where 1=1 and  $CONDITIONS' \
--target-dir /sqoop/emp_conn \
--delete-target-dir \
-m 1 

注意:
   1)当采用SQL的方式来导入数据的时候, SQL的最后面必须添加 $CONDITIONS 关键词
   2) 整个SQL如果使用 "" 包裹的  $CONDITIONS 关键词前面需要使用\进行转义
   	"select phno from emp_conn where 1=1 and  \$CONDITIONS"

```

* 7) 使用SQL方式将数据导入hive(条件导入) -- 增量导入方式

```shell
sqoop import \
--connect jdbc:mysql://192.168.52.150:3306/test \
--username root \
--password 123456 \
--query "select * from emp where id>1205 and  \$CONDITIONS" \
--fields-terminated-by '\t' \
--hcatalog-database sqooptohive \
--hcatalog-table emp_hive \
-m 1

```

## 使用sqoop完成数据导出操作

需求: 将hive中emp_hive表导出到mysql中(全量导出)

* 第一步: 需要在mysql中创建目标表 (必须操作)

```sql
CREATE TABLE `emp_out` (
  `id` INT(11) DEFAULT NULL,
  `name` VARCHAR(100) DEFAULT NULL,
  `deg` VARCHAR(100) DEFAULT NULL,
  `salary` INT(11) DEFAULT NULL,
  `dept` VARCHAR(10) DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8;

```

* 第二步: 执行sqoop的导出操作:

```shell
sqoop export \
--connect jdbc:mysql://192.168.52.150:3306/test \
--username root \
--password 123456 \
--table emp_out \
--hcatalog-database sqooptohive \
--hcatalog-table emp_hive \
-m 1
```



## sqoop的相关参数

| 参数                                                         | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| --connect                                                    | 连接关系型数据库的URL                                        |
| --username                                                   | 连接数据库的用户名                                           |
| --password                                                   | 连接数据库的密码                                             |
| --driver                                                     | JDBC的driver class                                           |
| --query或--e <statement>                                     | 将查询结果的数据导入，使用时必须伴随参--target-dir，--hcatalog-table，如果查询中有where条件，则条件后必须加上CONDITIONS关键字。  如果使用双引号包含sql，则​CONDITIONS前要加上\以完成转义：\\$CONDITIONS |
| --hcatalog-database                                          | 指定HCatalog表的数据库名称。如果未指定，default则使用默认数据库名称。提供 --hcatalog-database不带选项--hcatalog-table是错误的。 |
| --hcatalog-table                                             | 此选项的参数值为HCatalog表名。该--hcatalog-table选项的存在表示导入或导出作业是使用HCatalog表完成的，并且是HCatalog作业的必需选项。 |
| --create-hcatalog-table                                      | 此选项指定在导入数据时是否应自动创建HCatalog表。表名将与转换为小写的数据库表名相同。 |
| --hcatalog-storage-stanza 'stored as orc  tblproperties ("orc.compress"="SNAPPY")' \ | 建表时追加存储格式到建表语句中，tblproperties修改表的属性，这里设置orc的压缩格式为SNAPPY |
| -m                                                           | 指定并行处理的MapReduce任务数量。  -m不为1时，需要用split-by指定分片字段进行并行导入，尽量指定int型。 |
| --split-by   id                                              | 如果指定-split by, 必须使用$CONDITIONS关键字, 双引号的查询语句还要加\ |
| --hcatalog-partition-keys <br> --hcatalog-partition-values   | keys和values必须同时存在，相当于指定静态分区。允许将多个键和值提供为静态分区键。多个选项值之间用，（逗号）分隔。比如：  --hcatalog-partition-keys year,month,day  --hcatalog-partition-values 1999,12,31 |
| --null-string '\\N'  --null-non-string '\\N'                 | 指定mysql数据为空值时用什么符号存储，null-string针对string类型的NULL值处理，--null-non-string针对非string类型的NULL值处理 |
| --hive-drop-import-delims                                    | 设置无视字符串中的分割符（hcatalog默认开启）                 |
| --fields-terminated-by '\t'                                  | 设置字段分隔符                                               |

