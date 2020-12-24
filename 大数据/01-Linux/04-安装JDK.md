## Linux  安装JDK

安装之前需要在Linux上提前创建三个目录:

``` python
mkdir -p /export/software  #软件包存放目录
mkdir -p /export/server    #安装目录
mkdir -p /export/data      #数据存放目录
```



### 安装JDK
1、在虚拟机上查看是否自带有openjdk,如果有的话则卸载,没有的话直接做第二步

``` python
rpm -qa | grep openjdk
rpm -e java-1.7.0-openjdk-headless-1.7.0.221-2.6.18.1.el7.x86_64 java-1.7.0-openjdk-1.7.0.221-2.6.18.1.el7.x86_64 --nodeps
```



2、在node1机上传安装包并解压

``` python
上传jdk到node1的/export/software路径下去并解压，在这里使用rz命令上传
tar -zxvf jdk-8u241-linux-x64.tar.gz -C /export/server/
```



4、配置环境变量

``` python
vim /etc/profile

添加如下内容
export JAVA_HOME=/export/server/jdk1.8.0_241
export PATH=:$JAVA_HOME/bin:$PATH
```



5、修改完成之后记得执行source /etc/profile使配置生效

``` python
source /etc/profile
```



6、测试

``` python
测试是否安装成功:
java -version	

[root@node01 ~]# java -version
java version "1.8.0_241"
Java(TM) SE Runtime Environment (build 1.8.0_241-b07)
Java HotSpot(TM) 64-Bit Server VM (build 25.241-b07, mixed mode)
[root@node01 ~]# 

```

