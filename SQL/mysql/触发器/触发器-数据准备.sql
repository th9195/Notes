
DROP DATABASE IF EXISTS mytrigger;
CREATE DATABASE mytrigger;
USE mytrigger;

## 创建表account
DROP TABLE IF EXISTS account;
CREATE TABLE account(
	id INT PRIMARY KEY AUTO_INCREMENT,		-- 主键id
	NAME VARCHAR(32),				-- 姓名
	money DOUBLE					-- 金额
);

## 添加数据
INSERT INTO account VALUES 
	(NULL,'张三',1000),
	(NULL,'李四',2000),
	(NULL,'王五',3000);

## 创建表account_log
DROP TABLE IF EXISTS account_log;
CREATE TABLE account_log(
	id INT PRIMARY KEY AUTO_INCREMENT,		-- 主键id
	operation VARCHAR(32),				-- 操作类型
	operation_time DATE,				-- 操作时间
	operation_id INT ,				-- 操作用户id (外键)
	operation_params VARCHAR(512)			-- 操作内容
	#constraint account_fk foreign key (operation_id) references account(id)
);







