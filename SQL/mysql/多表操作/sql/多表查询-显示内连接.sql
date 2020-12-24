

## 显示内连接查询
## 语法
SELECT 列名 FROM 表名1 [INNER] JOIN 表名2 ON 条件 ;

## 查询 用户信息和对应的订单信息
SELECT * FROM USER INNER JOIN orderlist ON  orderlist.uid = user.id;

SELECT * FROM orderlist INNER JOIN USER  ON orderlist.uid = user.id;

SELECT user.id,user.name,orderlist.number FROM USER,orderlist WHERE orderlist.uid = user.id;




