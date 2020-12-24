## MySQL-多表-多对多

建表原则: 需要借助第三张表，中间表至少需要包含两个列。 这两个列为中间表的外键，分别关联两张表的主键;

``` sql
# 多对多
## 建表原则: 需要借助第三张表，中间表至少需要包含两个列。 这两个列为中间表的外键，分别关联两张表的主键;

## 案例


USE bigdata;
DROP TABLE IF EXISTS stu_course;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;

## 创建student 表
CREATE TABLE student(
	id INT PRIMARY KEY AUTO_INCREMENT,		-- 主键id
	NAME VARCHAR(32) UNIQUE 			-- 学生姓名

);


## 添加数据
INSERT INTO student VALUES 
	(NULL,'张三'),
	(NULL,'李四');


## 创建course 表
CREATE TABLE course(
	id INT PRIMARY KEY AUTO_INCREMENT,		-- 主键Id
	NAME VARCHAR(32)				-- 学科名称

);

## 添加数据
INSERT INTO course VALUES 
	(NULL,'语文'),
	(NULL,'数学');


## 创建中间表 stu_course
CREATE  TABLE stu_course(
	id INT PRIMARY KEY AUTO_INCREMENT,					-- 主键id
	sid INT NOT NULL,							-- 学生外键id
	cid INT NOT NULL,							-- 学科外键id
	CONSTRAINT stu_fk FOREIGN KEY (sid) REFERENCES student (id),		
	CONSTRAINT cou_fk FOREIGN KEY (cid) REFERENCES course(id)
	
);


## 添加数据
INSERT INTO stu_course VALUES
	(NULL,1,1),
	(NULL,1,2),
	(NULL,2,1),
	(NULL,2,2);

```

