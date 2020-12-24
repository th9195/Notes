
## 外键级联操作
USE bigdata;

DROP TABLE IF EXISTS orderlist;
DROP TABLE IF EXISTS USER;

CREATE TABLE USER(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32) NOT NULL
);

INSERT INTO USER VALUES
(NULL,'张三'),
(NULL,'李四');

DROP TABLE IF EXISTS orderlist;
CREATE TABLE orderlist(
	id INT PRIMARY KEY AUTO_INCREMENT,
	number VARCHAR(32) UNIQUE,
	uid INT NOT NULL,
	CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER (id)
);

INSERT INTO orderlist VALUES 
	(NULL,'hm001',1),
	(NULL,'hm002',1),
	(NULL,'hm003',2),
	(NULL,'hm004',2);
	

## 外键级联更新、删除
## 语法
CREATE TABLE 表名(
	列名 数据类型 约束,
	...
	CONSTRAINT 外键名 FOREIGN KEY (本表外键列名) REFERENCES 主表名(主表主键列名)
	ON UPDATE CASCADE ON DELETE CASCADE
);

## 删除外键
ALTER TABLE orderlist DROP FOREIGN KEY ou_fk1;

## 添加外键并同时添加级联更新和级联删除
ALTER TABLE orderlist ADD CONSTRAINT ou_fk1 FOREIGN KEY (uid) REFERENCES USER (id) ON UPDATE CASCADE ON DELETE CASCADE;

## 查看创建表的语句
SHOW CREATE TABLE orderlist;
/*
CREATE TABLE `orderlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(32) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `ou_fk1` (`uid`),
  CONSTRAINT `ou_fk1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8
*/

## 将李四这个用户的id 修改 成3
UPDATE USER  SET id = 3 WHERE NAME = '李四';


## 将李四用户删除
DELETE FROM USER WHERE NAME = '李四';


