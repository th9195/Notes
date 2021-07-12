# 01- Phoenix基本入门操作

## 1-0 进入Phoenix ./sqlline.py

``` shell
cd /export/server/apache-phoenix-5.0.0-HBase-2.0-bin/bin
[root@node1 bin]# ./sqlline.py 

```



## 1-1 构建表

- 注意： 
  1. Phoenix在建表的时候, 默认会将小写字段或者表名或者列族名称自动转换为大写；
  2. 只需要在需要小写文件, 添加双引号；
  3. 一旦使用小写, 在后期所有操作这个小写的内容, 都需要使用双引号  建议使用 大写；
  4. **单引号表示是字符串 双引号用于标识是小写的字段**；
  5. 建表的时候, 主键字段不能带列族；

- 格式

``` sql
create table if not exists 表名 (
        rowkey名称  数据类型  primary key ,
        列族名称.列名1 数据类型 ,
        列族名称.列名2 数据类型 ,
        ....
    );
```

- 案例

``` sql
create table if not exists order_info (
id  varchar(50)  primary key ,
c1.status varchar(10) ,
c1.money float ,
c1.pay_way integer ,
c1.user_id varchar(20),
c1.operation_time varchar(20),
c1.category  varchar(20)
);
```



## 1-2 查看所有的表

- 格式

``` sql
!table
```

- 案例

``` sql
0: jdbc:phoenix:> !table
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+---+
| TABLE_CAT  | TABLE_SCHEM  | TABLE_NAME  |  TABLE_TYPE   | REMARKS  | TYPE_NAME  | SELF_REFERENCING_COL_NAME  | REF_GENERATION  | I |
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+---+
|            | SYSTEM       | CATALOG     | SYSTEM TABLE  |          |            |                            |                 |   |
|            | SYSTEM       | FUNCTION    | SYSTEM TABLE  |          |            |                            |                 |   |
|            | SYSTEM       | LOG         | SYSTEM TABLE  |          |            |                            |                 |   |
|            | SYSTEM       | SEQUENCE    | SYSTEM TABLE  |          |            |                            |                 |   |
|            | SYSTEM       | STATS       | SYSTEM TABLE  |          |            |                            |                 |   |
|            |              | ORDER_DTL   | TABLE         |          |            |                            |                 |   |
|            |              | ORDER_INFO  | TABLE         |          |            |                            |                 |   |
|            | MOMO_CHAT    | MSG         | VIEW          |          |            |                            |                 |   |
+------------+--------------+-------------+---------------+----------+------------+----------------------------+-----------------+---+
0: jdbc:phoenix:> 

```

## 1-3 查看某个表信息

- 格式

``` sql
!desc 表名
```

- 案例

``` sql
0: jdbc:phoenix:> !desc order_info
+------------+--------------+-------------+-----------------+------------+------------+--------------+----------------+--------------+
| TABLE_CAT  | TABLE_SCHEM  | TABLE_NAME  |   COLUMN_NAME   | DATA_TYPE  | TYPE_NAME  | COLUMN_SIZE  | BUFFER_LENGTH  | DECIMAL_DIGI |
+------------+--------------+-------------+-----------------+------------+------------+--------------+----------------+--------------+
|            |              | ORDER_INFO  | ID              | 12         | VARCHAR    | 50           | null           | null         |
|            |              | ORDER_INFO  | STATUS          | 12         | VARCHAR    | 10           | null           | null         |
|            |              | ORDER_INFO  | MONEY           | 6          | FLOAT      | null         | null           | null         |
|            |              | ORDER_INFO  | PAY_WAY         | 4          | INTEGER    | null         | null           | null         |
|            |              | ORDER_INFO  | USER_ID         | 12         | VARCHAR    | 20           | null           | null         |
|            |              | ORDER_INFO  | OPERATION_TIME  | 12         | VARCHAR    | 20           | null           | null         |
|            |              | ORDER_INFO  | CATEGORY        | 12         | VARCHAR    | 20           | null           | null         |
+------------+--------------+-------------+-----------------+------------+------------+--------------+----------------+--------------+
0: jdbc:phoenix:> 

```

## 1-4 删除表

- 格式1

``` sql
drop table 表名;
```

- 案例1

``` sql
0: jdbc:phoenix:> drop table order_dtl;
No rows affected (1.323 seconds)
0: jdbc:phoenix:> !table

```



- 格式2 

``` sql
!drop 表名
```

- 案例2

``` sql
0: jdbc:phoenix:> !drop order_info;
Really drop every table in the database? (y/n)abort-drop-all: Aborting drop all tables.y
1/1          DROP TABLE ORDER_INFO;
No rows affected (0.694 seconds)
0: jdbc:phoenix:> 

```





## 1-5 插入/修改数据

- 格式

``` sql
格式1:upsert into 表名 (列族.列名1,列族.列名2 ..... ) values(值1,值2....)
格式2:upsert into 表名 values(所有列值);
```

- 案例

``` sql
upsert into 
	order_info 
values
	('00001','status',22.5,1,'user_id','operation_time','category');

```

## 1-6 查询数据

- 注意:
  - Phoenix不支持多表查询和子查询操作, 只能进行简单的单表查询工作

- 格式

``` sql
select 列族.列名1,列族.列名2,列族.列名3... from  表名 where ;
```

- 案例

``` sql
0: jdbc:phoenix:> select * from order_info where id = '00001';
+--------+---------+--------+----------+----------+-----------------+-----------+
|   ID   | STATUS  | MONEY  | PAY_WAY  | USER_ID  | OPERATION_TIME  | CATEGORY  |
+--------+---------+--------+----------+----------+-----------------+-----------+
| 00001  | status  | 22.5   | 1        | user_id  | operation_time  | category  |
+--------+---------+--------+----------+----------+-----------------+-----------+
1 row selected (0.041 seconds)
0: jdbc:phoenix:> 

```



## 1-8 删除数据

- 格式

``` sql
delete from 表 ....  与标准的SQL是一致的
```

- 案例

``` sql
0: jdbc:phoenix:> delete from order_info where id = '00001';
1 row affected (0.01 seconds)
0: jdbc:phoenix:> 

```



## 1-9 分页查询

- 注意:  limit n offset m
  -  n: 查询n条数据
- m: 冲第m+1条开始查询；
  
- 格式

``` sql
select * from 表名  limit n offset m
```

- 案例

``` sql
0: jdbc:phoenix:> select * from order_info limit 2 offset 0;
+---------+---------+---------+----------+----------+----------------------+-----------+
|   ID    | STATUS  |  MONEY  | PAY_WAY  | USER_ID  |    OPERATION_TIME    | CATEGORY  |
+---------+---------+---------+----------+----------+----------------------+-----------+
| 000001  | 以提交     | 4070.0  | 1        | 4944191  | 2020-04-25 12:09:16  | 手机        |
| 111     | 22      | 22.5    | 2        | aaa      | bbb                  | ccc       |
+---------+---------+---------+----------+----------+----------------------+-----------+
2 rows selected (0.062 seconds)
0: jdbc:phoenix:> 

```





# 02- Phoenix预分区操作

## 2-1 手动分区

- 格式

``` sql
create table if not exists 表名 (
id  varchar(50)  primary key ,
列族名.列名1 varchar(10) ,
列族名.列名2  float ,
......
)
COMPRESSION='GZ'
SPLIT ON (手动分区策略);
```

- 案例

``` sql
create table if not exists order_dtl (
id  varchar(50)  primary key ,
c1.status varchar(10) ,
c1.money float ,
c1.pay_way integer ,
c1.user_id varchar(20),
c1.operation_time varchar(20),
c1.category  varchar(20)
)
COMPRESSION='GZ'
SPLIT ON ('1','2','3','4','5');
```



## 2-2 加盐salt_buckets的方式

- 格式

``` sql
create table if not exists 表名 (
id  varchar(50)  primary key ,
列族名.列名1 varchar(10) ,
列族名.列名2  float ,
......
)
COMPRESSION='GZ'
salt_buckets=分区个数;
```

- 案例

``` sql
drop table order_dtl;
create table if not exists order_dtl (
id  varchar(50)  primary key ,
c1.status varchar(10) ,
c1.money float ,
c1.pay_way integer ,
c1.user_id varchar(20),
c1.operation_time varchar(20),
c1.category  varchar(20)
)
COMPRESSION='GZ', 
salt_buckets=6;
```



# 03- Phoenix视图

- 如果在使用phoenix 之前使用hbase shell 创建的表， 在phoenix 里面是看不到的。故此我们需要使用Phoenix 中的视图，通过视图来建立与HBase表之间的映射。从而实现数据快速查询；


- 应用场景:
  - 表已经存储在hbase中, 希望能够通过Phoenix对其建立映射, 从而让其支持使用SQL的查询数据

## 3-1 创建视图

- 语法
- 注意：
  - 这里的命名空间 和 表名要个HBase 中的保持一致；
  - rowkey 可以随意取名；
  - 列族.列名要和HBase 中的保持一致；

``` sql
create view "命名空间"."表名"(
	rowkey varchar primary key,
    列族.列名1 数据类型，
    列族.列名2 数据类型，
	......
);
说明:
   1) 视图的名称 必须是hbase中对应的表的名称, 如果是其他名称空间, 也需要带上名称空间
   		格式为: 名称空间.myHbaseTable
   2)  rowkey的列名可以任意, 无所谓
   3) 其他列名, 必须是原有表中对应的列族.列名 (区分大小写)  与hbase表中列族字段完全一致


-- 指定默认的列族名称 --
create view "命名空间"."表名"(
	rowkey varchar primary key,
    列名1 数据类型，
    列名2 数据类型，
	......
)default_column_family='C1';

```

- 案例

``` sql
create view if not exists "MOMO_CHAT"."MSG" (
"pk" varchar primary key,
"C1"."msg_time" varchar,
"C1"."sender_nickyname" varchar,
"C1"."sender_account" varchar,
"C1"."sender_sex" varchar,
"C1"."sender_ip" varchar,
"C1"."sender_os" varchar,
"C1"."sender_phone_type" varchar,
"C1"."sender_network" varchar,
"C1"."sender_gps" varchar,
"C1"."receiver_nickyname" varchar,
"C1"."receiver_ip" varchar,
"C1"."receiver_account" varchar,
"C1"."receiver_os" varchar,
"C1"."receiver_phone_type" varchar,
"C1"."receiver_network" varchar,
"C1"."receiver_gps" varchar,
"C1"."receiver_sex" varchar,
"C1"."msg_type" varchar,
"C1"."distance" varchar,
"C1"."message" varchar
);



```



- 使用 phoenix 查询momo_chat.msg表 


``` sql
-- 根据发送时间和发送人账号 接收人账号查询；
select 
	c1."sender_account",
	c1."receiver_account",
	c1."msg_time",
	c1."message" 
from 
	momo_chat.msg 
where 
	substr(c1."msg_time",0,10) = '2021-01-31' 
and 
	c1."sender_account" = '18461866438' 
and 
	c1."receiver_account"='13641568674';
```



# 04- Phoenix二级索引

- 索引说明
  - 查看图片：05-Phoenix\images\01- 索引说明.png
  - id字段是主键字段，而主键字段具有唯一性和非空性，同时主键字段自带索引；
  - 二级索引的思想：**以空间换时间**；
  - 根据常使用的字段作为一个索引表；
  - 当执行SQL时，先去索引表查询（根据主键查询），得到结果；
  - 拿着这个结果再到目标表中查询，此时也时根据主键查询；

![01- 索引说明](images\01- 索引说明.png)

## 4-1 全局索引 （适合读多写少）

- 可以给表中任意的字段构建索引, 构建之后, 会形成一个**单独**的索引表;
- 这个索引表和原有目标表拥有一样的region的数量 ;
- 全局索引适用于**读多写少**业务;
- 原**表更新后全局索引表需要[重建]()**；（[**缺点**]()）
  - 全局索引绝大多数[**负载**]()都发生在写入时，当构建了全局索引时，Phoenix会拦截写入(DELETE、UPSERT值和UPSERT SELECT)上的数据表更新，构建索引更新，同时更新所有相关的索引表，开销较大；；
- 读取时，Phoenix将选择最快能够查询出数据的索引表。默认情况下，除非使用Hint，如果SELECT查询中引用了其他  **非索引列**，该索引是不会生效的；
  - 如： select * from user where address ='北京' ;  这里使用了 * 包含了非索引列；就不能通过二级索引查询；
- **全局索引** 一般和  **覆盖索引**  搭配使用，读的效率很高，但写入效率会受影响

- 语法

``` sql
创建语法: 
	create index  索引名称 on 表名(列名1, 列名2 ....)
	
删除索引:
	drop index 索引名称 on 表名;
```



## 4-2 本地索引 （适合写多）

* 本地索引 **不需要** 在**单独构建一张索引表**;

* 其索引数据, 直接放置在目标表中, 适合于 **写多** 的场景；

* 在查询的时候, 只要查询表中某个字段建立了本地索引,即使有**非索引字段**在参与查询, **依然可用**的；

* 注意事项: 

  * 如果表采用的**加盐的预分区方案(salt_buckets)**来构建的, 不能使用本地索引(只是不能使用select *);

    

* 创建语法: 

``` sql
create local index  索引名称 on 表名(列名1, 列名2 ....);
```



## 4-3 覆盖索引 

- 可以被表中任意的字段构建覆盖 索引;
- 建立之后, 将一些需要显示的字段全部覆盖在索引表中，在查询的时候, **不需要在去到主表查询**;
- 可以减少查询的时间, 提升效率;
- 但是带来弊端, 导致数据出现**冗余**情况
- 注意: 
  - **无法单独使用, 必须结合全局或者本地索引**;

- 创建语法:

``` sql
create [local] index my_index on 目标表(列1,列2...) include(覆盖索引列....)
```



## 4-4 函数索引

* 可以针对某一个函数的结果 构建索引；
* 将结果数据建好索引, 这样当我们使用这个函数时可以直接将结果返回；
* 创建语法:

``` sql
create  index  索引名称 on 表名(函数)
```





# 05- 二级索引案例

## 5-1 创建全局索引+覆盖索引

- 需求: 根据用户id, 查询这个用户的id和支付的金额
- 执行SQL

``` sql
select user_id, id, money  from order_dtl where c1.user_id='4060214';
```

- explain查看扫描模式 
  - 默认是全局扫描 (FULL SCAN)；

``` sql
explain select user_id, id, money  from order_dtl where c1.user_id='4060214';
+---------------------------------------------------------------------+-----------------+----------------+--------------+
|                                PLAN                                 | EST_BYTES_READ  | EST_ROWS_READ  | EST_INFO_TS  |
+---------------------------------------------------------------------+-----------------+----------------+--------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN FULL SCAN OVER ORDER_DTL  | null            | null           | null         |
|     SERVER FILTER BY C1.USER_ID = '4060214'                         | null            | null           | null         |
+---------------------------------------------------------------------+-----------------+----------------+--------------+
2 rows selected (0.017 seconds)

```

- 使用索引提升优化:  全局索引 + 覆盖索引
  - 全局索引 ：c1.user_id;
  - 覆盖索引 ：id,c1.money

``` sql
create index gbl_idx_order_dtl on order_dtl(c1.user_id) include(id,c1.money);
```

- 再次查看扫描模式
  - RANGE SCAN 区域扫描

``` sql
0: jdbc:phoenix:> explain select user_id,id,money from order_dtl where c1.user_id = '4060214';
+------------------------------------------------------------------------------------------------------------+-----------------+-----+
|                                                    PLAN                                                    | EST_BYTES_READ  | EST |
+------------------------------------------------------------------------------------------------------------+-----------------+-----+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN RANGE SCAN OVER GBL_IDX_ORDER_DTL [0,'4060214'] - [4,'4060214']  | null            | nul |
+------------------------------------------------------------------------------------------------------------+-----------------+-----+
1 row selected (0.029 seconds)
0: jdbc:phoenix:> 

```

- 如果select 查询时 引用了非索引字段就**不再使用二级索引**查询了（**与本地索引不同的地方**）
  - explain扫描模式又是 FULL SCAN

``` sql
--如： 在查询中添加一个 status 字段--
0: jdbc:phoenix:> explain select id,c1.user_id,c1.money ,c1.status from order_dtl where c1.user_id='4060214';
+---------------------------------------------------------------------+-----------------+----------------+--------------+
|                                PLAN                                 | EST_BYTES_READ  | EST_ROWS_READ  | EST_INFO_TS  |
+---------------------------------------------------------------------+-----------------+----------------+--------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN FULL SCAN OVER ORDER_DTL  | null            | null           | null         |
|     SERVER FILTER BY C1.USER_ID = '4060214'                         | null            | null           | null         |
+---------------------------------------------------------------------+-----------------+----------------+--------------+
2 rows selected (0.018 seconds)
0: jdbc:phoenix:> 

```

- 强制使用全局索引
  -  /*+INDEX(ORDER_DTL GBL_IDX_ORDER_DTL)*/

``` sql
explain select /*+INDEX(ORDER_DTL GBL_IDX_ORDER_DTL)*/ user_id, id, STATUS, money from ORDER_DTL where C1.user_id = '8237476';
```



``` sql
0: jdbc:phoenix:> explain select /*+INDEX(ORDER_DTL GBL_IDX_ORDER_DTL)*/  id,c1.user_id,c1.money ,c1.status from order_dtl where c1.user_id='4060214';
+--------------------------------------------------------------------------------------------------------------------+---------------+
|                                                        PLAN                                                        | EST_BYTES_REA |
+--------------------------------------------------------------------------------------------------------------------+---------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN FULL SCAN OVER ORDER_DTL                                                 | null          |
|     SKIP-SCAN-JOIN TABLE 0                                                                                         | null          |
|         CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN RANGE SCAN OVER GBL_IDX_ORDER_DTL [0,'4060214'] - [4,'4060214']  | null          |
|             SERVER FILTER BY FIRST KEY ONLY                                                                        | null          |
|     DYNAMIC SERVER FILTER BY "ORDER_DTL.ID" IN ($34.$36)                                                           | null          |
+--------------------------------------------------------------------------------------------------------------------+---------------+
5 rows selected (0.032 seconds)
0: jdbc:phoenix:> 

```

- 删除索引

``` sql
drop index 索引名称 on 表名;
drop index bgl_idx_order_dtl on order_dtl;
```





## 5-2 本地索引

- 需求: 

  - 在未来可能会根据表中 订单ID, 订单状态, 支付金额, 支付方式, 用户ID查询数据

    

- 由于在查询的时候, 可能会出现**多个字段作为查询的条件**,  此时可以**对多个字段建立索引**, 推荐使用本地索引,因为如果使用全局索引, 后续写入操作影响会比较大;

  

- 说明: 

  - 如果在建表的时候, 使用了基于Phoenix**加盐的预分区 （salt_buckets）**的方式创建的, 建议不要使用本地索引；

- 建立本地索引 local:

``` sql
create local index local_index_order_dtl on order_dtl(id,status,money,pay_way,user_id);
```

- explain 查看扫描方式
  - RANGE SCAN

``` sql
explain select id,status,money,pay_way,user_id from order_dtl where user_id='4060214';
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
|                                   PLAN                                   | EST_BYTES_READ  | EST_ROWS_READ  | EST_INFO_TS  |
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN RANGE SCAN OVER ORDER_DTL [1]  | null            | null           | null         |
|     SERVER FILTER BY FIRST KEY ONLY AND "USER_ID" = '4060214'            | null            | null           | null         |
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
2 rows selected (0.024 seconds)
0: jdbc:phoenix:> 

```



- 如果select 引用到**非索引字段**一样**还是可以使用二级索引**查询 (**与全局索引不同的地方**)
  - explain 查看引用了非索引字段（category）后的扫描方式
  - RANGE SCAN

``` sql
explain select id,status,money,pay_way,user_id,category from order_dtl where user_id='4060214';
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
|                                   PLAN                                   | EST_BYTES_READ  | EST_ROWS_READ  | EST_INFO_TS  |
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN RANGE SCAN OVER ORDER_DTL [1]  | null            | null           | null         |
|     SERVER FILTER BY FIRST KEY ONLY AND "USER_ID" = '4060214'            | null            | null           | null         |
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
2 rows selected (0.019 seconds)
0: jdbc:phoenix:> 

```

- 但是如果原表在创建的时候使用的是**加盐的预分区 （salt_buckets）**的方式创建的就不你能使用select *
  - explain 查看select * 的扫描方式 (可以将所有的列名一个一个列出来)
  - FULL SCAN

``` sql
explain select * from order_dtl where user_id = '4060214';
+---------------------------------------------------------------------+-----------------+----------------+--------------+
|                                PLAN                                 | EST_BYTES_READ  | EST_ROWS_READ  | EST_INFO_TS  |
+---------------------------------------------------------------------+-----------------+----------------+--------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN FULL SCAN OVER ORDER_DTL  | null            | null           | null         |
|     SERVER FILTER BY C1.USER_ID = '4060214'                         | null            | null           | null         |
+---------------------------------------------------------------------+-----------------+----------------+--------------+
2 rows selected (0.027 seconds)
0: jdbc:phoenix:> 


-- 如果将所有的列名罗列出来 也是可以使用本地索引查询的 RANGE SCAN --
explain select  id,status,money,pay_way,user_id,operation_time,category from order_dtl where user_id = '4060214';
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
|                                   PLAN                                   | EST_BYTES_READ  | EST_ROWS_READ  | EST_INFO_TS  |
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
| CLIENT 5-CHUNK PARALLEL 5-WAY ROUND ROBIN RANGE SCAN OVER ORDER_DTL [1]  | null            | null           | null         |
|     SERVER FILTER BY FIRST KEY ONLY AND "USER_ID" = '4060214'            | null            | null           | null         |
+--------------------------------------------------------------------------+-----------------+----------------+--------------+
2 rows selected (0.03 seconds)
0: jdbc:phoenix:> 

```





## 5-3 陌陌案例的索引实现

- 原来SQL查询

``` SQL
select C1."sender_account",C1."receiver_account",C1."msg_time",C1."message"  from MOMO_CHAT.MSG where substr(C1."msg_time",0,10) ='2021-01-31' and C1."sender_account" = '18461866438' AND C1."receiver_account" = '13641568674';
```

- 加索引前查询
  - 查询时间： 0.14s

``` sql
select C1."sender_account",C1."receiver_account",C1."msg_time",C1."message"  from MOMO_CHAT.MSG where substr(C1."msg_time",0,10) ='2021-01-31' and C1."sender_account" = '18461866438' AND C1."receiver_account" = '13641568674';
+-----------------+-------------------+----------------------+-----------------------------------------------------------------------+
| sender_account  | receiver_account  |       msg_time       |                                  message                              |
+-----------------+-------------------+----------------------+-----------------------------------------------------------------------+
| 18461866438     | 13641568674       | 2021-01-31 23:04:18  | 四分爱，三分忠诚，二分温柔，一分宽恕，再加一调羹希望；五桶欢笑，十分信心，撒上阳光，调拌均匀，每天服用。                  |
| 18461866438     | 13641568674       | 2021-01-31 23:04:28  | 亲爱的，每天太阳升起的时候就是我在心里想你的开始，每天月亮升起的时候就是我在梦中想你的开始。月亮太阳让我爱你一生一世。           |
| 18461866438     | 13641568674       | 2021-01-31 23:04:40  | 时间说再见，思念不会变，不管多遥远，我能看见你的脸，时间说再见，爱恋不会变，不管多艰难，我要望到你的眼，亲爱的，时间改变不了我们心手相依， |
| 18461866438     | 13641568674       | 2021-01-31 23:04:52  | 夜晚，你在我梦里；白天，你在我心里；相依，你在我眼里；分离，你在我思念里。亲爱的，天天有你，分秒不曾忘记！                 |
| 18461866438     | 13641568674       | 2021-01-31 23:05:35  | 过去的事情必然是烬去的了，然而，今天的生活比过去更加精彩——愿每天精彩常在，洋溢在每个人的身边！                      |
| 18461866438     | 13641568674       | 2021-01-31 23:05:36  | 泥是窝的嘴矮！泥是窝的梦乡！窝忧郁地看着泥！窝要对泥说，窝矮泥！（请用升调加降调大声朗读）                         |
| 18461866438     | 13641568674       | 2021-01-31 23:05:37  | 怎么会迷上你我在问自己，我什么都能放弃居然今天难离去，也许你不曾想到我的心会疼，如果这是梦，我愿长醉不愿醒。                |
| 18461866438     | 13641568674       | 2021-01-31 23:06:01  | 有一种想见不敢见的伤痛，这一种爱还埋藏在我心中，让我对你的思念越来越浓，我却只能把你你放在我心中。                     |
+-----------------+-------------------+----------------------+-----------------------------------------------------------------------+
8 rows selected (0.14 seconds)

```



- 通过索引 提升效率:  
  - 创建函数索引 + 本地索引（momo_chat.msg 表写入比较多）

``` sql
create local index local_index_msg on momo_chat.msg( substr(c1."msg_time",0,10),c1."sender_account",c1."receiver_account")
```



- 添加索引后查询
  - 查询时间： 0.041s

``` sql
select C1."sender_account",C1."receiver_account",C1."msg_time",C1."message"  from MOMO_CHAT.MSG where substr(C1."msg_time",0,10) ='2021-01-31' and C1."sender_account" = '18461866438' AND C1."receiver_account" = '13641568674';
+-----------------+-------------------+----------------------+-----------------------------------------------------------------------+
| sender_account  | receiver_account  |       msg_time       |                                  message                              |
+-----------------+-------------------+----------------------+-----------------------------------------------------------------------+
| 18461866438     | 13641568674       | 2021-01-31 23:04:18  | 四分爱，三分忠诚，二分温柔，一分宽恕，再加一调羹希望；五桶欢笑，十分信心，撒上阳光，调拌均匀，每天服用。                  |
| 18461866438     | 13641568674       | 2021-01-31 23:04:28  | 亲爱的，每天太阳升起的时候就是我在心里想你的开始，每天月亮升起的时候就是我在梦中想你的开始。月亮太阳让我爱你一生一世。           |
| 18461866438     | 13641568674       | 2021-01-31 23:04:40  | 时间说再见，思念不会变，不管多遥远，我能看见你的脸，时间说再见，爱恋不会变，不管多艰难，我要望到你的眼，亲爱的，时间改变不了我们心手相依， |
| 18461866438     | 13641568674       | 2021-01-31 23:04:52  | 夜晚，你在我梦里；白天，你在我心里；相依，你在我眼里；分离，你在我思念里。亲爱的，天天有你，分秒不曾忘记！                 |
| 18461866438     | 13641568674       | 2021-01-31 23:05:35  | 过去的事情必然是烬去的了，然而，今天的生活比过去更加精彩——愿每天精彩常在，洋溢在每个人的身边！                      |
| 18461866438     | 13641568674       | 2021-01-31 23:05:36  | 泥是窝的嘴矮！泥是窝的梦乡！窝忧郁地看着泥！窝要对泥说，窝矮泥！（请用升调加降调大声朗读）                         |
| 18461866438     | 13641568674       | 2021-01-31 23:05:37  | 怎么会迷上你我在问自己，我什么都能放弃居然今天难离去，也许你不曾想到我的心会疼，如果这是梦，我愿长醉不愿醒。                |
| 18461866438     | 13641568674       | 2021-01-31 23:06:01  | 有一种想见不敢见的伤痛，这一种爱还埋藏在我心中，让我对你的思念越来越浓，我却只能把你你放在我心中。                     |
+-----------------+-------------------+----------------------+-----------------------------------------------------------------------+
8 rows selected (0.041 seconds)

```

