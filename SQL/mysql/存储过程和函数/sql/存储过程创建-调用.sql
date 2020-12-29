

DROP DATABASE IF EXISTS function_procedure;

CREATE DATABASE function_procedure;

USE function_procedure;


## 创建存储过程和调用
## 创建存储过程语法

##修改结束分隔符
DELIMITER $

-- 创建存储过程

CREATE PROCEDURE 存储过程名称(参数列表)

BEGIN
	SQL 编程语句;

END$

##修改结束分隔符
DELIMITER;

## 案例
-- 按照性别进行分组，查询每组学生的总成绩， 按照总成绩的降序排序

## SQL 语句
SELECT 
	gender,
	SUM(score) getSum
FROM 
	student
GROUP BY 
	gender
	
ORDER BY 
	getSum DESC;

## 存储过程
DELIMITER $
CREATE PROCEDURE procedure_01()
BEGIN
	SELECT 
		gender,
		SUM(score) getSum
	FROM 
		student
	GROUP BY 
		gender
		
	ORDER BY 
		getSum DESC;	
END$
DELIMITER;

## 调用存储过程
CALL 存储过程名称(实际参数);
CALL procedure_01();


## 查看存储过程
## 语法
SELECT * FROM mysql.proc WHERE db = '数据库名称';

SELECT * FROM mysql.proc WHERE db = 'function_procedure';



## 删除存储过程
## 语法
DROP PROCEDURE IF EXISTS 存储过程名称;
DROP PROCEDURE IF EXISTS procedure_01;




