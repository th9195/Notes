## JDBC 案例

### 步骤：

``` java
// 0- 加载jar包   mysql-connector-java-8.0.20.jar

// 1- 加载驱动 com.mysql.jdbc.Driver

// 2- 获取连接对象Connection url = "jdbc:mysql://192.168.88.100:3306/jdbc"
           
// 3- 获取执行者对象Statement

// 4- 执行sql获取结果 resultSet

// 5- 处理结果

// 6- 释放资源
```



### 数据准备

``` sql
DROP TABLE IF EXISTS student;
CREATE TABLE IF NOT EXISTS student(
	id INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(32),
	age INT,
	birthday DATE
);


INSERT INTO student VALUES
	(NULL,'张三',21,'1991-09-01'),
	(NULL,'李四',22,'1991-09-02'),
	(NULL,'王五',23,'1991-09-03'),
	(NULL,'赵六',24,'1991-09-04');
```



### 实体类

``` java
package com.fiberhome.domain;

import java.util.Date;

public class Student {

    private Integer id;
    private String name;
    private  Integer age;
    private Date birthday;

    public Student() {

    }

    public Student(Integer id, String name, Integer age, Date birthday) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.birthday = birthday;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", birthday=" + birthday +
                '}';
    }


}

```



### DAO层

``` java
package com.fiberhome.dao;

import com.fiberhome.domain.Student;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class StudentDaoImpl implements StudentDao{
    @Override
    public ArrayList findAll()  {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        ArrayList<Student> students = new ArrayList<Student>();

        try {
            // 1- 加载驱动
            Class.forName("com.mysql.jdbc.Driver");

            // 2- 获取连接对象
            String url = "jdbc:mysql://192.168.88.100:3306/jdbc";
            String username = "root";
            String password = "123456";
            connection = DriverManager.getConnection(url, username, password);

            // 3- 获取执行者对象
            statement = connection.createStatement();

            // 4- 执行sql获取结果
            String sql = "select * from student";
            resultSet = statement.executeQuery(sql);

            // 5- 处理结果

            while (resultSet.next()){
                Student student = new Student();
                student.setId(resultSet.getInt("id"));
                student.setName(resultSet.getString("name"));
                student.setAge(resultSet.getInt("age"));
                student.setBirthday(resultSet.getDate("birthday"));
                students.add(student);
            }


        }catch (Exception e){
            e.printStackTrace();
        }finally {
            // 6- 关闭资源
            if (resultSet != null){
                try {
                    resultSet.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            if (statement != null){
                try {
                    statement.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }

        return students;
    }

    @Override
    public Student findById(Integer id) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        Student student = new Student();;

        try {
            // 1- 加载驱动
            Class.forName("com.mysql.jdbc.Driver");

            // 2- 获取连接对象
            String url = "jdbc:mysql://192.168.88.100:3306/jdbc";
            String username = "root";
            String password = "123456";
            connection = DriverManager.getConnection(url, username, password);

            // 3- 获取执行者对象
            statement = connection.createStatement();

            // 4- 执行sql获取结果
            String sql = "select * from student where id = " + id ;
            resultSet = statement.executeQuery(sql);

            // 5- 处理结果

//            student.setId(resultSet.getInt("id"));
            while (resultSet.next()){
                student.setId(id);
                String name = resultSet.getString("name");
                student.setName(name);
                student.setAge(resultSet.getInt("age"));
                student.setBirthday(resultSet.getDate("birthday"));
            }

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            // 6- 关闭资源
            if (resultSet != null){
                try {
                    resultSet.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            if (statement != null){
                try {
                    statement.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }

        return student;
    }

    @Override
    public int insert(Student student) {

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        int result = -1;

        try {
            // 1- 加载驱动
            Class.forName("com.mysql.jdbc.Driver");

            // 2- 获取连接对象
            String url = "jdbc:mysql://192.168.88.100:3306/jdbc";
            String username = "root";
            String password = "123456";
            connection = DriverManager.getConnection(url, username, password);

            // 3- 获取执行者对象
            statement = connection.createStatement();

            // 4- 执行sql获取结果
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String birthdayStr = simpleDateFormat.format(student.getBirthday());
            String sql = "insert into student values (" + student.getId() + ",'"+
                                                student.getName() + "',"+
                                                student.getAge() + ",'" +
                                                birthdayStr+"')" ;
            System.out.println(sql);
            result = statement.executeUpdate(sql);

            // 5- 处理结果

        }catch (Exception e){
            e.printStackTrace();
        }finally {
            // 6- 关闭资源
            if (resultSet != null){
                try {
                    resultSet.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            if (statement != null){
                try {
                    statement.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
            if(connection != null){
                try {
                    connection.close();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }

        return result;
    }

    @Override
    public int update(Student student) {

        String url = "jdbc:mysql://192.168.88.100:3306/jdbc";
        String name = "root";
        String password = "123456";
        Connection connection = null;
        Statement statement = null;

        int result = -1;

        try{
            // 1- 加载驱动
            Class.forName("com.mysql.jdbc.Driver");
            // 2- 连接数据库
            connection = DriverManager.getConnection(url,name,password);

            // 3- 获取执行者对象
            statement = connection.createStatement();

            // 4- 执行sql 并获取结果
            Date birthday = student.getBirthday();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String birthdayStr = simpleDateFormat.format(birthday);
            String sql = "update student set name = '"+student.getName()+
                            "',age = " + student.getAge() +
                            ", birthday = '" + birthdayStr +"' where id = " + student.getId();
            System.out.println(sql);
            result = statement.executeUpdate(sql);

            // 5- 处理结果


        }catch ( Exception e){
            e.printStackTrace();

        }finally{
            // 6- 释放资源
            if (statement != null) {
                try{
                    statement.close();
                }catch ( Exception e){
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try{
                    connection.close();
                }catch ( Exception e){
                    e.printStackTrace();

                }
            }
        }

        return result;
    }

    @Override
    public int delete(Integer id) {
        Connection connection = null;
        Statement statement = null;
        String url = "jdbc:mysql://192.168.88.100:3306/jdbc";
        String name = "root";
        String password = "123456";
        int result = -1;
        try{
            // 1- 加载驱动
            Class.forName("com.mysql.jdbc.Driver");

            // 2- 连接数据
            connection = DriverManager.getConnection(url,name,password);

            // 3- 获取执行者对象
            statement = connection.createStatement();

            // 4- 执行SQL并获取结果
            String sql = "delete from student where id = " + id;
            System.out.println(sql);
            result  = statement.executeUpdate(sql);
            // 5- 处理结果

        }catch ( Exception e){
            e.printStackTrace();

        }finally{
            // 6- 释放资源
            if (statement != null) {
                try{
                    statement.close();
                }catch ( Exception e){
                    e.printStackTrace();

                }
            }

            if (connection != null) {
                try{
                    connection.close();      
                }catch ( Exception e){
                    e.printStackTrace();
                    
                }
            }
        }
        return result;
    }
}

```

### Service层

``` java
package com.fiberhome.service;

import com.fiberhome.dao.StudentDao;
import com.fiberhome.dao.StudentDaoImpl;
import com.fiberhome.domain.Student;

import java.util.ArrayList;
import java.util.List;

public class StudentServiceImpl implements StudentService{
    private StudentDao studentDao = new StudentDaoImpl();
    @Override
    public ArrayList<Student> findAll() throws Exception {

        ArrayList<Student> students = studentDao.findAll();

        return students;
    }

    @Override
    public Student findById(Integer id) {
        Student student = studentDao.findById(id);
        return student;
    }

    @Override
    public int insert(Student student) {
        return studentDao.insert(student);
    }

    @Override
    public int update(Student student) {

        return studentDao.update(student);
    }

    @Override
    public int delete(Integer id) {
        return studentDao.delete(id);
    }
}

```

### Controller层

``` java
package com.fiberhome.controller;

import com.fiberhome.domain.Student;
import com.fiberhome.service.StudentService;
import com.fiberhome.service.StudentServiceImpl;
import org.junit.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class StudentController {
    private StudentService studentService = new StudentServiceImpl();
    /**
     * 需求一：查询所有学生信息
     */
    @Test
    public void findAll() throws Exception {

        ArrayList<Student> students = studentService.findAll();
        for(Student stu : students){
            System.out.println(stu);
        }
    }


    /**
    * 需求二：根据id查询学习信息
    */
    @Test
    public void findById(){

        Student student = studentService.findById(3);
        System.out.println(student);
    }


    /**
     * 需求三：新增学生信息
     */
    @Test
    public void insert() throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//注意月份是MM
        Date date = simpleDateFormat.parse("1990-09-02");
        Student student = new Student(null, "洪八", 26, date);
        int insert = studentService.insert(student);
        System.out.println(insert);
    }


    /**
     * 需求四：修改学生信息
     */
    @Test
    public void update() throws ParseException {
        Student student = studentService.findById(3);
        student.setName("王五");
        student.setAge(23);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date birthday = simpleDateFormat.parse("1991-09-13");
        student.setBirthday(birthday);
        int update = studentService.update(student);
        System.out.println(update);
    }


    /**
     * 需求五：删除学生信息
     */
    @Test
    public void delete(){
        int delete = studentService.delete(6);
        System.out.println(delete);
    }

}

```









