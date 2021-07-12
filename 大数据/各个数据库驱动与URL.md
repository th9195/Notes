# 各个数据库的驱动与URL

- \- [**MySQL**: MySQL Connector Jar]()

``` properties
驱动：org.gjt.mm.mysql.Driver
URL：jdbc:mysql://<machine_name><:port>/dbname
注：machine_name：数据库所在的机器的位置（ip地址）；
port：端口号，默认3306
```



- \- [**Oracle**: Oracle自己的驱动jar]()

``` properties
驱动：oracle.jdbc.driver.OracleDriver
URL：jdbc:oracle:thin:@<machine_name><:port>:dbname
注：machine_name：数据库所在的机器的位置（ip地址）；
port：端口号，默认是1521
```



- \- **Hive**: 也有自己的Hive JDBC jar

``` properties
hivedriverClassName=org.apache.hive.jdbc.HiveDriver
hiveurl=jdbc:hive2://node1:10000/default
```



- \- **Impala**: 也一样, 有自己的Impala JDBC jar

``` properties
- com.cloudera.impala.jdbc41.Driver
- jdbc:impala://node2.itcast.cn:21050
```



- apache **Druid**

``` properties
- driver：org.apache.calcite.avatica.remote.Driver
- url: jdbc:avatica:remote:url=http://node01:8888/druid/v2/sql/avatica/ 
```



- clickHouse

``` properties
driver:  ru.yandex.clickhouse.ClickHouseDriver
url:  jdbc:clickhouse://node2.itcast.cn:8123/default
```

