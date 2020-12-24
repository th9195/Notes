


# 外连接查询
## 左外连接查询  显示左边的表的全部内容
## 语法
SELECT 列名 FROM 表名1 LEFT OUTER JOIN 表名2 ON 条件;

SELECT 
	u.name,
	u.age,
	o.number
	
FROM
	USER u
LEFT OUTER JOIN
	orderlist o
ON 
	o.uid = u.id;


## 右外连接查询
## 语法
SELECT 列名 FROM 表名1 RIGHT OUTER JOIN 表名2 ON 条件;

SELECT 
	u.name,
	u.age,
	o.number
FROM
	USER u
RIGHT OUTER JOIN 
	orderlist o
	
ON 	
	o.uid = u.id;



