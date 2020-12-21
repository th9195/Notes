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