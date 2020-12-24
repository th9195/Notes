
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



