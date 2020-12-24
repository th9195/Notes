## 自关联查询



### 概念

​	在同一张数据表右关联性，我们可以把这张表当成多个表来查询.

### 案例

``` sql 

DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32),
	mgr INT ,
	salary DOUBLE
);



DELETE FROM employee;

INSERT INTO employee VALUES 
	(1001,'孙悟空',1005,9000.00),
	(NULL,'猪八戒',1005,8000.00),
	(NULL,'沙和尚',1005,8500.00),
	(NULL,'小白龙',1005,7900.00),
	(NULL,'唐僧',NULL,15000.00),
	(NULL,'武松',1009,7600.00),
	(NULL,'李逵',1009,7400.00),
	(NULL,'林冲',1009,8100.00),
	(NULL,'宋江',NULL,16000.00);
## 自关联查询
## 概念：在同一张数据表右关联性，我们可以把这张表当成多个表来查询.
## 语法


-- 查询所有员工的姓名 及其 直接上级的姓名，没有上级的员工也需要查询

/*
分析
	员工信息： employee 表
	条件： employee1.mgr = employee2.id
	查询左表的全部信息， 使用左外连接查询
*/


SELECT 
	e1.name,
	e2.name mgr
FROM 
	employee e1 
	
LEFT OUTER JOIN
	employee e2 
	
ON 
	e1.mgr = e2.id;


-- 也可以使用子查询的方式查询
SELECT * FROM employee WHERE mgr IS NULL;

SELECT 
	e1.id,
	e1.name,
	e2.name
FROM 
	employee e1 

LEFT OUTER JOIN 

	(SELECT * FROM employee WHERE mgr IS NULL) e2
	
ON 
	e1.mgr = e2.id;


```

