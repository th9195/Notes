



## Linux 系统中切换SVN 账号

### 1.临时更换

​	在命bai令下强制加上du --username 和--password选项，例如：svn up --username zhangsan --password 123456



### 2.永久更换
​	删除目录zhi ~/.subversion/auth/ 下的所有文件。dao下一次操作svn时会提示你重新输入用户名和密码的。换成你想用的就可以了。然后系统默认会记录下来的。

​		