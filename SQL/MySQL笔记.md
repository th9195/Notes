## 1-分类

### DDL

​		数据定义语言。用来操作数据库、表、列

- 查询所有数据库

  - SHOW DATABASES;

    ``` sql
    shwo databases;
    
    结果：
    day08
    information_schema
    mysql
    performance_schema
    studyPython
    sys
    ```

    

- 查询数据库的创建语句

  - SHOW CREATE DATABASE 数据库名称;

    ``` sql
    show CREATE DATABASE studyPython;
    结果：
    CREATE DATABASE `studyPython` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */
    ```

    



​		

### DML

​		数据操作语言。用来对数据库中表的数据进行增删改。



### DQL

​		数据查询语言。用来查询数据库中表的记录（数据）。



### DCL

​		数据控制语言。用来定义数据库的访问权限和安全级别，及创建用户。

































