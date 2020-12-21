 ## 约束

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



	### 主键约束

- 特点

  - 主键约束默认包含非空和唯一两个功能；
  - 一张表只能有一个主键；
  - 主键一般用于表中数据的唯一标识；

- 建表的时候添加主键约束

  ``` sql
  
  USE bigdata;
  
  # 主键约束
  CREATE TABLE 表名(
  	列名 数据类型 PRIMARY KEY,
  	...
  	列名 数据类型 约束
  );
  
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

  

### 主键自增约束

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


## 删除主键自增月
ALTER TABLE 表名 MODIFY 列名 数据类型;
ALTER TABLE student MODIFY id INT;



## 创建表后单独添加主键自增约束
ALTER TABLE 表名 MODIFY 列名 数据类型 AUTO_INCREMENT;
ALTER TABLE student MODIFY id INT AUTO_INCREMENT;




```







### 唯一约束



### 非空约束





### 外键约束





### 外键级联操作













