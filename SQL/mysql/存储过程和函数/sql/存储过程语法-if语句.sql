

## 存储过程语法-if语句

IF 判断条件1 
THEN 

	执行SQL语句1;
ELSEIF 判断条件2
THEN
	执行SQL语句2;
ELSE
	执行SQL语句3;
END IF;

## 案例
## 定义一个int类型变量，用于存储班级的总成绩;
## 定义一个varchar类型的变量，用于存储分数的描述;
## 根据总成绩判断：
## 	380以上		学习优秀
## 	320-380		学习不错
## 	320以下		学习一般

DROP PROCEDURE IF EXISTS procedure_05;
DELIMITER $
CREATE PROCEDURE procedure_05()
BEGIN
	DECLARE total INT ;				-- 总分
	DECLARE info VARCHAR(32);			-- 总分描述
	
	SELECT SUM(score) INTO total FROM student ;	-- 获取总分
	IF total > 380 THEN				-- 总分>380
		SET info = "学习优秀";
	ELSEIF total >= 320 AND total <=380 THEN	-- 320<=总分<=380
		SET info = "学习不错";
	ELSE 						-- 总分<320
		SET info = "学习一般";
	END IF;
	
	SELECT total,info;				-- 查询总分和总分描述信息
END $
DELIMITER ;


## 调用存储过程
CALL procedure_05();










