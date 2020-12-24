

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





