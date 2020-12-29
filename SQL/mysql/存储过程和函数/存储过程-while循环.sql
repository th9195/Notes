

## 存储过程-while循环

## while循环语法
WHILE 条件判断语句 DO
	循环体语句;
	条件控制语句;
END WHILE;


## 案例 while 计算1-100直接的偶数和;

DROP PROCEDURE IF EXISTS procedure_07;

DELIMITER $
CREATE PROCEDURE procedure_07()
BEGIN
	DECLARE mysum INT DEFAULT 0;
	DECLARE myindex INT DEFAULT 1; 
	
	
	WHILE myindex <= 100 DO
		IF myindex % 2 = 0 THEN
			SET mysum = mysum + myindex;
		END IF;
		
		SET myindex = myindex + 1;
		
	END WHILE;
	
	SELECT mysum,myindex;
END$
DELIMITER ; 

## 调用存储过程
CALL procedure_07();










