
USE bigdata;
DROP TABLE IF EXISTS orderlist ;
DROP TABLE IF EXISTS USER;

# 一对多
## 建表原则: 必须在多的一方建立外键约束，来关联一的一方主键;

# 案例一
## 创建user表
CREATE TABLE USER(
	id INT PRIMARY KEY AUTO_INCREMENT,			-- 主键id
	NAME VARCHAR(32) UNIQUE 				-- 姓名
);

# 添加数据
INSERT INTO USER VALUES 
	(NULL,'张三'),
	(NULL,'李四'); 

## 创建orderlist表
CREATE TABLE orderlist (
	id INT PRIMARY KEY AUTO_INCREMENT,			-- 主键id
	number VARCHAR(32) UNIQUE,				-- 订单号
	uid INT NOT NULL,					-- 外键id
	CONSTRAINT uo_fk1 FOREIGN KEY (uid) REFERENCES USER (id)

);

INSERT INTO orderlist VALUES
	(NULL,'hm001',1),
	(NULL,'hm002',1),
	(NULL,'hm003',2),
	(NULL,'hm004',2);



# 案例二
USE bigdata;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS category;

## 创建category 表
CREATE TABLE category (
	id INT PRIMARY KEY AUTO_INCREMENT,			-- 主键id
	NAME VARCHAR(32) UNIQUE 				-- 分类名称 	
);
## 添加数据
INSERT INTO category VALUES 
	(NULL,'手机数码'),
	(NULL,'电脑办公');


## 创建商品product 表
CREATE TABLE product (
	id INT PRIMARY KEY AUTO_INCREMENT,			-- 主键id
	NAME VARCHAR(32) UNIQUE,				-- 商品名称
	cid INT NOT NULL,					-- 外键id
	CONSTRAINT cp_fk2 FOREIGN KEY (cid) REFERENCES category (id));

## 添加数据
INSERT INTO product VALUES
	(NULL,'华为p30',1),
	(NULL,'小米note3',1),
	(NULL,'联系thinkbook 15p',2),
	(NULL,'苹果电脑',2);




