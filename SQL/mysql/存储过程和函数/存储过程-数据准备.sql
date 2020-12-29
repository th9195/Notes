



## 存储过程-数据准备

## 创建数据库 function_proceduce
DROP DATABASE IF EXISTS function_procedure;
CREATE DATABASE function_procedure;

## 使用数据库 function_proceduce
USE function_procedure;

## 创建student表
CREATE TABLE student(
	id INT PRIMARY KEY AUTO_INCREMENT,			-- 学生id
	NAME VARCHAR(32),					-- 学生姓名
	age INT,						-- 学生年龄
	gender VARCHAR(5),					-- 学生性别
	score INT 						-- 学生成绩
);

## 添加数据
INSERT INTO student VALUES 
	(NULL,'张三',23,'男',95),
	(NULL,'李四',24,'男',98),
	(NULL,'王五',25,'女',100),
	(NULL,'赵六',26,'女',90);

