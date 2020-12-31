## MySQL 存储引擎介绍



- MySQL支持的存储引擎有很多， 常用的有三种 InnoDB 、MyISAM 、MEMORY

| 存储引擎名称 | 优点                                               | 缺点                 |
| ------------ | -------------------------------------------------- | -------------------- |
| InnoDB       | 支持事务和外键操作， 支持并发控制                  | 占用磁盘空间大       |
| MyISAM       | 访问快                                             | 不支持事务和外键操作 |
| MEMORY       | 内存存储、访问速度最快  **适合小量快速访问的数据** | 不安全               |



### 查询数据库支持的存储引擎

``` sql
SHOW ENGINES;
```



### 查询某个数据库所有数据表的存储引擎
``` sql
SHOW TABLE STATUS FROM 数据库名称;
SHOW TABLE STATUS FROM bigdata;
```



### 查询某个表的存储引擎

``` sql
SHOW TABLE STATUS FROM 数据库名称 WHERE NAME=‘表名’;
SHOW TABLE STATUS FROM bigdata WHERE NAME="category";
```




### 创建表是指定存储引擎
``` sql
CREATE TABLE 表名(
	列名 数据类型 约束,
	...
	
)ENGINE=引擎名称;

创建表test_engine 并指定存储引擎为InnoDB

CREATE TABLE test_engine(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32)
)ENGINE=INNODB;

查看test_engine 表的存储引擎

SHOW TABLE STATUS FROM bigdata WHERE NAME='test_engine';
```



### 修改存储引擎
``` sql
ALTER TABLE 表名 ENGINE=引擎名称;
ALTER TABLE test_engine ENGINE=MYISAM;
```





### 如何选择存储引擎

- **MyISAM**
  - 特点：不支持事务和外键。读取速度快， 节约资源；
  - 使用场景 : 以查询操作为主，只有很少的更新和删除操作，并且对事务的完整性、并发性要求不是很高。
- **InnoDB**
  - 特点：MySQL 的默认存储引擎，支持事务和外键操作；
  - 使用场景：对事务的完整性有比较高的要求，在并发条件下要求数据的一致性，读写频繁的操作；
- **MEMORY**
  - 特点：将所有数据保存在内存中，在需要快速定位记录和其他类似数据环境下，可以提供更快的访问。
  - 使用场景：通常用于更新不太频繁的小表，用来快速得到访问的结果；