## jdbc的快速入门程序

1. 导入jar包

2. 注册驱动com.mysql.jdbc.Driver

   - ```java
     Class.forName("com.mysql.jdbc.Driver");
     ```

3. 获取数据库连接 jdbc:mysql://192.168.88.100:3306/bigdata

   - ```java
     String url = "jdbc:mysql://192.168.88.100:3306/bigdata";
             String username = "root" ;
             String password = "123456";
             Connection connection = DriverManager.getConnection(url, username, password);
     ```

4. 获取执行者对象

5. 执行sql语句并返回结果

6. 处理结果

7. 释放资源





### 案例1 查询uuser表中的所有数据

``` java
		// 1- 导入jar包


        // 2- 注册驱动
        Class.forName("com.mysql.jdbc.Driver");

        // 3- 获取数据库连接
        String url = "jdbc:mysql://192.168.88.100:3306/bigdata";
        String username = "root" ;
        String password = "123456";
        Connection connection = DriverManager.getConnection(url, username, password);

        // 4- 获取执行者对象
        Statement statement = connection.createStatement();

        // 5- 执行sql语句并返回结果
        String sql = "select * from uuser";
        ResultSet resultSet = statement.executeQuery(sql);

        // 6- 处理结果

        while(resultSet.next()){
            Integer id = resultSet.getInt("id");
            String name = resultSet.getString("name");
            int age = resultSet.getInt("age");

            System.out.println(id + "\t" + name + "\t" + age);
        }

        // 7- 释放资源
        resultSet.close();
        statement.close();
        connection.close();
```



### 案例2 创建student表

``` java
		// 1- 加载驱动
        Class.forName("com.mysql.jdbc.Driver");

        // 2- 获取连接
        String url = "jdbc:mysql://192.168.88.100:3306/jdbc";
        String username = "root";
        String password = "123456";
        Connection connection = DriverManager.getConnection(url, username, password);

        // 3- 创建执行者对象
        Statement statement = connection.createStatement();

        // 4- 执行sql语句并获取结果
        String sql = "CREATE TABLE IF NOT EXISTS student(\n" +
                "\tid INT PRIMARY KEY AUTO_INCREMENT,\n" +
                "\tNAME VARCHAR(32),\n" +
                "\tgender VARCHAR(2)\n" +
                ");";


        // 5- 处理结果
        int i = statement.executeUpdate(sql);


        System.out.println("创建学生表成功！");

        // 6- 释放资源
        statement.close();
        connection.close();
```



### 功能类详解 DriverManager 驱动管理对象

- 注册驱动

  - static void registerDriver(Driver driver);

  - 但是我们写代码的时候使用： Class.forName("com.mysql.jdbc.Driver");

  - 原因：在com.mysql.jdbc.Driver类中存在一个静态代码块

    ``` java
    static {
            try {
                DriverManager.registerDriver(new Driver());
            } catch (SQLException var1) {
                throw new RuntimeException("Can't register driver!");
            }
        }
    ```

  - 注意： 

    - **我们不需要通过DriverManager调用静态方法registerDriver()，因为只要Driver类被使用，则会执行其静态代码块完成注册驱动** 
    - **mysql5之后可以省略注册驱动的步骤。在jar包中，存在一个java.sql.Driver配置文件，文件中指定了com.mysql.jdbc.Driver**

- 获取数据库连接

  - static Connection getConnection(String url,String user,String password);
  - 返回值：Connection 数据库连接对象
  - 参数：
    - url : jdbc:mysql://ip地址:断开号/数据库名称



### 功能类详解 Connection 数据库连接对象

- 获取执行者对象

  - 获取普通执行者对象：

    ``` java
    Statement createStatement();
    ```

  - 获取预编译执行者对象

    ``` java
    PreparedStatement prepareStatement(string sql);
    ```

- 事务管理

  - 开启事务: setAutoCommit(boolean autoCommit);   参数为false ,则开启事务。
  - 提交事务：commit();
  - 回滚事务:   rollback();

- 释放资源

  - void close();



### 功能类详解 Statement 执行者对象

- 执行DML语句： int executeUpdate(String sql);
  - 返回值 int ： 返回影响的行数；
  - 参数sql： 可以执行 insert update delete create alter 等语句；
- 执行DQL语句 ResultSet executeQuery(Stirng sql);
  - 返回值ResultSet ： 封装查询的结果；
  - 参数sql： 可以执行select 语句；
- 释放资源
  - void close();



### 功能类详解 ResultSet 结果集对象

- 判断结果集中是否还有数据： boolean next();

  - 如果有数据，返回true , 并将索引向下移动一行;
  - 如果没有数据， 返回 false;

- 获取结果集中的数据： XXX  getXxx("列名");

  - XXX 代表数据类型
  - 例如： String getString("name");
  - int getInt("age");

- 释放资源

  ​	void close();

  

  

  

  

  

  

  







