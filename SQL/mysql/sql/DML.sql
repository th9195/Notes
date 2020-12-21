
#######################################################################
# 新增表数据
## 给指定列添加数据
INSERT INTO 表名(列名1,列名2,列名3...) VALUES(值1,值2,值3,...);

INSERT INTO product (id,NAME,price) VALUES (1,'电脑1',8199.00);

SELECT * FROM product;


## 给所有的列添加数据
INSERT INTO 表名  VALUES(所有列的值);

INSERT INTO product VALUES (11,'电脑10',2999,11,'2020-12-21');

## 批量添加指定列的数据
INSERT INTO  表名 (列名1,列名2,列名3,...) VALUES 
	(值1,值2,值3,...),
	(值1,值2,值3,...),
	(值1,值2,值3,...),
	...;
INSERT INTO product (id,NAME,price) VALUES 
	(2,'电脑2',8199.02),
	(3,'电脑3',8199.03),
	(4,'电脑4',8199.04),
	(5,'电脑5',8199.05);

## 批量添加全部列的数据
INSERT INTO  表名  VALUES 
	(所有列的值),
	(所有列的值),
	(所有列的值),
	...;
INSERT INTO product  VALUES 
	(6,'电脑6',8199.06,6,'2020-12-21'),
	(7,'电脑7',8199.07,7,'2020-12-21'),
	(8,'电脑8',8199.08,8,'2020-12-21'),
	(9,'电脑9',8199.09,9,'2020-12-21');


SELECT* FROM product;

DESC product;

#######################################################################
# 修改数据
## 修改表中的数据
UPDATE 表名 SET 列名1 = 值1,列名2 = 值2,... [WHERE 条件];
注意: 修改语句中必须添加上条件，否则将修改表中所有的数据;

UPDATE product SET NAME='手机' WHERE id = 2;
UPDATE product SET price = 10000 WHERE NAME = '手机';
UPDATE product SET price = 9999 , stock = 199 WHERE id = 2;
SELECT * FROM product;


## 删除表中的数据
DELETE FROM 表名 WHERE 条件;
注意: 删除语句中必须添加上条件，否则将删除表中所有的数据;
DELETE FROM product WHERE id = 1;
SELECT * FROM product;
DELETE FROM product WHERE stock = NULL AND id = 1;
SELECT * FROM product ; 









