# Hive的优化

## 1- hive的优化_基础优化

### 1.1 hive的并行操作

* Hive编译查询限制 :  (一般是作为通用配置:  cm的hive上面)

  * 说明: Hive默认同时只能编译一段HiveQL，并上锁

  ```properties
  如何解决多个会话是, 同时只能有一个会话进行编译的问题 ? 
  hive.driver.parallel.compilation 设置为true  是否开启一次性编译多个sql的功能 默认为 false
  hive.driver.parallel.compilation.global.limit  默认值为3 表示一次性最多同时有三个会话进行编译sql
  	注意: 如果此值设置为 0 表示无边界, 此值是否会生效取决于第一个参数是否设置为true
  
  ```

* Hive不同阶段任务并行执行 : (一般是进行单独会话配置)

  * 说明: Hive会将一个查询转化为一个或多个阶段，包括：MapReduce阶段、抽样阶段、合并阶段、limit阶段等。默认情况下，一次只执行一个阶段。不过，如果某些阶段不是互相依赖，是可以并行执行的。

  ```properties
  set hive.exec.parallel=true;   默认值为false  表示是否要开启hive的并行执行
  set hive.exec.parallel.thread.number=16; 表示一次性一个sql中最大运行并行的数量  默认值8
  ```

### 1.2 hive的小文件合并

​	

- map 端小文件过多会有什么影响?  

​		hive在执行的sql的时候, 会将sql翻译为MR来执行, MR的读取目标数据的时候, 如果目标数据中有大量的小文件, 此时就会导致启动多个mapTask来执行, 此时对系统资源是一种极大的浪费, 导致执行效率降低

- reduce小文件过多会有什么影响?  

​		1) 对HDFS不友好 ,(不建议保存小文件)

​		2) 下次对结果表进行操作, 又会小文件过多的问题；

- 解决方案:

   在读取数据的时候, 对目标数据进行小文件合并, 将其合并为一个较大的文件 从而减少mapTask的数量

```properties
hive.merge.mapfiles : 是否开启 map端的小文件合并的操作:  默认值为 true
hive.merge.mapredfiles:  是否要开启reduce的输出小文件合并 : 默认值为false
hive.merge.size.per.task: 表示合并后的文件的大小 默认值为 268435456(256M) 
hive.merge.smallfiles.avgsize: 表示当输出文件的平均大小小于此设置值时，启动一个独立的map-reduce任务进行文件merge，默认值为16M。


注意: 以上调整的参数, 均可以直接在CM上调整操作
```



### 1.3 hive的矢量(批量)化操作

​		hive的默认查询执行引擎一次处理一行，而矢量化查询执行是一种hive特性，目的是按照每批1024行读取数据，并且一次性对整个记录整合（而不是对单条记录）应用操作,也可以理解为批量化操作

如何配置呢?

```sql
set hive.vectorized.execution.enabled=true; 默认就是true   是否开启批量化查询
```

**注意事项:** <span style="color:red;background:white;font-size:20px;font-family:楷体;">**要求读取的表的数据格式为ORC **</span>



### 1.4 读取零拷贝

​	在读取HDFS的数据的时候, <span style="color:blue;background:white;font-size:20px;font-family:楷体;">**只将需要的数据读取到内存中, 不需要的数据, 就不进行读取操作**</span>,

​	注意事项: <span style="color:red;background:white;font-size:20px;font-family:楷体;">**如果想要实现此功能, 要求表的数据格式 ORC**</span>

​	如何配置:

```properties
set hive.exec.orc.zerocopy=true;   默认值为false

示例: 
	A 表中 b c d 三个字段
	执行以下操作:
		select  b,c from A where  b= '' ;  
		
	说明:在开启读取零拷贝的情况下, 读取数据的时候, 只需要将表中 b和c这两列的数据读取到内存中即可
```



### 1.5 基础优化总结: 

```properties
set hive.driver.parallel.compilation=true --是否开启一次性编译多个sql的功能
set hive.driver.parallel.compilation.global.limit=3 --表示一次性最多同时有三个会话进行编译sql
set hive.exec.parallel=true; --表示是否要开启hive的并行执行
set hive.exec.parallel.thread.number=16; --表示一次性一个sql中最大运行并行的数量

set hive.vectorized.execution.enabled=true; 默认就是true   是否开启批量化查询
set hive.exec.orc.zerocopy=true; --是否开启读取零拷贝（只要有用字段）
```



## 2. hive的优化_数据倾斜

- 数据倾斜: 

  ​	在整个MR执行过程中, 有多个reduce程序, 多个reduce程序之间处理数据量相差甚远



- 思考: 在做什么样操作的时候下, 会导致有可能出现数据倾斜? 

  ​	 <span style="color:red;background:white;font-size:20px;font-family:楷体;">**join操作 和 group by**</span> 

  - join

    ![image-20210309164126251](images/image-20210309164126251.png)

  - group by 

    ![image-20210309164355790](images/image-20210309164355790.png)

### 2.1 数据倾斜_join倾斜

* 解决方案一:  <span style="color:red;background:white;font-size:20px;font-family:楷体;">**通过 mapjoin 、  bucket mapjoin 以及 smb join**</span>

* 解决方案二:  将那些容易产生数据倾斜的key值抽取出来, 使用一个单独的MR进行处理即可

  * 实施方案一: 运行时优化 

    * 配置:

      ```properties
      set hive.optimize.skewjoin=true; 开启 运行时的join数据倾斜优化
      set hive.skewjoin.key=100000; 当这个key的值出现多少个的时候, 认为是有数据倾斜的问题
      ```

    * 说明: 在运行的过程中, 时刻监控着k2的值, 当k2中某个值出现的次数大于设置的值, 认为此值出现数据倾斜, 将其单独存储起来, 通过一个单独的MR对其进行单独处理即可

    * 注意: 

      ​	<span style="color:red;background:white;font-size:20px;font-family:楷体;">**此种优化, 如果数据中 大多数key都大于了此值, 此时不建议开启此优化。如果要使用这个优化, 需要调整hive.skewjoin.key此值大小**</span>。

  * 实施方案二: 编译时优化

    * 相关的配置

      ```properties
      set hive.optimize.skewjoin.compiletime=true;  默认关闭  
      ```

    * 整体优化思想都是一样的, 只不过编译时优化在编译器形成执行计划的时候, 就已经优化完毕了

    * 注意: <span style="color:red;background:white;font-size:20px;font-family:楷体;">**在执行之前,或者建表之前,  就需要指定那些key的值会导致数据倾斜**</span>

    * 示例

      ```sql
      CREATE TABLE list_bucket_single (key STRING, value STRING)
      -- 倾斜的字段和需要拆分的key值
      SKEWED BY (key) ON (1,5,6)
      --  为倾斜值创建子目录单独存放
      [STORED AS DIRECTORIES];
      ```

  - 实际使用中, 如何选择呢?   

    ​		在具体使用时候, 可以两个都开启为true, 这样当出现了编译期设置的key值, 直接抬走；如果是编译期没有考虑到的值, 在运行过程中, 发现了, 也可以进行优化处理。

    

  - 我们怎么知道数据倾斜？

    - 1- 查看SQL执行的时候,转换的MR是否出现了多个reduce;

    ![image-20210109110213356](images/image-20210109110213356.png)

    - 2- 查看各个reduce,是否有reduce执行时长远远大于其它的reduce;

    ![image-20210109110254796](images/image-20210109110254796.png)





### 2.2 union all的优化

​	在进行join的数据倾斜优化的时候, 不管采用 运行时的, 还是编译时, 都是将能产生倾斜的key值, 单独拿出来, 使用一个单独MR进行处理, 处理后和之前结果进行union all 合并操作

​	正常情况下, union all 也需要单独运行一个MR, 将两个结果进行合并, 出现到一个目标目录下

​	在跑一个MR 对效率也会产生影响, 能否不执行union all的合并操作呢, 直接让上面的MR 直接将结果输出的目的地

```properties
解决方案:
	set hive.optimize.union.remove=true;

此操作一般与 数据倾斜_join倾斜优化 同时开启, 对 数据倾斜_join倾斜优化 最后合并操作进行优化
```

``` properties
set hive.optimize.skewjoin=true;  --开启 运行时的join数据倾斜优化
set hive.skewjoin.key=100000;  --当这个key的值出现多少个的时候, 认为是有数据倾斜的问题
set hive.optimize.skewjoin.compiletime=true; -- 开启 编译时的join数据倾斜优化
set hive.optimize.union.remove=true;  -- 开启 union all 的优化
```



### 2.3 数据倾斜_group by的数据倾斜

- 数据倾斜案例，如图：

![image-20210310082552321](images/image-20210310082552321.png)

* 方案一:小规约  开启 map端的局部聚合操作
  * 配置: **hive.map.aggr=true;**
  * 方案一原理流程图：


![image-20210310082657015](images/image-20210310082657015.png)





* 方案二: 大规约  运行两个MR , 第一个MR 进行局部聚合操作, 第二个MR 进行最终聚合操作

  * 配置: **hive.groupby.skewindata=true;** 

  * 使用的注意事项:

    ```properties
    如果使用方案二进行group by 数据倾斜的解决, 要求sql中不允许出现多个列做distinct操作, 只能出现一次
    
    例如: 
    	SELECT ip, count(DISTINCT uid), count(DISTINCT uname) FROMlog GROUP BY ip 
    		此操作 就会直接报错, 因为此sql中出现多次distinct操作
    		报错内容: DISTINCT on different columns notsupported with skew in data.
    ```

  - 方案二原理流程图：

    第一个MR：先将所有的数据轮询一样分给两个reduce，这样就不会有数据倾斜；

  ![image-20210310082823242](images/image-20210310082823242.png)

     第二个MR : 将第一个MR的输出结果作为第二个MR的输入；

  ![image-20210310083056000](images/image-20210310083056000.png)





- 总结：

``` properties
set hive.map.aggr=true; -- hive group by 数据倾斜 map端局部聚合优化
set hive.groupby.skewindata=true; --hive的 group by 数据倾斜，使用两个MR的优化
```





### 2.4 关联优化器

​		在hive执行sql的时候, 一个sql翻译的MR中可能会出现多次shuffle操作, 而多次的shuffle操作有可能是可以共享的, 此时就可以将shuffle进行共享, 从而减少shuffle次数, 从而提升效率

如何实施:

```properties
set hive.optimize.correlation=true;

```



总结

```properties
-- 以下是hive的并行优化
set hive.driver.parallel.compilation=true  --是否开启一次性编译多个sql的功能
set hive.driver.parallel.compilation.global.limit=3 ----表示一次性最多同时有三个会话编译sql
set hive.exec.parallel=true;		--开启hive的并行执行
set hive.exec.parallel.thread.number=16;    --表示一次性一个sql中最大运行并行的数量 

-- 以下是hive的小文件合并优化
set hive.merge.mapfiles = true ;  -- 开启hive的map端小文件合并
set hive.merge.mapredfiles= true; -- 开启hive的reduce端小文件合并
hive.merge.size.per.task: 表示合并后的文件的大小 默认值为 268435456(256M) 
hive.merge.smallfiles.avgsize: 表示当输出文件的平均大小小于此设置值时，启动一个独立的map-reduce任务进行文件merge，默认值为16M。


set hive.exec.orc.zerocopy=true;   -- hive的读取零拷贝
set hive.vectorized.execution.enabled=true; -- hive的矢量化的查询优化

-- 以下是hive 的join操作数据倾斜优化
set hive.optimize.skewjoin=true;	--开启 运行时的join数据倾斜优化
set hive.skewjoin.key=100000;  --当这个key的值出现多少个的时候, 认为是有数据倾斜的问题
set hive.optimize.skewjoin.compiletime=true;  -- hive的 开启 编译时的join数据倾斜优化
set hive.optimize.union.remove=true;  -- hive union all的优化方案

-- 以下是hive 的 group by 操作数据倾斜优化
set hive.map.aggr=true;   -- hive group by 数据倾斜 map端局部聚合优化
set hive.groupby.skewindata=true;   -- hive的 group by 数据倾斜，使用两个MR的优化

set hive.optimize.correlation=true; -- hive的关联优化器 减少shuffle次数

```







## 3. hive的索引优化

- 索引: 提升读写的效率


- 为什么说索引可以提升性能? 


![image-20210105101640860](images/image-20210105101640860.png)

- 在hive中, 同样也是支持索引的, hive的索引主要三大类: 

  - 原始索引
  - Row Group Index: 行组索引
  - Bloom Filter Index:  开发过滤索引

  

###  原始索引 -- 不推荐使用

* 特点：
* <span style="color:blue;background:white;font-size:20px;font-family:楷体;">**索引表不会自动更新**</span>；
* 注意: 
  * 手动更新, 本质就上在重建索引操作

```properties
在对目标表进行数据的更新(增删改)操作, hive的原始索引不会进行自动更新的,需要进行手动更新
	手动更新的效率是极低的
所以说, 在hive的3.0版本后, 不支持构建原始索引了
注意: 手动更新, 本质就上在重建索引操作
```



### Row Group Index: 行组索引

![wps2](images/wps2-1615530683381.png)



- 过程描述：

``` properties
描述过程: 
	针对ORC类型存储格式表, 一旦开启了行组索引, 在ORC文件中每个scripts的片段（256M）中会保持每个字段的最大最小值的索引数据（IndexData）,这里的IndexData 就是Row Group Index 行组索引 也叫min-max Index大小对比索引;
	当查询时候, 根据这个建立行组索引的字段查询时候, 可以过滤掉不需要扫描的片段, 从而减少扫描量, 提升查询的性能;
```



- 使用行组条件必要条件

```properties
条件: 
 	1) 表必须是ORC类型
 	2) 建表时, 必须制定以下信息: ’orc.create.index’=’true’   开启行组索引
 	3) 在插入数据的时候, 必须要对建立索引的字段进行排序;否则min/max值就无意义;
 	4) 一般使用在数值类型的字段上
```



例子:

```sql
CREATE TABLE lxw1234_orc2 stored AS ORC
TBLPROPERTIES
(
    'orc.compress'='SNAPPY',

    'orc.create.index'='true'    --     开启行组索引
)

插入数据: 
    insert into table  lxw1234_orc2 
        SELECT CAST(siteid AS INT) AS id,
            pcid
            FROM lxw1234_text

            DISTRIBUTE BY id sort BY id; --     插入的数据保持排序
    
查询数据: 
	SELECT COUNT(1) FROM lxw1234_orc1 WHERE id >= 1382 AND id <= 1399;

```



### Bloom Filter Index:  开发过滤索引

- 过程描述：

``` properties
描述过程:
	一旦通过开发过滤索引, 对表中某几个字段建立索引, 在ORC的每个script片段中, 就会记录下这个字段对应的值,存储在那些位置上, 查询时候, 根据查询的字段的值, 从索引中确定要查询的值在哪些片段中, 直接到片段中获取即可, 这样也相当于减少扫描量, 从而提升性能;
```

- 使用开发过滤索引必要条件

```properties
条件: 
	1) 表必须是ORC类型;
	2) 在建表的时候, 需要指定那些字段作为开发过滤索引: "orc.bloom.filter.columns"="字段1,字段2.."
	3) 只能进行 等值（=） 过滤查询, 不局限于类型
```

例子:

```sql
CREATE TABLE lxw1234_orc2 stored AS ORC
TBLPROPERTIES
(
    'orc.compress'='SNAPPY',
    'orc.create.index'='true',  -- 可以共用, 也可以单用
--     pcid字段开启BloomFilter索引
    "orc.bloom.filter.columns"="pcid"
)

插入数据: 如果是单用开发过滤索引, 插入方案不限
insert into table lxw1234_orc2 
SELECT CAST(siteid AS INT) AS id,
pcid
FROM lxw1234_text
DISTRIBUTE BY id sort BY id;
注意: 由于在建表的额时候, 使用行组索引, 所以需要对建立行组索引字段, 进行排序插入

使用操作: 
	SELECT COUNT(1) FROM lxw1234_orc1 WHERE id >= 0 AND id <= 1000  
	AND pcid IN ('0005E26F0DCCDB56F9041C','A');

```



### hive的索引优化总结

- 空间换时间的操作；

- 在使用开发过滤索引, 如何选择索引字段:  

```properties
 将那些经过被作为where条件或者是join条件的等值连接的字段, 作为开发过滤索引的字段。 
```

