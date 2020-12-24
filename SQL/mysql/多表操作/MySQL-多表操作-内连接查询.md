### 内连接查询

#### 查询原理

​		内连接查询的是两张表有**交集**部分数据（有**主外键关联**的数据）

#### 显示内连接查询

``` sql
## 显示内连接查询
## 语法
SELECT 列名 FROM 表名1 [INNER] JOIN 表名2 ON 条件 ;

## 查询 用户信息和对应的订单信息
SELECT * FROM USER INNER JOIN orderlist ON  orderlist.uid = user.id;

SELECT * FROM orderlist INNER JOIN USER  ON orderlist.uid = user.id;

SELECT user.id,user.name,orderlist.number FROM USER,orderlist WHERE orderlist.uid = user.id;


```



#### 隐式内连接查询

``` sql
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

```



