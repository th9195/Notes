

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



