
/*

InnoDB 存储引擎
	优点： 支持事务和外键操作， 支持并发控制， 
	缺点：占用磁盘空间大
	
MyISAM 存储引擎
	优点：访问快。
	缺点： 不支持事务和外键操作
	
MEMORY 存储引擎
	优点：内存存储、访问速度最快  适合小量快速访问的数据
	缺点：不安全

*/

## 查询数据库支持的存储引擎
SHOW ENGINES;

## 查询某个数据库所有数据表的存储引擎
SHOW TABLE STATUS FROM 数据库名称;
SHOW TABLE STATUS FROM bigdata;


## 查询某个表的存储引擎
SHOW TABLE STATUS FROM 数据库名称 WHERE NAME=‘表名’;
SHOW TABLE STATUS FROM bigdata WHERE NAME="category";


## 创建表是指定存储引擎
CREATE TABLE 表名(
	列名 数据类型 约束,
	...
	
)ENGINE=引擎名称;

## 创建表test_engine 并指定存储引擎为InnoDB
CREATE TABLE test_engine(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32)
)ENGINE=INNODB;

## 查看test_engine 表的存储引擎
SHOW TABLE STATUS FROM bigdata WHERE NAME='test_engine';

## 修改存储引擎
ALTER TABLE 表名 ENGINE=引擎名称;
ALTER TABLE test_engine ENGINE=MYISAM;



## 如何选择存储引擎















