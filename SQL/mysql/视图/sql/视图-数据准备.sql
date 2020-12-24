
## 视图-数据准备

## 创建shitu数据库
DROP DATABASE IF EXISTS shitu;
CREATE DATABASE shitu;

## 使用shitu数据库
USE shitu;

## 删除city 和 country 表
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;

## 创建国家表
CREATE TABLE country(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32)
);

## 添加数据
INSERT INTO country VALUES
	(NULL,'中国'),
	(NULL,'美国'),
	(NULL,'俄罗斯');
	

## 创建城市表	
CREATE TABLE city(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32),
	cid INT ,
	CONSTRAINT cc_fk1 FOREIGN KEY (cid) REFERENCES country(id)
);	

## 添加数据
INSERT INTO city VALUES
	(NULL,'北京',1),
	(NULL,'上海',1),
	(NULL,'纽约',2),
	(NULL,'莫斯科',3);

