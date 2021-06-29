```shell
> use mysql;
> # <= 5.7 版本
> update user set authentication_string=password("你的密码") where user='root';
> # >= 5.7 版本
> update user set password=password('你的密码') where user='root'; #(有password字段的版本,版本>5.7的)
> update user set plugin="mysql_native_password"; 
> flush privileges;
> exit;
```

