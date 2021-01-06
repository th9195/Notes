## jdbc 案例



### 数据准备

- 数据库

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

- 实体类

``` java
package com.fiberhome.domain;

import java.util.Date;

public class Student {

    private Integer id;
    private String name;
    private  Integer age;
    private Date birthday;

    public Student(Integer id) {

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

### 



