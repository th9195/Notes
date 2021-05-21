# Hive2优化

## 1-优化步骤

* Hive配置优化
* Hive压缩配置优化
* Hibe的拉链表使用
* Hive的分桶
* Hive并行操作
* Hive索引
* Hive小文件处理
* Hive的数据倾斜
* Hive优化器

## Hive配置优化

* Hiveserver2异常退出，导致连接失败的问题。解决方法：修改HiveServer2 的 Java 堆栈大小。

* SQL的limit的优化

  * limit 语句快速出结果一般情况下，Limit语句还是需要执行整个查询语句，然后再返回部分结果。有一个配置属性可以开启，避免这种情况。

    Set hive.limit.optimize.enable=true;（默认为false）

    hive.limit.row.max.size=100000;（limit最多可以查询多少行，根据需求可以调大）

    hive.limit.optimize.limit.file=10;（一个查询可以操作的最多文件数，根据需要适当调大）

    hive.limit.optimize.fetch.max=50000;（fetch query，直接select from，能够获取的最大行数）

* Hive执行引擎

  * Tez---hdp中使用的
  * Spark--SparkOnHive
  * MR---比较稳定

## Hive压缩配置优化

* 整合Hive是MR的客户端，底层运行的还是MR
  * mapreduce.map.output.compress map的网络输出减少网络传输
  * mapreduce.reduce.output.compress reduce的网络输出减少网络传输
  * set hive.exec.compress.intermediate=true;控制 Hive 在多个 map-reduce 作业之间生成的中间 files 是否被压缩
  *  set hive.exec.compress.output=true;最终输出(到 local/hdfs 文件或 Hive table)

## Hive的拉链表使用
## Hive的分桶

* \1. 分桶和分区两者不干扰，可以把分区表进一步分桶；

  \2. 分桶对数据的处理比分区更加细粒度化：分区针对的是数据的存储路径；分桶针对的是数据文件；

  \3. 分桶是按照列的哈希函数进行分割的，相对比较平均；而分区是按照列的值来进行分割的，容易造成数据倾斜。

* 如何避免针对桶表使用load data插入数据的误操作呢？

  --限制对桶表进行load操作set hive.strict.checks.bucketing = true;

  也可以在CM的hive配置项中修改此配置，当针对桶表执行load data操作时会报错。

  那么对于文本数据如何处理呢？

  (1. 先创建临时表，通过load data将txt文本导入临时表。

  创建临时表create table temp_buck(id int, name string)row format delimited fields terminated by '\t';

  导入数据load data local inpath '/tools/test_buck.txt' into table temp_buck;

  (2. 使用insert select语句间接的把数据从临时表导入到分桶表。

  **启用桶表set hive.enforce.bucketing=true**

  **限制对桶表进行load操作set hive.strict.checks.bucketing = true;**

  **insert selectinsert into table test_buck select id, name from temp_buck;--分桶成功**

## Hive并行操作

* HIve编译

* Hive默认同时只能编译一段HiveQL，并上锁

  * 将hive.driver.parallel.compilation设置为true，各个会话可以同时编译查询，提高团队工作效率。
  * 修改hive.driver.parallel.compilation.global.limit的值，0或负值为无限制，可根据团队人员和硬件进行修改，以保证同时编译查询。

* set hive.exec.parallel=true,可以开启并发执行，默认为false。

  set hive.exec.parallel.thread.number=16; //同一个sql允许的最大并行度，默认为8。

## Hive索引

* ##### Row Group Index

  * 当查询中有<,>,=的操作时
  * 设置***\*hive.optimize.index.filter\****为true，并重启hive
    *  'orc.create.index'='true'
    * DISTRIBUTE BY id sort BY id;

* Bloom Filter Index

  * 当查询条件中包含对该字段的=号过滤时候
    * 在建表时候，通过表参数”orc.bloom.filter.columns”=”pcid”来指定为那些字段建立BloomFilter索引

## Hive小文件处理

* hive.merge.mapfiles

是否开启合并Map端小文件，在Map-only的任务结束时合并小文件，true是打开。

* hive.merge.mapredfiles

  是否开启合并Reduce端小文件，在map-reduce作业结束时合并小文件。true是打开。

  hive.merge.size.per.task

  合并后MR输出文件的大小，默认为256M。

  hive.merge.smallfiles.avgsize

  当输出文件的平均大小小于此设置值时，启动一个独立的map-reduce任务进行文件merge，默认值为16M。

* 矢量化查询

* hive的默认查询执行引擎一次处理一行，而矢量化查询执行是一种hive特性，目的是按照每批1024行读取数据

* 读取零拷贝

  *  set hive.exec.orc.zerocopy=true;
  *  ORC可以使用新的HDFS缓存API和ZeroCopy读取器来来避免数据读取到内存中

## Hive的数据倾斜[最重要]

* ![image-20200902114847328](05-Hive2优化(面试必备).assets/image-20200902114847328.png)

* ***\*hive.map.aggr=true;\****

  开启map端combiner。此配置可以在group by语句中提高HiveQL聚合的执行性能。这个设置可以将顶层的聚合操作放在Map阶段执行，从而减轻数据传输和Reduce阶段的执行时间，提升总体性能。默认开启，无需显示声明。

  ***\*hive.groupby.skewindata=true;\****

  默认关闭。

  这个配置项是用于决定group by操作是否支持倾斜数据的负载均衡处理。当数据出现倾斜时，如果该变量设置为true，那么Hive会自动进行负载均衡。

  当选项设定为 true，生成的查询计划会有两个 MR Job。

  第一个MR Job中，**Map 的输出结果集合会随机分布到Reduce中**，每个Reduce做部分聚合操作，并输出结果，这样处理的结果是相同的Group By Key有可能被分发到不同的Reduce中，从而达到负载均衡的目的；

  **第二个MR Job再根据预处理的数据结果按照Group By Key分布到Reduce中**（这个过程可以保证相同的Group By Key被分布到同一个Reduce中），最后完成最终的聚合操作。

* 在Hive2中可以没有必要去在sql中增加随机数为了防止数据倾斜，这里有一个两个MR完成这个类似任务，这里一定要注意

* 运行时优化：

  * ***\*set hive.optimize.skewjoin=true;\****

    默认关闭。

    如果大表和大表进行join操作，则可采用skewjoin(倾斜关联)来开启对倾斜数据的优化。

    ***\*skewjoin原理：\****

    \1. 对于skewjoin.key，在执行job时，将它们存入临时的HDFS目录，其它数据正常执行

    \2. 对倾斜数据开启map join操作（多个map并行处理），对非倾斜值采取普通join操作

    \3. 将倾斜数据集和非倾斜数据集进行合并Union操作。

     

    开启skewin以后，究竟多大的数据才会被认为是倾斜了的数据呢？

    ***\*set hive.skewjoin.key=100000;\****

    默认值100000。

    如果join的key对应的记录条数超过这个值，就认为这个key产生了数据倾斜，则会对其进行分拆优化。

  * 编译时优化

    * 上面的配置项其实应该理解为hive.optimize.skewjoin.runtime，也就是sql运行时来对偏斜信息进行优化；除此之外还有另外一个配置：

      ***\*set hive.optimize.skewjoin.compiletime=true;\****

      默认关闭。

      此参数的用处和上面的hive.optimize.skewjoin一致，但在编译sql时就已经将执行计划优化完毕。但要注意的是，只有在表的元数据中存储的有数据倾斜信息时，才能生效。因此建议runtime和compiletime都设置为true。

  * Union操作

    * 应用了表连接倾斜优化以后，会在执行计划中插入一个新的union操作，此时建议开启对union的优化配置：

      ***\*set\**** ***\*hive.optimize.union.remove\*******\*=true;\****

## Hive优化器

* 基于代价的优化（CBO）引擎，类似于SparkSQL中的CBO基于代价函数的优化

## 数据压缩&数据格式

项目使用的什么数据格式？什么压缩格式？为什么使用这些？

数据格式：ORC，parquet压缩格式：Snappy和Zlib。

ORC同时具备行式存储和列式存储的优点，且压缩速度快，能够高效的实现存和取。

Snappy压缩速度快、压缩率合理，配合ORC能够达到最优的性能；Zlib压缩率很高，对于一些使用率很低，且数据量很大的数据，可以使用Zlib节省磁盘空间。

* 问题，对于数据仓库分层，请问如何选择压缩格式和数据格式
* 答案：
* ods层数据非常多，做了HDFS的映射，适合于Zlib压缩，其他的层次均使用snappy
* ods层数据数据格式采用的额是ORC的格式，其他层次使用的是parquet的格式
* ![image-20200902112456698](05-Hive2优化(面试必备).assets/image-20200902112456698.png)
* 

## MapJoin变体

* mapJoin

  * 在Map阶段进行表之间的连接。而不需要进入到Reduce阶段才进行连接。这样就节省了在Shuffle阶段时要进行的大量数据传输

  * 适合于：达标关联小表，将小表放置在内存中

  * 记住：在hive2中mapjoin会自动开启，可以指定mapjpin的小表的阈值，默认的阈值为20M，可以根据具体的业务进行修改

  * ![image-20200902113226994](05-Hive2优化(面试必备).assets/image-20200902113226994.png)

  * ![image-20200902113240711](05-Hive2优化(面试必备).assets/image-20200902113240711.png)

  * MapJoin的使用场景：

    \1. 关联操作中有一张表非常小

    \2. 不等值的链接操作

* BucketJoin--大表关联中表，可以对两个表均做hash在join操作

  * 产生条件

  * 1） set hive.optimize.bucketmapjoin = true;
    2） 一个表的bucket数是另一个表bucket数的整数倍
    3） bucket列 == join列
    4） 必须是应用在map join的场景中

    注意：如果表不是bucket的，则只是做普通join。

* SMBJoin--适合于大表关联大表的场景

  * SMB Join基于bucket-mapjoin的***\*有序bucket\****，可实现在map端完成join操作，可以有效地减少或避免shuffle的数据量。

* 综上，涉及到分桶表操作的齐全配置为：

  ```
  --写入数据强制分桶set hive.enforce.bucketing=true;
  --写入数据强制排序set hive.enforce.sorting=true;
  --开启bucketmapjoinset hive.optimize.bucketmapjoin = true;
  --开启SMB Joinset hive.auto.convert.sortmerge.join=true;
  set hive.auto.convert.sortmerge.join.noconditionaltask=true;
  ```

  开启MapJoin的配置（hive.auto.convert.join和hive.auto.convert.join.noconditionaltask.size），还有限制对桶表进行load操作（hive.strict.checks.bucketing）可以直接设置在hive的配置项中，无需在sql中声明。

  自动尝试SMB联接（hive.optimize.bucketmapjoin.sortedmerge）也可以在设置中进行提前配置。

## 程序中放置的形式

* ![image-20200902114408367](05-Hive2优化(面试必备).assets/image-20200902114408367.png)