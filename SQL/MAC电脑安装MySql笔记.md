# MAC–安装mysql



​	由于学习，需要安装mysql，但是Mac作为极少数人使用的工具（相对于pc），找些软件并安装令人烦躁。切作备份及分享。不过mysql对于Mac还是很友好的。会安装的同学下拉，直接找到Navicat Premiun（破解版，汉语）。





------

## 安装mysql（本文使用8.0，即当前最新。）： 

### 下载软件： 

选择 ：MySQL Community Server（第一个，社区下载） 
进入下载：macOS 10.13 (x86, 64-bit), DMG Archive 
[软件下载地址：](https://dev.mysql.com/downloads/)https://dev.mysql.com/downloads/ 
![这里写图片描述](https://img-blog.csdn.net/20180801000510373?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

依照下图点击直接下载；也可以登陆下载（建议没有账号的同学还是注册个吧，毕竟以后还会经常用到的。） 
![这里写图片描述](https://img-blog.csdn.net/20180801000614774?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

想偷懒的同学这里直接有百度云 
[百度云直达链接：](https://pan.baidu.com/s/1lqbH06hRZyQnO2IvQ1eByQ) https://pan.baidu.com/s/1IwL8-rks8fFklxbDflsCqA  密码: k6nt



### 安装软件： 

打开下载的镜像。直接下一步下一步就OK，没有技术含量。值得一提的是，在8.0可以自己设置密码（以前的是系统默认给出密码）。 在安装完成后到Configurration输入密码即可。这是你登录mysql的密码，请记好。 
![这里写图片描述](https://img-blog.csdn.net/20180801001234913?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
安装完成。mysql在系统设置中可以看到 
![这里写图片描述](https://img-blog.csdn.net/20180801001321453?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
![这里写图片描述](https://img-blog.csdn.net/20180801001349723?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

------

配置mysql： 
打开终端：打开聚焦搜索即可。 输入`cd /usr/local/mysql/bin`，然后ls查看目录。 
![这里写图片描述](https://img-blog.csdn.net/20180801001500409?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
然后输入`vim ~/.bash_profile` 在显示的文件里加入`PATH=$PATH:/usr/local/mysql/bin`(按o，光标移动到下一行进行编写；：wq保存退出，不会可以百度vim即可。) 
![这里写图片描述](https://img-blog.csdn.net/20180801001621521?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
最后输入：`source ~/.bash_profile` 使用 `mysql -u root -p`进入mysql，输入你开始设置的密码。由于Mac系统继承于unix，输入密码不展示！！！（exit退出） 
![这里写图片描述](https://img-blog.csdn.net/20180801001744178?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
安装完成。

------

## 可视化工具 Navicat Premiun

------

Navicat Premiun安装 由于现在Navicat Premiun更新，论坛上很多破解方法不能用（即修改rpk文件的方式。现在的软件包里没有rpk文件。）感谢TNT和网友chaosgod（侵删）。


软件地址： 
链接: https://pan.baidu.com/s/1ky8I7A5rTT8Lb4s_dODBpg  密码: 5f5q
下载分为软件包和汉化补丁（新版汉语破解的我找不到，而且依照网友chaosgod的方法也很完美。） 打开下载镜像，点开右侧文件夹。运行这个镜像。然后安装。 
![这里写图片描述](https://img-blog.csdn.net/20180801090208199?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
![这里写图片描述](https://img-blog.csdn.net/20180801090230920?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
![这里写图片描述](https://img-blog.csdn.net/20180801090245401?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70) 
安装完之后：复制中文包”zh-Hans.lproj”放到 /Contents/Resources 即可。（应用程序右键显示包内容）

------

到这里就安装完成了。 

Navicat Premiun配置 在安装完成后，我遇到了一个问题，在Navicat Premiun新建链接时报错： 

<u>**2059 - Authentication plugin ‘caching_sha2_password’ cannot be loaded: dlopen(../Frameworks/caching_sha2_password.so, 2): image not found**</u> 

原因未知；



**解决方法：** 
在系统设置打开mysql，进入重设密码，改个密码（还是要记住！）。选择use legacy ….。点击OK。这时mysql会关闭，要重新打开，然后再去新建链接就好。 
![这里写图片描述](https://img-blog.csdn.net/20180801090459560?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

------

OK，安装完成，上个图 ! 
![这里写图片描述](https://img-blog.csdn.net/20180801090539758?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2pvcl9pdnk=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)





### 登录：

1. 输入命令： mysql -u root -p
2. 输入密码： 12345678
3. 如图

 ```java
(base) tanghuideMacBook-Pro:~ tanghui$ mysql -u root -p
Enter password: 12345678
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.21 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.


 ```















