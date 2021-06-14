# FTP安装

​		FTP 是File Transfer Protocol（文件传输协议）的英文简称，而中文简称为“文传协议”。用于Internet上的控制文件的双向传输。同时，它也是一个应用程序（Application）。基于不同的操作系统有不同的FTP应用程序，而所有这些应用程序都遵守同一种协议以传输文件。在FTP的使用当中，用户经常遇到两个概念："下载"（Download）和"上传"（Upload）。



## 1- 检查安装vsftpd软件

使用如下命令可以检测出是否安装了vsftpd软件

``` properties
rpm -qa |grep vsftpd
```



## 2- yarm源安装

如果没有则通过yarm源进行安装

``` properties
yum install -y vsftpd
```

 

## 3- 添加用户

useradd username ,默认在/home文件夹下创建一个和username一样名称的文件作为该用户所拥有的文件

```properties
useradd ftptest

passwd ftptest
```



## 4- 设置开机启动

``` properties
chkconfig vsftpd on
```



## 5- 设置配置文件 

vim /etc/vsftpd/vsftpd.conf 

``` properties
userlist_enable=YES   #启动用户列表
userlist_deny=NO     #决定是否对用户列表的用户拒绝访问ftp 
```



- 完整配置参数如下：

``` properties
配置：
anonymous_enable=YES    #设置是否允许匿名用户登录 
local_enable=YES        #设置是否允许本地用户登录 
local_root=/home        #设置本地用户的根目录 
write_enable=YES        #是否允许用户有写权限 
local_umask=022        #设置本地用户创建文件时的umask值 
anon_upload_enable=YES    #设置是否允许匿名用户上传文件 
anon_other_write_enable=YES    #设置匿名用户是否有修改的权限 
anon_world_readable_only=YES    #当为YES时，文件的其他人必须有读的权限才允许匿名用户下载，单单所有人为ftp且有读权限是无法下载的，必须其他人也有读权限，才允许下载 
download_enbale=YES    #是否允许下载 
chown_upload=YES        #设置匿名用户上传文件后修改文件的所有者 
chown_username=ftpuser    #与上面选项连用，表示修改后的所有者为ftpuser 
ascii_upload_enable=YES    #设置是否允许使用ASCII模式上传文件 
ascii_download_enable=YES    #设置是否允许用ASCII模式下载文件 

chroot_local_user=YES        #设置是否锁定本地用户在自己的主目录中（将前面#去掉！其他选项可不动）
chroot_list_enable=YES        #设置是否将用户锁定在自己的主目录中 
chroot_list_file=/etc/vsftpd/chroot_list    #定义哪些用户将会锁定在自己的主目录中 （去/etc/vsftpd/chroot_list文件增加用户名，一行一个）
userlist_enable=YES    #当为YES时表示由userlist_file文件中指定的用户才能登录ftp服务器 
userlist_file=/etc/vsftpd/user_list    #当userlist_enable为YES时才生效

```



-  开始添加目标用户，并为其设置主目录：

``` properties
useradd -d 目录 -m 目录 用户    //-d 目录 指定用户主目录，如果此目录不存在，则同时使用-m选项，可以创建主目录。

passwd 用户名   //设置密码
chmod 755 目录　　　　//以root的视角去修改当前目录的权限
chown -R ftp用户名:组名 目录　　//组名可不写，修改目录所属者
service vsftpd restart    //重启ftp
```



## 6- 设置防火墙

``` properties
vim /etc/sysconfig/iptables-config

修改
IPTABLES_MODULES="ip_conntrack_ftp"
```



## 7- 开放21端口

``` properties
vim /etc/sysconfig/iptables
添加
 -A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
重启  service vsftpd restart
 
如果此时还不能上传文件权限，关闭SELinux:
vim /etc/sysconfig/selinux ，修改为:SELINUX=disabled

```



## 8- 关闭SELinux

如果没有上传文件权限，关闭SELinux:

```properties
vi /etc/sysconfig/selinux ，修改为:SELINUX=disabled
```



## 9- 添加用户列表 

将创建的用户添加入此文件

``` properties
vim user_list 

ftptest  
```



## 10.启动服务

``` properties
cd /etc/vsftpd
service vsftpd start /restart
```

查看vsftpd 服务的运行状态

service vsftpd status



## 11- 页面访问

ftp://node01

``` properties
ftp://ftptest:ftptest@node01  
ftp://node01 #需要再输入用户名和密码
用户名:ftptest
密码  :ftptest
```


