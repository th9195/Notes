
# 分组查询
## 语法
SELECT 列名 FROM 表名 [WHERE 条件] GROUP BY 分组列名 [HAVING 分组后条件过滤] [ORDER BY 排序列 排序方式]

## 按照品牌分组， 获取每组商品的总金额
SELECT brand , SUM(price) AS getSum FROM product GROUP BY brand;

## 对price大于3000的商品 按照品牌分组， 获取每组商品的总金额
SELECT brand, SUM(price) AS getSu FROM product WHERE price > 3000 GROUP BY brand;


## 对price大于3000的商品 按照品牌分组， 获取每组商品的总金额 , 只显示总金额>5000的商品
SELECT brand , SUM(price) AS getSum FROM product 
	WHERE price > 3000 
	GROUP BY brand 
	HAVING getSum > 5000;

## 对price大于3000的商品 按照品牌分组， 获取每组商品的总金额 , 只显示总金额>8000的商品 
SELECT brand , SUM(price) AS getSum FROM product
	WHERE price > 3000
	GROUP BY brand
	HAVING getSum > 5000 
	ORDER BY getSum DESC;












