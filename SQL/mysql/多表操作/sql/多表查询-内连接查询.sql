

# 内连接查询
## 显示内连接查询
## 语法
SELECT 列名 FROM 表名1 [INNER] JOIN 表名2  ON 条件;

-- 查询用户信息和对应的订单信息
SELECT * FROM USER INNER JOIN orderlist o ON o.uid = user.id;

SELECT * FROM USER;


## 隐式内连接
## 语法
SELECT 列名 FROM 表名1 , 表名2 WHERE 条件;






