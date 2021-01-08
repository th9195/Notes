## hadoop 重新编译



### 为什么要编译hadoop

​		由于appache给出的hadoop的安装包没有提供带C程序访问的接口，所以我们在使用本地库（本地库可以用来做压缩，以及支持C程序等等）的时候就会出问题,需要对Hadoop源码包进行重新编译，请注意，资料中已经提供好了编译过的Hadoop安装包，所以这一部分的操作，大家可以不用做，了解即可。



### Hadoop编译文档

#### 0.准备linux环境

​		准备一台linux环境，内存4G或以上，硬盘40G或以上，我这里使用的是Centos7.7 64位的操作系统（注意：一定要使用64位的操作系统），需要虚拟机联网，关闭防火墙，关闭selinux，安装好JDK8。

​	

#### 1.所需要的安装包

``` shell
可以在百度网盘上下载
链接：https://pan.baidu.com/s/1NDRatebU8LCZGZDK1SmKPg 
提取码：earf 


apache-maven-3.0.5-bin.tar.gz
findbugs-1.3.9.tar.gz
hadoop-2.7.5-src.tar.gz
mvnrepository.tar.gz
protobuf-2.5.0.tar.gz
snappy-1.1.1.tar.gz

```



#### 2.安装maven

​		这里使用maven3.x以上的版本应该都可以，不建议使用太高的版本，强烈建议使用3.0.5的版本即可
将maven的安装包上传到/export/software

- 然后解压maven的安装包到/export/server

``` shell
cd /export/software/
tar -zxvf apache-maven-3.0.5-bin.tar.gz -C ../server/
```



- 配置maven的环境变量

``` shell
vim /etc/profile

填写以下内容
export MAVEN_HOME=/export/server/apache-maven-3.0.5
export MAVEN_OPTS="-Xms4096m -Xmx4096m"
export PATH=:$MAVEN_HOME/bin:$PATH
```



- 让修改立即生效

``` shell
source /etc/profile
```



- 解压maven的仓库

``` shell
tar -zxvf mvnrepository.tar.gz  -C /export/server/apache-maven-3.0.5/
```



- 修改maven的配置文件

``` shell
cd  /export/server/apache-maven-3.0.5/conf
vim settings.xml

指定我们本地仓库存放的路径

 <localRepository>/export/server/apache-maven-3.0.5/mvnrepository</localRepository>

添加一个我们阿里云的镜像地址，会让我们下载jar包更快
<mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>
</mirror>
```



#### 3.安装findbugs

- 解压findbugs

``` shell
tar -zxvf findbugs-1.3.9.tar.gz -C ../server/
```



- 配置findbugs的环境变量

``` shell
vim /etc/profile
添加以下内容:

export FINDBUGS_HOME=/export/server/findbugs-1.3.9
export PATH=:$FINDBUGS_HOME/bin:$PATH
```



- 让修改立即生效

``` shell
source  /etc/profile
```



#### 4.在线安装一些依赖包

``` shell
yum -y install autoconf automake libtool cmake
yum -y install ncurses-devel
yum -y install openssl-devel
yum -y install lzo-devel zlib-devel gcc gcc-c++
yum -y install  bzip2-devel  ## 如果报错提示ascii，不要在Xshell里面执行，需要在mvware里面执行这个命令
```



#### 5.安装protobuf

``` shell
解压protobuf并进行编译
cd  /export/software
tar -zxvf protobuf-2.5.0.tar.gz -C ../server/
cd   /export/server/protobuf-2.5.0
./configure
make && make install
```



#### 6.安装snappy

``` shell
cd /export/software/
tar -zxvf snappy-1.1.1.tar.gz  -C ../server/
cd ../server/snappy-1.1.1/
./configure
make && make install
```



#### 7.编译hadoop源码



- 对源码进行编译

``` shell
cd  /export/software
tar -zxvf hadoop-2.7.5-src.tar.gz  -C ../server/
cd  /export/server/hadoop-2.7.5
```



- 编译支持snappy压缩：

``` shell
mvn package -DskipTests -Pdist,native -Dtar -Drequire.snappy -e -X
```



- 编译完成之后我们需要的压缩包就在下面这个路径里面,生成的文件名为hadoop-2.7.5.tar.gz


``` shell
cd /export/server/hadoop-2.7.5/hadoop-dist/target
```



- 将编译后的Hadoop安装包导出即可。