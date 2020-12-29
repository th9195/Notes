
## 存储过程-参数传递

## 语法
DELIMITER $
CREATE PROCEDURE 存储过程名称 ([IN|OUT|INOUT]参数名 数据类型)
BEGIN

END $
DELIMITER ; 

IN : 代表输入参数（默认）
OUT : 代表输出参数，该参数可以作为返回值
INOUT :代表既可以作为输入参数，也可以作为输出参数


## 案例
/*
	输入总成绩变量，代表学生总成绩
	输出分数描述变量，代码学生总成绩的描述信息
	根据总成绩判断：
		380以上		学习优秀
		320-380		学习不错
		320以下		学习一般
*/

DROP PROCEDURE IF EXISTS procedure_06;

DELIMITER $
CREATE PROCEDURE procedure_06(IN total INT,OUT info VARCHAR(32))
BEGIN
	IF total > 380 THEN
		SET info = "学习优秀";
	ELSEIF total >=320 AND total <=380 THEN
		SET info = "学习不错";
	ELSE
		SET info = "学习一般";
	END IF;

END $
DELIMITER ; 


## 调用存储过程 
## 如何传递输出参数   在变量名称前面加上'@'符合
CALL procedure_06(383,@info);

## 总分通过sql查询出来
CALL procedure_06((SELECT SUM(score) FROM student),@info);

## 查询输出参数
SELECT @info;

