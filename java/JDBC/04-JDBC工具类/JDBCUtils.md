## JDBCUtils

### 步骤

``` java
// 1- 私有构造方法 private

// 2- 声明所有需要的配置变量 

// 3- 提供静态代码块，读取配置文件中的信息给变量赋值；并注册驱动

// 4- 提供获取数据库连接的方法

// 5- 提供释放资源的方法
```





### 配置文件 config.properties

``` properties
driverClass=com.mysql.jdbc.Driver
url=jdbc:mysql://192.168.88.100:3306/jdbc
username=root
password=123456
```



### 使用类加载器获取配置文件信息

``` java
static {
        try{
            InputStream stream = JDBCUtils.class.
                    getClassLoader().
                    getResourceAsStream("config.properties");
            Properties properties = new Properties();
            properties.load(stream);
        }catch ( Exception e){
            e.printStackTrace();
        }
    }
```





### 代码

``` java
package com.fiberhome.utils;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/**
 * JDBC 工具类
 */
public class JDBCUtils {

    // 1- 私有构造方法
    private JDBCUtils(){

    }

    // 2- 声明需要的配置变量
    private static String driverClass;
    private static String url;
    private static String username;
    private static String password;
    private static  Connection connection = null;

    // 3- 提供静态代码块。 读取配置文件的信息为变量赋值，注册驱动
    static {
        try{
            // 读取配置文件的信息为变量赋值
            // 类加载器获取流对象
            InputStream stream = JDBCUtils.class.getClassLoader().getResourceAsStream("config.properties");
            Properties properties = new Properties();
            properties.load(stream);
            driverClass = properties.getProperty("driverClass");
            url = properties.getProperty("url");
            username = properties.getProperty("username");
            password = properties.getProperty("password");

            // 注册驱动
            Class.forName(driverClass);
        }catch ( Exception e){
            e.printStackTrace();
        }
    }
    // 4- 提供获取数据库连接方法
    public static Connection getConnection(){

        if (connection == null) {
            try{
                connection = DriverManager.getConnection(url,username,password) ;
            }catch ( Exception e){
                e.printStackTrace();

            }
        }
        return connection;
    }

    // 5- 提供释放资源的方法
    public static void close(Connection connection, Statement statement, ResultSet resultSet){

        // 释放 connection 和 statement
        close(connection,statement);

        // 释放 resultSet
        if (resultSet != null) {
            try{
                resultSet.close();
            }catch ( Exception e){
                e.printStackTrace();
            }
        }
    }

    // 释放 connection 和 statement
    public  static void close(Connection connection,Statement statement){
        // 释放 connection
        if (connection != null) {
            try{
                connection.close();
            }catch ( Exception e){
                e.printStackTrace();
            }
        }
        // 释放 statment
        if (statement != null) {
            try{
                statement.close();
            }catch ( Exception e){
                e.printStackTrace();
            }
        }
    }
}

```



