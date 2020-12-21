DELETE FROM product ;

SELECT * FROM product;

ALTER TABLE product ADD brand VARCHAR(32);

DESC product;
INSERT INTO product VALUES
	(1,'手机1',1999,21,'2020-01-20','华为'),
	(2,'手机2',2999,21,'2020-02-20','华为'),
	(3,'手机3',3999,21,'2020-03-20','华为'),
	(4,'手机4',4999,21,'2020-04-20','华为'),
	(5,'手机5',5999,21,'2020-05-20','华为'),
	(6,'手机6',6999,21,'2020-06-20','华为'),
	(7,'手机7',7999,21,'2020-07-20','华为');

UPDATE product SET brand = '苹果' WHERE id IN (3,6)

 
# 语法介绍
SELECT 
	字段列表
FROM
	表名
WHERE
	条件列表
GROUP BY
	分组字段
HAVING
	分组后的过滤条件
ORDER BY 
	排序
LIMIT
	分页
	

## 查询全部数据
SELECT * FROM 表名;
SELECT * FROM product;

## 查询指定字段的表数据
SELECT 列名1,列名2,... FROM 表名;
SELECT NAME,price,brand FROM product;


## 去掉重复查询 distinct;
SELECT DISTINCT 列名1,列名2,...FROM 表名;
SELECT brand FROM product;
SELECT DISTINCT brand FROM product;


## 计算列的值(四则运算)
SELECT 列名1 运算符(+-*/)列名2 FROM 表名;
SELECT NAME , price + 1000 AS price , brand FROM product;
## 如果某一列的值为null，可以进行替换 
# ifnull(表达式1,表达式2) 函数
# 表达式1: 想替换的列
# 表达式2: 想替换的值
SELECT NAME , IFNULL(price,0) + 1000 AS price , brand FROM product;



## 起别名查询 as
SELECT 列名 AS 别名 FROM 表名;
SELECT p.name AS p_name ,p.price AS p_price ,p.brand AS p_brand FROM product p;


UPDATE product SET price = NULL WHERE id = 7;


















