## 隐式内连接查询
## 语法
SELECT 列名 FROM 表名1 , 表名2 WHERE 条件 ;


-- 查询用户姓名，年龄，订单号

SELECT 
	u.name,
	u.age,
	o.number
FROM 
	USER u,
	orderlist o
WHERE
	o.uid = u.id;



