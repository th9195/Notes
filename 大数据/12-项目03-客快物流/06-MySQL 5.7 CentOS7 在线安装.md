```shell
# 安装Mysql yum库
rpm -Uvh http://repo.mysql.com//mysql57-community-release-el7-7.noarch.rpm

# yum安装Mysql server
yum -y install mysql-community-server

# yum安装Mysql client
yum -y install mysql-community-client

# 启动Mysql设置开机启动
systemctl start mysqld
systemctl enable mysqld

# 检查Mysql服务状态
systemctl status mysqld

# 第一次启动mysql，会在日志文件中生成root用户的一个随机密码，使用下面命令查看该密码
grep 'temporary password' /var/log/mysqld.log

# 修改root用户密码
mysql -u root -p -h localhost
Enter password:
 
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'Root!@#$';

# 如果你想设置简单密码，需要降低Mysql的密码安全级别
set global validate_password_policy=LOW; # 密码安全级别低
set global validate_password_length=4;	 # 密码长度最低4位即可

# 然后就可以用简单密码了（课程中使用简单密码，为了方便，生产中不要这样）
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';

/usr/bin/mysqladmin -u root password 'root'

grant all privileges on *.* to root@"%" identified by 'root' with grant option;  
flush privileges;
```





























