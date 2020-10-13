# 数据库-SQL-mysql-connector



## 安装

``` python
python -m pip install mysql-connector
```





## 链接数据库 对数据库的操作

``` python

import mysql.connector as sql_connector
if __name__ == '__main__':

    # 创建数据库连接 （这个时候并没有链接数据库中的具体哪个库）
    mydb = sql_connector.connect(
        host = "localhost",
        user = "root",
        passwd = "12345678"
        )

    print(mydb)

    # 创建游标
    cursor = mydb.cursor()

    # 选择一个数据库
    cursor.execute("use studyPython")

    # 创建一个数据库
    cursor.execute("create database day08")
    

    # 获取所有数据库
    cursor.execute("show databases")
    for database in cursor:
        print(database)
```

