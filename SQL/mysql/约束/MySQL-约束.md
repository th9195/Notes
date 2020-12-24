 ## 约束

### 总结

| 约束名称 | 关键字                                                       | 删除             | 添加   | 语法                                                         |
| -------- | ------------------------------------------------------------ | ---------------- | ------ | ------------------------------------------------------------ |
| 主键     | PRIMARY KEY                                                  | DROP PRIMARY KEY | MODIFY | ALTER TABLE 表名 DROP PRIMARY KEY;<br>ALTER TABLE 表名 MODIFY 列名 数据类型 PRIMARY KEY ;; |
| 自增     | AUTO_INCREMENT                                               | MODIFY           | MODIFY | ALTER TABLE 表名MODIFY 列名 数据类型;<br>ALTER TABLE 表名MODIFY 列名 数据类型AUTO_INCREMENT; |
| 唯一     | UNIQUE                                                       | DROP INDEX       | MODIFY | ALTER TABLE 表名DROP INDEX 列名;<br>ALTER TABLE 表名MODIFY 列名 数据类型 UNIQUE; |
| 非空     | NOT NULL                                                     | MODIFY           | MODIFY | ALTER TABLE 表名MODIFY 列名 数据类型;<br>ALTER TABLE 表名MODIFY 列名 数据类型NOT NULL; |
| 外键     | CONSTRAINT<br>FOREIGN KEY<br>REFERENCES                      | DROP FOREIGN KEY | ADD    | ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;<br>ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名); |
| 外键级联 | CONSTRAINT<br>FOREIGN KEY<br>REFERENCES<br>ON UPDATE/DELETE CASCADE | DROP FOREIGN KEY | ADD    | ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;<br/>ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名) ON UPDATE CASCADE ON DELETE CASCADE; |
|          |                                                              |                  |        |                                                              |



### 约束的介绍



- 什么是约束

  对表中的数据进行限定，保证数据的正确性、有效性、完整性

  

- 约束的分类

| 约束                          | 作用         |
| ----------------------------- | ------------ |
| PRIMARY KEY                   | 主键约束     |
| PRIMARY KEY AUTO_INCREMENT    | 主键自增     |
| UNIQUE                        | 唯一约束     |
| NOT NULL                      | 非空约束     |
| FOREIGN KEY                   | 外键约束     |
| FOREIGN KEY ON UPDATE CASCADE | 外键级联更新 |
| FOREIGN KEY ON DELETE CASCADE | 外键级联删除 |



### 主键约束 PRIMARY KEY

- 特点

  - 主键约束默认包含非空和唯一两个功能；
  - 一张表只能有一个主键；
  - 主键一般用于表中数据的唯一标识；

  ``` sql
  
  USE bigdata;
  
  # 主键约束语法
  CREATE TABLE 表名(
  	列名 数据类型 PRIMARY KEY,
  	...
  	列名 数据类型 约束
  );
  
  ## 建表的时候添加主键约束
  ## 创建一个学生表 ID 为主键
  CREATE TABLE student (
  	id INT PRIMARY KEY ,
  	NAME VARCHAR(32) ,
  	age INT
  );
  
  ## 查看表的详细信息
  DESC student;
  
  SELECT * FROM student;
  
  ## 主键约束默认包含非空和唯一两个功能
  ## 添加数据
  INSERT INTO student VALUES (1,'Tom2',21);
  INSERT INTO student VALUES (1,'Tom2',21);
  
  
  ## 删除主键约束
  ALTER TABLE 表名 DROP PRIMARY KEY;
  ALTER TABLE student DROP PRIMARY KEY;
  DESC student;
  
  ## 删除重复ID 的数据
  DELETE FROM student WHERE id = 1;
  
  ## 建表后单独添加主键约束
  ALTER TABLE 表名 MODIFY 列名 数据类型 PRIMARY KEY ;
  ALTER TABLE student MODIFY id INT PRIMARY KEY;
  
  
  ```

  


### 主键自增约束 AUTO_INCREMENT

``` sql


DROP TABLE IF EXISTS student;

# 主键自增约束
## 语法
CREATE TABLE 表名(
	列名 数据类型 PRIMARY KEY AUTO_INCREMENT
	...
	列名 数据类型 约束
);
## 注意: MySql 中的自增约束，必须配合键的约束一起使用

## 创建一个学生表 ID 为主键自增约束
CREATE TABLE student (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32),
	age INT
);

DESC student;

## 添加数据
INSERT INTO  student VALUES 
	(NULL,'Tom1',21),
	(NULL,'Tom2',22),
	(NULL,'Tom3',23),
	(NULL,'Tom4',24);


## 删除主键自增约束
ALTER TABLE 表名 MODIFY 列名 数据类型;
ALTER TABLE student MODIFY id INT;



## 创建表后单独添加主键自增约束
ALTER TABLE 表名 MODIFY 列名 数据类型 AUTO_INCREMENT;
ALTER TABLE student MODIFY id INT AUTO_INCREMENT;


```





### 唯一约束 UNIQUE

``` sql

DROP TABLE IF EXISTS student;

# 唯一约束
## 语法
CREATE TABLE 表名(
	列名 数据类型 UNIQUE,
	...
	列名 数据类型 约束
);

CREATE TABLE student(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32) UNIQUE,
	age INT
);

## 查看详细结构
DESC student;

## 添加数据
INSERT INTO student VALUES 
	(NULL,'Tom1',11),
	(NULL,'Tom2',12),
	(NULL,'Tom3',13),
	(NULL,'Tom4',14);
	
## 重复 数据	Duplicate entry 'Tom1' for key 'name' 
INSERT INTO student VALUES
	(NULL,"Tom1",15);

## 删除唯一约束
ALTER TABLE 表名 DROP INDEX 列名;
ALTER TABLE student DROP INDEX NAME;


## 建表后单独添加唯一约束
ALTER TABLE 表名 MODIFY 列名 数据类型 UNIQUE;
ALTER TABLE student MODIFY NAME VARCHAR(32) UNIQUE;

```





### 非空约束 NOT NULL

``` sql

DROP TABLE IF EXISTS student;

# 非空约束
## 语法
CREATE TABLE IF NOT EXISTS 表名(
	列名 数据类型 NOT NULL,
	...
	列名 数据类型 约束

);

CREATE TABLE IF NOT EXISTS student(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32) NOT NULL,
	age INT

);

DESC student;

## 添加数据
INSERT INTO student VALUES
(NULL,'Tom1',21),
(NULL,'Tom2',22),
(NULL,'Tom3',23);

INSERT INTO student  VALUES (NULL,'Tom4',24);

## Column 'name' cannot be null
INSERT INTO student  VALUES (NULL,NULL,24);

## 删除非空约束
ALTER TABLE 表名 MODIFY 列名 数据类型;
ALTER TABLE student MODIFY NAME VARCHAR(32);


## 建表后单独添加非空约束
ALTER TABLE 表名 MODIFY 列名 数据类型 NOT NULL;
ALTER TABLE student MODIFY NAME VARCHAR(32) NOT NULL;

```



### 外键约束

``` sql

USE BIGDATA;

DROP TABLE IF EXISTS USER;

CREATE TABLE USER (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32) NOT NULL UNIQUE
);


INSERT INTO USER VALUES
(NULL,'张三'),
(NULL,'李四');



## 外键约束
### 创建表是添加外键约束
CREATE TABLE 表名(
	列名 数据类型 约束,
	...
	CONSTRAINT 外键名称 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名)

);
DROP TABLE IF EXISTS orderlist;
CREATE TABLE orderlist(
	id INT PRIMARY KEY AUTO_INCREMENT,
	number VARCHAR(32) NOT NULL,
	uid INT ,  -- 外键列
	CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER(id)
);
INSERT INTO orderlist VALUES
(NULL,'hm001',1),
(NULL,'hm002',1),
(NULL,'hm003',2),
(NULL,'hm004',2);

DESC orderlist;
DESC USER;

### 添加数据Cannot add or update a child row: a foreign key constraint fails (`bigdata`.`orderlist`, CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`))
INSERT INTO orderlist VALUES (NULL,'hw005',3);

### 修改数据 Cannot delete or update a parent row: a foreign key constraint fails (`bigdata`.`orderlist`, CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`))
UPDATE USER SET id = 3 WHERE id = 2;

### 删除数据 Cannot delete or update a parent row: a foreign key constraint fails (`bigdata`.`orderlist`, CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`))
DELETE FROM USER WHERE id = 2; 




### 删除外键
ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;
ALTER TABLE orderlist DROP FOREIGN KEY ou_fk1;


### 建表后添加外键
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名);
ALTER TABLE orderlist ADD CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER(id);


SHOW CREATE TABLE orderlist;

```





### 外键级联操作

``` sql

## 外键级联操作
USE bigdata;

DROP TABLE IF EXISTS orderlist;
DROP TABLE IF EXISTS USER;

CREATE TABLE USER(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32) NOT NULL
);

INSERT INTO USER VALUES
(NULL,'张三'),
(NULL,'李四');

DROP TABLE IF EXISTS orderlist;
CREATE TABLE orderlist(
	id INT PRIMARY KEY AUTO_INCREMENT,
	number VARCHAR(32) UNIQUE,
	uid INT NOT NULL,
	CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER (id)
);

INSERT INTO orderlist VALUES 
	(NULL,'hm001',1),
	(NULL,'hm002',1),
	(NULL,'hm003',2),
	(NULL,'hm004',2);
	

## 外键级联更新、删除
## 语法
CREATE TABLE 表名(
	列名 数据类型 约束,
	...
	CONSTRAINT 外键名 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名)
	ON UPDATE CASCADE ON DELETE CASCADE
);

## 删除外键
ALTER TABLE orderlist DROP FOREIGN KEY ou_fk1;

## 添加外键并同时添加级联更新和级联删除
ALTER TABLE orderlist ADD CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER (id) ON UPDATE CASCADE ON DELETE CASCADE;

## 查看创建表的语句
SHOW CREATE TABLE orderlist;
/*
CREATE TABLE `orderlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(32) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `ou_fk1` (`uid`),
  CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8
*/

## 将李四这个用户的id 修改 成3
UPDATE USER  SET id = 3 WHERE NAME = '李四';


## 将李四用户删除
DELETE FROM USER WHERE NAME = '李四';



```













