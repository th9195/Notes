## 多表查询



### 数据准备

``` sql


## 多表查询数据准备

CREATE DATABASE IF NOT EXISTS bigdata;
USE bigdata;
## 删除多余的表
DROP TABLE IF EXISTS stu_course;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS orderlist;
DROP TABLE IF EXISTS us_pro;
DROP TABLE IF EXISTS uuser;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;

## 创建 uuser表
CREATE TABLE uuser(
	id INT PRIMARY KEY AUTO_INCREMENT,				-- 主键id
	NAME VARCHAR(32),						-- 姓名
	age INT 							-- 年龄
);

## 添加数据
INSERT INTO uuser VALUES
	(NULL,'张三',23),
	(NULL,'李四',24),
	(NULL,'王五',25),
	(NULL,'赵六',26);



## 创建 uuser表
DROP TABLE IF EXISTS orderlist;
CREATE TABLE orderlist(
	id INT PRIMARY KEY AUTO_INCREMENT,				-- 主键id
	number VARCHAR(32),						-- 订单号
	uid INT ,							-- 外键字段
	CONSTRAINT ou_fk FOREIGN KEY (uid) REFERENCES uuser(id)
);

## 添加数据
INSERT INTO orderlist VALUES
	(NULL,'hm001',1),
	(NULL,'hm002',1),
	(NULL,'hm003',2),
	(NULL,'hm004',2),
	(NULL,'hm005',3),
	(NULL,'hm006',3),
	(NULL,'hm007',NULL);



## 创建 商品分类表
DROP TABLE IF EXISTS category;
CREATE TABLE category(
	id INT PRIMARY KEY AUTO_INCREMENT,				-- 商品分类id
	NAME VARCHAR(32)						-- 商品分类名称

);

## 添加数据
INSERT INTO category VALUES
	(NULL,'手机数码'),
	(NULL,'电脑办公'),
	(NULL,'烟酒茶糖'),
	(NULL,'鞋靴箱包');

## 创建商品表
DROP TABLE IF EXISTS product;
CREATE TABLE product(
	id INT PRIMARY KEY AUTO_INCREMENT,				-- 商品id
	NAME VARCHAR(32),						-- 商品名称
	cid INT,							-- 外键商品分类id 
	CONSTRAINT cp_fk FOREIGN KEY (cid) REFERENCES category(id)
);

## 添加数据
INSERT INTO product VALUES
	(NULL,'华为手机',1),
	(NULL,'小米手机',1),
	(NULL,'联想电脑',1),
	(NULL,'苹果电脑',1),
	(NULL,'中华香烟',1),
	(NULL,'玉溪香烟',1),
	(NULL,'计生用品',NULL);
	
	
## 创建一个中间表
DROP TABLE IF EXISTS us_pro;
CREATE TABLE us_pro(
	upid INT PRIMARY KEY AUTO_INCREMENT , 					-- 中间表id
	uid INT,								-- 外键字段。 需要和用户表的主键关联
	pid INT,								-- 外键字段。 需要和商品表的主键关联
	CONSTRAINT up_fk1 FOREIGN KEY (uid) REFERENCES uuser(id),
	CONSTRAINT up_fk2 FOREIGN KEY (pid) REFERENCES product(id)
);	
	
## 添加数据
INSERT INTO us_pro VALUES
	(NULL,1,1),
	(NULL,1,2),
	(NULL,1,3),
	(NULL,1,4),
	(NULL,1,5),
	(NULL,1,6),
	(NULL,2,7),
	(NULL,2,1),
	(NULL,2,2),
	(NULL,2,3),
	(NULL,2,4),
	(NULL,2,5),
	(NULL,2,6),
	(NULL,2,7),
	(NULL,3,1),
	(NULL,3,2),
	(NULL,3,3),
	(NULL,3,4),
	(NULL,3,5),
	(NULL,3,6),
	(NULL,3,7),
	(NULL,4,1),
	(NULL,4,2),
	(NULL,4,3),
	(NULL,4,4),
	(NULL,4,5),
	(NULL,4,6),
	(NULL,2,7);
	
	
	

```



