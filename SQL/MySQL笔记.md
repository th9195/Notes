## 1-分类

### DDL

​		数据定义语言。用来操作数据库、表、列

#### 查询数据和创建

``` sql
# 查看所有数据库
SHOW DATABASES;

# 查看数据库的创建语句
SHOW CREATE DATABASE mysql;

# 创建数据库
CREATE DATABASE bigdata;

# 创建数据库加判断是否存在
CREATE DATABASE IF NOT EXISTS bigdata2;

# 创建数据库 制定数据集
CREATE DATABASE IF NOT EXISTS bigdata4 CHARACTER SET GBK ;

# 查看数据库的创建语句
SHOW CREATE DATABASE bigdata4;
```



#### 数据库修改、删除、使用

``` sql

# 数据库的修改、删除、使用

# 修改数据库 （修改字符集）
ALTER DATABASE bigdata4 CHARACTER SET UTF8;
SHOW CREATE DATABASE bigdata4;

# 删除数据库
DROP DATABASE bigdata4;

# 删除数据库 + 条件判断
DROP DATABASE IF EXISTS bigdata4;

# 使用数据库
USE bigdata3;

# 查看当前使用的数据
SELECT DATABASE();
```



#### 数据表的查询

``` sql

# 查询数据表

# 查询所有的数据表
USE  mysql;
SHOW TABLES;

# 查询表结构
DESC USER;

# 查看表的状态信息 （字符集 等等详细信息）
SHOW TABLE STATUS FROM mysql LIKE 'user';

```



#### 创建、删除 数据表

``` sql
# 创建、删除数据表
/*
create table 表名(

列名 数据类型 约束,
列名 数据类型 约束,
列名 数据类型 约束,
...
列名 数据类型 约束

数据类型：

int : 整数类型
double : 小数类型
date : 日期类型，包含年月日, 格式：yyyy-MM-dd
datetime: 日期类型，年月日时分秒,格式, yyyy-MM-dd HH:mm:ss
timestamp: 时间戳类型，年月日时分秒,格式, yyyy-MM-dd HH:mm:ss
	* 如果不给该列赋值或赋值为Null,则默认使用当前系统时间自动赋值
varchar(长度) :  字符串类型

);
*/

SELECT DATABASE();
USE bigdata;

# 创建数据库
CREATE TABLE  product(
	id INT,
	NAME VARCHAR(32),
	price DOUBLE,
	stock INT,
	insert_time DATE
	
);
# 创建数据库 + 判断是否存在
CREATE TABLE IF NOT EXISTS product(
	id INT,
	NAME VARCHAR(32),
	price DOUBLE,
	stock INT,
	insert_time DATE
	
);

# 查看表结构
DESC product; 

# 删除一个表
DROP TABLE 表名;
DROP TABLE product;


```



#### 修改数据表

``` sql
# 修改数据表

# 查看所有表
SHOW TABLES;

# 修改表名
ALTER TABLE 表名 RENAME TO 新表名;
ALTER TABLE product RENAME TO product2;


# 修改表的字符集
ALTER TABLE 表名 CHARACTER SET 新字符集名称;
SHOW TABLE STATUS FROM bigdata LIKE "product2";
ALTER TABLE product2 CHARACTER SET GBK;
SHOW TABLE STATUS FROM bigdata LIKE "product2";

# 单独添加一列
ALTER TABLE 表名 ADD 列名 数据类型;
ALTER TABLE product2 ADD color VARCHAR(32);
DESC product2;


# 修改某列的数据类型
ALTER TABLE 表名 MODIFY 列名 新数据类型;
ALTER TABLE product2 MODIFY color INT;
DESC product2;

# 修改列名和数据类型
ALTER TABLE 表名  CHANGE 列名 新列名 新数据类型;
ALTER TABLE product2 CHANGE color colors VARCHAR(32);
DESC product2;

# 删除某一列
ALTER TABLE 表名 DROP 列名;
ALTER TABLE product2 DROP colors;
DESC product2;


ALTER TABLE product2 RENAME TO product;
SHOW TABLES;
```



​		





### DML

​		数据操作语言。用来对数据库中表的数据进行增删改。

#### 新增表中的数据

``` sql
# 新增表数据
## 给指定列添加数据
INSERT INTO 表名(列名1,列名2,列名3...) VALUES(值1,值2,值3,...);

INSERT INTO product (id,NAME,price) VALUES (1,'电脑1',8199.00);

SELECT * FROM product;


## 给所有的列添加数据
INSERT INTO 表名  VALUES(所有列的值);
INSERT INTO product VALUES (1,'电脑1',8199.00,1,'2020-12-19');

## 批量添加指定列的数据
INSERT INTO  表名 (列名1,列名2,列名3,...) VALUES 
	(值1,值2,值3,...),
	(值1,值2,值3,...),
	(值1,值2,值3,...),
	...;
INSERT INTO product (id,NAME,price) VALUES 
	(2,'电脑2',8199.02),
	(3,'电脑3',8199.03),
	(4,'电脑4',8199.04),
	(5,'电脑5',8199.05);

## 批量添加全部列的数据
INSERT INTO  表名  VALUES 
	(所有列的值),
	(所有列的值),
	(所有列的值),
	...;
INSERT INTO product  VALUES 
	(6,'电脑6',8199.06,6,'2020-12-21'),
	(7,'电脑7',8199.07,7,'2020-12-21'),
	(8,'电脑8',8199.08,8,'2020-12-21'),
	(9,'电脑9',8199.09,9,'2020-12-21');


SELECT* FROM product;
```



#### 修改、删除表数据

``` sql
# 修改数据
## 修改表中的数据
UPDATE 表名 SET 列名1 = 值1,列名2 = 值2,... [WHERE 条件];
注意: 修改语句中必须添加上条件，否则将修改表中所有的数据;

UPDATE product SET NAME='手机' WHERE id = 2;
UPDATE product SET price = 10000 WHERE NAME = '手机';
UPDATE product SET price = 9999 , stock = 199 WHERE id = 2;
SELECT * FROM product;


## 删除表中的数据
DELETE FROM 表名 WHERE 条件;
注意: 删除语句中必须添加上条件，否则将删除表中所有的数据;
DELETE FROM product WHERE id = 1;
SELECT * FROM product;
DELETE FROM product WHERE stock = NULL AND id = 1;
SELECT * FROM product ; 

```





### DQL

​		数据查询语言。用来查询数据库中表的记录（数据）。

#### 语法介绍

``` sql

# 语法介绍
SELECT 
	字段列表
FROM
	表名
WHERE
	条件列表
GROUP BY
	分组字段
HAVING
	分组后的过滤条件
ORDER BY 
	排序
LIMIT
	分页
```



#### 查询全部

``` sql

## 查询全部数据
SELECT * FROM 表名;
SELECT * FROM product;

## 查询指定字段的表数据
SELECT 列名1,列名2,... FROM 表名;
SELECT NAME,price,brand FROM product;


## 去掉重复查询 distinct;
SELECT DISTINCT 列名1,列名2,...FROM 表名;
SELECT brand FROM product;
SELECT DISTINCT brand FROM product;


## 计算列的值(四则运算)
SELECT 列名1 运算符(+-*/)列名2 FROM 表名;
SELECT NAME , price + 1000 AS price , brand FROM product;
## 如果某一列的值为null，可以进行替换 
# ifnull(表达式1,表达式2) 函数
# 表达式1: 想替换的列
# 表达式2: 想替换的值
SELECT NAME , IFNULL(price,0) + 1000 AS price , brand FROM product;



## 起别名查询 as
SELECT 列名 AS 别名 FROM 表名;
SELECT p.name AS p_name ,p.price AS p_price ,p.brand AS p_brand FROM product p;

```



#### 条件查询

| 符合                | 功能                                  |
| ------------------- | ------------------------------------- |
| >                   | 大于                                  |
| <                   | 小于                                  |
| >=                  | 大于等于                              |
| <=                  | 小于等于                              |
| =                   | 等于                                  |
| <> 或 !=            | 不等于                                |
| between ... and ... | 在某个范围之内（都包含）              |
| IN(...)             | 多选一                                |
| LIKE 占位符         | 模糊查询 _单个任意字符 % 多个任意字符 |
| IS NULL             | 是null                                |
| IS NOT NULL         | 不是null                              |
| AND 或 &&           | 并且                                  |
| OR 或 \|\|          | 或者                                  |
| NOT 或 !            | 非 ， 不是                            |
|                     |                                       |



``` sql

# 条件查询
SELECT 列名列表 FROM 表名 WHERE 条件;

## 查询 价格大于5000 的商品信息
SELECT * FROM product WHERE price > 5000;

## 查询品牌为华为的商品信息
SELECT * FROM product WHERE brand = '华为';

## 查询价格在2999 ~ 5999 之间的商品信息
SELECT * FROM product WHERE price BETWEEN 2999 AND 5999;
SELECT * FROM product WHERE price >=2999 AND price <=5999;


## 查询价格为3999,4999 ，5999 的商品信息
SELECT * FROM product WHERE price IN (3999,4999,5999);

## 查询价格不为null 的商品信息
SELECT * FROM product WHERE price IS NOT NULL;
SELECT * FROM product WHERE price IS NULL;


## 查询品牌以 '小' 为开头的商品信息   模糊查询 like
SELECT * FROM product WHERE brand LIKE '小%';

## 查询品牌第二个字是'为'的商品信息
SELECT * FROM product WHERE brand LIKE '_为%';

## 查询名称为3个字符的商品信息
SELECT * FROM product WHERE NAME LIKE '___';

## 查询名称中包含手机的商品信息
SELECT * FROM product WHERE NAME LIKE '%手机%';


 
```



 #### 聚合函数查询

| 函数名      | 功能                             |
| ----------- | -------------------------------- |
| count(列名) | 统计数量（一般选用不为null的列） |
| max(列名)   | 最大值                           |
| min(列名)   | 最小值                           |
| sum(列名)   | 求和                             |
| avg(列名)   | 平均值                           |



``` sql
## 聚合查询的语法
SELECT 函数名称(列名) FROM [WHERE 条件]

## 计算procduct 表中总记录数据
SELECT COUNT(*) FROM product;

## 获取最高价格
SELECT MAX(price) FROM product;

## 获取最低价格
SELECT MIN(price) FROM product;

## 获取总库存数量
SELECT SUM(stock) FROM product;

## 获取品牌为苹果的总库存数量
SELECT SUM(stock) FROM product WHERE brand = '苹果';

## 获取品牌为小米的平均商品价格
SELECT AVG(price) FROM product WHERE brand = '小米';

```



#### 排序查询

``` sql

# 排序查询

## 语法
SELECT 列名列表 FROM 表名 [WHERE 条件] ORDER BY 列名 排序方式, 列名 排序方式...;

## 排序方式 ASC: 升序(默认)， DESC : 降序
## 如果有多个排序条件，只有当前面的条件值一样时，才会判断第二个条件；

SELECT * FROM product ORDER BY price DESC;

## 查询品牌包含华为的商品信息，并且 降序排序
SELECT * FROM product WHERE brand LIKE '%华为%' ORDER BY price DESC;

## 按照库存升序排序，如果库存一样，按照价格降序排序
SELECT * FROM product ORDER BY stock , price DESC;
 
```



#### 分组查询

``` sql

# 分组查询
## 语法
SELECT 列名 FROM 表名 
	[WHERE 条件] 
	GROUP BY 分组列名 
	[HAVING 分组后条件过滤] 
	[ORDER BY 排序列 排序方式]
	

## 按照品牌分组， 获取每组商品的总金额
SELECT brand , SUM(price) AS getSum FROM product GROUP BY brand;

## 对price大于3000的商品 按照品牌分组， 获取每组商品的总金额
SELECT brand, SUM(price) AS getSu FROM product WHERE price > 3000 GROUP BY brand;


## 对price大于3000的商品 按照品牌分组， 获取每组商品的总金额 , 只显示总金额>5000的商品
SELECT brand , SUM(price) AS getSum FROM product 
	WHERE price > 3000 
	GROUP BY brand 
	HAVING getSum > 5000;

## 对price大于3000的商品 按照品牌分组， 获取每组商品的总金额 , 只显示总金额>8000的商品 
SELECT brand , SUM(price) AS getSum FROM product
	WHERE price > 3000
	GROUP BY brand
	HAVING getSum > 5000 
	ORDER BY getSum DESC;
```



#### 分页查询



### DCL

​		数据控制语言。用来定义数据库的访问权限和安全级别，及创建用户。

































