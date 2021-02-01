# 安装Hive

## 1、解压Hive安装包并重命名

``` shell
cd /export/software
tar -zxvf apache-hive-2.1.0-bin.tar.gz  -C /export/server
cd /export/server
mv apache-hive-2.1.0-bin hive-2.1.0
```



## 2、修改hive的配置文件

- hive-env.sh  

添加我们的hadoop的环境变量

``` shell
cd  /export/server/hive-2.1.0/conf
cp hive-env.sh.template hive-env.sh
vim hive-env.sh
```

- 修改内容如下：

``` shell
HADOOP_HOME=/export/server/hadoop-2.7.5 
export HIVE_CONF_DIR=/export/server/hive-2.1.0/conf
```



## 3、修改hive-site.xml

``` shell
cd  /export/server/hive-2.1.0/conf
vim hive-site.xml
```



- 在该文件中添加以下内容

``` xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
<property>
      <name>javax.jdo.option.ConnectionUserName</name>
      <value>root</value>
  </property>
  <property>
      <name>javax.jdo.option.ConnectionPassword</name>
      <value>123456</value>
  </property>
  <property>
      <name>javax.jdo.option.ConnectionURL</name>
      <value>jdbc:mysql://node3:3306/hive?createDatabaseIfNotExist=true&amp;useSSL=false</value>
  </property>
  <property>
      <name>javax.jdo.option.ConnectionDriverName</name>
      <value>com.mysql.jdbc.Driver</value>
  </property>
  <property>
      <name>hive.metastore.schema.verification</name>
      <value>false</value>
  </property>
  <property>
    <name>datanucleus.schema.autoCreateAll</name>
    <value>true</value>
 </property>
 <property>
	<name>hive.server2.thrift.bind.host</name>
	<value>node3</value>
   </property>
</configuration>
```



## 4、上传mysql的lib驱动包

将mysql的lib驱动包上传到hive的lib目录下

``` shell
cd /export/server/hive-2.1.0/lib
```

将mysql-connector-java-5.1.41.jar 上传到这个目录下



## 5、拷贝相关jar包

将hive-2.1.0/jdbc/目录下的hive-jdbc-2.1.0-standalone.jar 拷贝到hive-2.1.0/lib/目录

``` shell
cp /export/server/hive-2.1.0/jdbc/hive-jdbc-2.1.0-standalone.jar /export/server/hive-2.1.0/lib/
```



## 6、配置hive的环境变量

**node03** 服务器执行以下命令配置hive的环境变量

``` shell
vim /etc/profile

添加以下内容:
export HIVE_HOME=/export/server/hive-2.1.0
export PATH=:$HIVE_HOME/bin:$PATH
3.3.Hive的交互方式
```



## 7、初始化元数据

``` shell
cd /export/server/hive-2.1.0/

#初始化元数据
bin/schematool -dbType mysql -initSchema

```

