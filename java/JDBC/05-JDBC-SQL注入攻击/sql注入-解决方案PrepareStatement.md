## sql 注入



### 正常sql

``` sql
select * from user where username='Tom' and password = '123456'
```



### sql注入  or 1=1

``` sql
select * from user where username='Tom' and password = 'faldskj' or 1 = 1
```



## 解决方法 

### PrepareStatement 预编译执行者对象

- 在执行sql语句之前，将sql语句进行提前编译。 明确sql语句的格式后，就不会改变了。 剩余的内容都会认为是参数！
- SQL 语句中的参数使用 ？ 作为占位符；
- 

### ？占位符赋值的方法： setXxx(参数1 ，参数2);

- Xxx代表：数据类型；
- 参数1：？ 的位置编号（从1开始）；
- 参数2： ？的实际参数
- 例如：

``` java
String sql = "select * from user where name = ? and age = ? ";
pstm = conn.prepareStatement(sql);
pstm.setString(1,"张三");
pstm.setInt(2,25);
```



### 执行SQL语句

- 执行insert、update、delete 语句 ： int executeUpdate();
- 执行select 语句 : ResultSet executeQuery();