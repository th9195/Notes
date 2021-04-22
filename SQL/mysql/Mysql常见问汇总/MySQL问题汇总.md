## 1- UTC 时区问题

- 报错信息如下：
  - 在idea 发生连接错误

``` properties
The server time zone value ‘�й���׼ʱ��’ is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the serverTimezone configuration
```

![image-20210412222914925](images/image-20210412222914925.png)

``` properties
net start/stop mysql  # 必须使用管理员权限打开CMD
show variables like '%time_zone%';
SELECT @@GLOBAL.time_zone, @@SESSION.time_zone;
set global time_zone="+8:00"；
```





