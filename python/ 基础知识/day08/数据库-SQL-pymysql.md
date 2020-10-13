

# MYSQL



## 安装

``` python
pip install pymysql
```



## 使用PyMySQL链接数据库

``` python

import pymysql

def testConnectSql():
    # 1- 链接数据库
    db = pymysql.connect("localhost", "root", "12345678", "studyPython")

    # 2- 创建游标
    cursor = db.cursor()

    # 3- 执行SQL语句
    str = "select version()"
    cursor.execute(str)

    # 4- 获取结果
    data = cursor.fetchone()
    print(data)

    # 5- 提交事务

    # 6- 关闭游标
    cursor.close()

    # 7- 断开链接数据库
    db.close()

结果：
('8.0.21',)
```



## 创建表

``` python
import pymysql
def testCreateTable():
    # 1- 链接数据库
    db = pymysql.connect("localhost","root","12345678","studyPython")

    # 2- 创建游标
    cursor = db.cursor()

    # 3- 执行SQL语句
    del_table_sql = "DROP TABLE IF EXISTS books"  # 如果存在这个表就删除
    create_table_sql = '''
            CREATE TABLE books (
                id int(8) NOT NULL AUTO_INCREMENT,
                name varchar(50) NOT NULL,
                category varchar(50) NOT NULL,
                price decimal(10,2) DEFAULT NULL,
                publish_time date DEFAULT NULL,
                PRIMARY KEY(id)
            
            ) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
        '''

    ##如果已经存在这个表，不删除再次创建就会报错：pymysql.err.OperationalError: (1050, "Table 'books' already exists")
    cursor.execute(del_table_sql)
    cursor.execute(create_table_sql)

    # 4- 获取结果
    result = cursor.fetchone();
    print(result)

    # 5- 提交事务


    # 6- 关闭游标
    cursor.close()

    # 7- 断开链接数据库
    db.close()
```



## 插入数据 insert

``` python

import pymysql
def testInsertData():
    # 1- 链接数据
    print("connect")
    db = pymysql.connect("localhost","root","12345678","studyPython")

    # 2- 创建游标
    print("create cursor")
    cursor = db.cursor()

    data = [("java01","java1","99.8","2020-09-22"),
            ("java02","java2","99.7","2020-09-21"),
            ("java03","java3","99.6","2020-09-20"),
            ("java04","java4","99.5","2020-09-19"),
            ("java05","java5","99.4","2020-09-18"),]

    insertsql = "insert into books (name,category,price,publish_time) values (%s,%s,%s,%s)"

    try:
        # 3- 执行SQL语句
        print("executemany")
        cursor.executemany(insertsql,data)

        # 5- 提交事务
        print("commit")
        db.commit()
    except:

        # 如果事务是吧回滚
        print("rollback")
        db.rollback()

    finally:

        # 6- 关闭游标
        print("cursor->close")
        cursor.close()

        # 7- 断开链接数据库
        print("db -> close")
        db.close()

```



## 查询 条件查询

``` python
import pymysql
def testSelectData():
    # 1- 链接数据
    db = pymysql.connect("localhost","root","12345678","studyPython")

    # 2- 创建游标
    cursor = db.cursor()

    # 3- 执行sql语句
    querySql = "select * from books where publish_time < %s"
    cursor.execute(querySql,"2020-09-20")

    # 4- 获取结果
    queryResults = cursor.fetchall()
    for resut in queryResults:
        print(resut)

    # 5- 提交事务

    # 6- 关闭游标
    cursor.close()

    # 7- 断开数据库连接
    db.close()
```



## 更新数据数据

``` python
import pymysql
def testUpdateData():
    # 1- 链接数据
    db = pymysql.connect("localhost", "root", "12345678", "studyPython")

    # 2- 创建游标
    cursor = db.cursor()

    # 3- 执行sql语句
    # updateSql = "update books set price = price - 0.5 where publish_time < %s"
    # cursor.execute(updateSql, "2020-09-20")
    # updateSql = "update books set name = CONCAT('hello',name) where publish_time < %s"
    # cursor.execute(updateSql, "2020-09-20")
    updateSql = "update books set name = right(name,6) where publish_time < %s"
    cursor.execute(updateSql, "2020-09-20")

    # 4- 获取结果
    queryResults = cursor.fetchall()
    for resut in queryResults:
        print(resut)

    # 5- 提交事务

    # 6- 关闭游标
    cursor.close()

    # 7- 断开数据库连接
    db.close()
```



## 删除数据库数据

``` python
import pymysql
def testDelData():
    # 1- 链接数据
    db = pymysql.connect("localhost", "root", "12345678", "studyPython")

    # 2- 创建游标
    cursor = db.cursor()

    try:
        # 3- 执行sql语句

        delSql = "delete from  books where price < %s"
        cursor.execute(delSql, "99.8")

        # 4- 获取结果

        # 5- 提交事务
        db.commit()
    except:
        db.rollback()

    # 6- 关闭游标
    cursor.close()

    # 7- 断开数据库连接
    db.close()
```

