
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











