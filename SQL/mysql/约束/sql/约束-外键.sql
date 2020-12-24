
USE BIGDATA;

DROP TABLE IF EXISTS USER;

CREATE TABLE USER (
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32) NOT NULL UNIQUE
);


INSERT INTO USER VALUES
(NULL,'张三'),
(NULL,'李四');



## 外键约束
### 创建表是添加外键约束
CREATE TABLE 表名(
	列名 数据类型 约束,
	...
	CONSTRAINT 外键名称 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名)

);
DROP TABLE IF EXISTS orderlist;
CREATE TABLE orderlist(
	id INT PRIMARY KEY AUTO_INCREMENT,
	number VARCHAR(32) NOT NULL,
	uid INT ,  -- 外键列
	CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER(id)
);
INSERT INTO orderlist VALUES
(NULL,'hm001',1),
(NULL,'hm002',1),
(NULL,'hm003',2),
(NULL,'hm004',2);

DESC orderlist;
DESC USER;

### 添加数据Cannot add or update a child row: a foreign key constraint fails (`bigdata`.`orderlist`, CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`))
INSERT INTO orderlist VALUES (NULL,'hw005',3);

### 修改数据 Cannot delete or update a parent row: a foreign key constraint fails (`bigdata`.`orderlist`, CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`))
UPDATE USER SET id = 3 WHERE id = 2;

### 删除数据 Cannot delete or update a parent row: a foreign key constraint fails (`bigdata`.`orderlist`, CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`))
DELETE FROM USER WHERE id = 2; 




### 删除外键
ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;
ALTER TABLE orderlist DROP FOREIGN KEY ou_fk1;


### 建表后添加外键
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名);
ALTER TABLE orderlist ADD CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER(id);



SHOW CREATE TABLE orderlist;




