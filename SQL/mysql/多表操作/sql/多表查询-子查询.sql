

# 子查询
## 概念：查询语句中嵌套了其它的查询语句，我们就将嵌套的查询称为子查询;



## 查询是单行单列的
### 查询作用
### 可以将查询结果作为另外一条语句的查询条件，使用运算符判断。 = > <  >= <=等。
### 查询语法
SELECT 列名 FROM 表名 WHERE 列名 = (SELECT 列名 FROM 表名 [WHERE 条件]);

-- 查询用户最高的用户姓名

SELECT MAX(age) FROM uuser ;
SELECT * FROM uuser WHERE age = (SELECT MAX(age) FROM uuser );



## 查询结果是多行单列的
### 查询作用
### 可以作为条件，使用运算符 in 或者not in 进行判断
### 查询语法
SELECT 列名 FROM 表名 WHERE 列名 [NOT] IN (SELECT 列名 FROM 表名 [WHERE 条件]);

-- 查询张三和李四的订单信息

SELECT uu.id FROM uuser uu WHERE uu.name IN ('张三','李四');



## 隐式内连接查询
SELECT 
	uu.name,			-- 用户姓名
	uu.age,				-- 用户年龄
	o.number

FROM
	uuser uu,
					-- 隐式内连接

	orderlist o
WHERE 

	o.uid = uu.id 			-- 外键连接
	
AND 
	uu.id 
IN
	(SELECT uu.id FROM uuser uu WHERE uu.name IN ('张三','李四'));   -- 获取张三 李四的id




## 显示内连接查询
SELECT 
	uu.name,			-- 用户姓名
	uu.age,				-- 用户年龄
	o.number

FROM
	uuser uu
	
INNER JOIN				-- 显示内连接

	orderlist o
ON 

	o.uid = uu.id 			-- 外键连接
	
AND 
	uu.id 
IN
	(SELECT uu.id FROM uuser uu WHERE uu.name IN ('张三','李四'));   -- 获取张三 李四的id



## 查询结果是多行多列
## 查询作用
## 查询的结果可以作为一张虚拟的表参与查询
## 查询语法
SELECT 列名 FROM 表名 [别名] (SELECT 列名 FROM 表名 [WHERE 条件] )[别名] [WHERE 条件];

-- 查询订单表中id > 4 的订单信息 和所属用户的信息
SELECT * FROM orderlist WHERE id > 4;

SELECT 
	uu.name,						-- 用户姓名
	uu.age,							-- 用户年龄
	oo.number						-- 订单号
FROM 
	uuser uu
	
RIGHT OUTER JOIN						-- 需要显示所有的订单信息 使用 右外连接

	(SELECT * FROM orderlist WHERE id > 4) oo		-- 所有订单号 > 4 的订单信息
ON 
	uu.id = oo.uid;




