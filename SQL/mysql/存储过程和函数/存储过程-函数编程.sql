

USE function_procedure;

# 变量
## 定义变量
## 语法
DECLARE 变量名 数据类型 [DEFAULT 默认值] ;

## 赋值 方式一
SET 变量名 = 变量值;



## 赋值 方式二
SELECT 列名 INTO 变量名 FROM 表名 [WHERE 条件];



## 案例 定义一个int类型的变量，病赋值默认为10

DELIMITER $ 
CREATE PROCEDURE procedure_02()
BEGIN
	DECLARE num INT DEFAULT 10;
	SELECT num;

END$
DELIMITER ; 


CALL procedure_02();


## 案例2 定义一个变量 varchar 类型，使用set 赋值
DROP PROCEDURE IF EXISTS procedure_03;
DELIMITER $
CREATE PROCEDURE procedure_03()
BEGIN
	DECLARE NAME VARCHAR(32);
	SET NAME = 'Tom';
	
	SELECT NAME;

END $
DELIMITER ;

## 调用存储过程
CALL procedure_03();


## 案例3 通过一个查询语句来给变量赋值
## 定义两个int变量，分别存储男女同学的总分数
DROP PROCEDURE IF EXISTS procedure_04;
DELIMITER $
CREATE PROCEDURE procedure_04()
BEGIN
	DECLARE men INT;
	DECLARE women INT;
	
	SELECT SUM(score) INTO men  FROM student WHERE gender = '男';
	SELECT SUM(score) INTO women  FROM student WHERE gender = '女';
	SELECT men,women;
END $
DELIMITER ; 

## 调用存储过程
CALL procedure_04();












