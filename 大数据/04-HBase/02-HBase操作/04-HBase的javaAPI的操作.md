## hbase的javaAPI的操作

* 1) 创建maven项目: day03_HBase

* 2) 加载pom文件

  ```xml
     <repositories><!-- 代码库 -->
          <repository>
              <id>aliyun</id>
              <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
              <releases>
                  <enabled>true</enabled>
              </releases>
              <snapshots>
                  <enabled>false</enabled>
                  <updatePolicy>never</updatePolicy>
              </snapshots>
          </repository>
      </repositories>
  
  
  
      <dependencies>
          <dependency>
              <groupId>org.apache.hbase</groupId>
              <artifactId>hbase-client</artifactId>
              <version>2.1.0</version>
          </dependency>
          <dependency>
              <groupId>commons-io</groupId>
              <artifactId>commons-io</artifactId>
              <version>2.6</version>
          </dependency>
          <dependency>
              <groupId>junit</groupId>
              <artifactId>junit</artifactId>
              <version>4.12</version>
          </dependency>
          <dependency>
              <groupId>org.testng</groupId>
              <artifactId>testng</artifactId>
              <version>6.14.3</version>
          </dependency>
      </dependencies>
  
      <build>
          <plugins>
              <plugin>
                  <groupId>org.apache.maven.plugins</groupId>
                  <artifactId>maven-compiler-plugin</artifactId>
                  <version>3.1</version>
                  <configuration>
                      <target>1.8</target>
                      <source>1.8</source>
                  </configuration>
              </plugin>
          </plugins>
      </build>
  ```

* 3) 创建包: com.itheima.hbase

* 4) 创建测试类: HbaseTest

  ```java
  package com.itheima.hbase;
  
  import org.junit.Test;
  
  // 此类用于演示hbase的基本操作
  public class HBaseTest {
  
      @Test
      public void test01(){
  
          
  
      }
  }
  
  ```

### 6.1 创建表

扩展内容

```properties
当发现一个类是一个接口,如何构建其对象呢?  
	方案一: 找是否有提供好的实现类
	方案二: 找是否有工厂类能够提供构建此对象方案
	方案三: 自己实现这个接口操作(一般不采用,由于使用第三方的软件)
	
当发现一个类是一个抽象类, 如何构建其对象呢?
	方案一: 查看在此类中是否有静态的方法返回其本身
	方案二: 找是否有提供好的实现类
	方案三: 找是否有工厂类能够提供构建此对象方案
	方案四: 自己实现 (一般不采用,由于使用第三方的软件)
	
当发现一个类是一个普通类, 但是这个类构造私有:
	方案一: 查看在此类中是否有静态的方法返回其本身
	方案二: 找工厂类
	方案三: 可以尝试反射(暴力反射) --- 使用概率不大
    
```

代码实现

```java
	// 需求一: 创建表
    @Test
    public void test01() throws Exception{

        //1. 创建hbase的连接对象
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum","node1:2181,node2:2181,node3:2181");
        Connection hConn = ConnectionFactory.createConnection(conf);

        //2. 根据连接对象, 获取相关的管理对象: admin (跟表相关的操作)  Table(跟表数据相关的操作)
        Admin admin = hConn.getAdmin();
        //3. 执行相关的操作 : 创建表
        //3.1: 首先判断表是否存在
        boolean flag = admin.tableExists(TableName.valueOf("WATER_BILL")); // 存在 返回true
        if(!flag){ // 说明表不存在
            //3.2: 通过表构建器构建表信息对象 : 指定表名
            TableDescriptorBuilder tableDescriptorBuilder = TableDescriptorBuilder.newBuilder(TableName.valueOf("WATER_BILL"));
            //3.2: 在表构建表中, 添加列族
            ColumnFamilyDescriptor familyDescriptor = ColumnFamilyDescriptorBuilder.newBuilder("C1".getBytes()).build();
            tableDescriptorBuilder.setColumnFamily(familyDescriptor);
            //3.3: 构建表的信息对象
            TableDescriptor tableDescriptor = tableDescriptorBuilder.build();
            //3.4: 执行创建表
            admin.createTable(tableDescriptor);
        }

        //4. 处理结果集(查询)  -- 暂时不需要

        //5. 释放资源
        admin.close();
        hConn.close();
    }
```

### 6.2 添加数据

```java
// 需求二: 添加数据
    @Test
    public void test02() throws Exception{

        //1. 通过hbase的连接工厂构建连接对象
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum","node1:2181,node2:2181,node3:2181");
        Connection hConn = ConnectionFactory.createConnection(conf);

        //2. 根据连接对象, 获取相关的管理对象:  admin   Table
        Table table = hConn.getTable(TableName.valueOf("WATER_BILL"));

        //3. 执行相关的操作: put
        Put put = new Put("4944191".getBytes());
        put.addColumn("C1".getBytes(),"NAME".getBytes(),"登卫红".getBytes());
        put.addColumn("C1".getBytes(),"ADDRESS".getBytes(),"贵州省铜仁市德江县7号楼267室".getBytes());
        put.addColumn("C1".getBytes(),"SEX".getBytes(),"男".getBytes());
        put.addColumn("C1".getBytes(),"PAY_TIME".getBytes(),"2020-05-10".getBytes());

        table.put(put);
        //4. 处理结果集(查询): 暂不需要

        //5. 释放资源
        table.close();
        hConn.close();

    }
```

### 6.3 抽取一些公共的方法

```java
// 在@Test方法执行前 执行
    private Connection hConn;
    private Admin admin;
    private Table table;
    private String tableName = "WATER_BILL";
    @Before
    public void before() throws Exception{

        //1. 通过hbase的连接工厂构建连接对象
        Configuration conf = HBaseConfiguration.create();
        conf.set("hbase.zookeeper.quorum","node1:2181,node2:2181,node3:2181");
        hConn = ConnectionFactory.createConnection(conf);

        //2. 根据连接对象, 获取相关的管理对象:  admin   Table
        admin = hConn.getAdmin();
        table = hConn.getTable(TableName.valueOf(tableName));
    }

    @Test
    public void test03(){
        
        //3. 执行相关的操作
        
        
        //4. 处理结果集(查询)
        
        
    }

    //在 @Test方法执行后执行
    @After
    public void after() throws Exception{
        // 5. 释放资源
        table.close();
        admin.close();
        hConn.close();
    }

```

### 6.4 查询某一条数据

```java
// 需求三: 查询某一条数据: id为  4944191
    @Test
    public void test03() throws Exception{
        //1. 根据连接工厂创建连接对象: @Before
        //2. 根据连接对象, 获取管理对象: @Before
        //3. 执行相关的操作
        Get get = new Get("4944191".getBytes());
        Result result = table.get(get); // 一个 Result 对象 表示 一行数据

        //4. 处理结果集(查询)
        List<Cell> listCells = result.listCells();
        for (Cell cell : listCells) { // 从单元格中能获取到哪些内容: rowkey + 列族 + 列名 + 列值

            /*byte[] familyArray = cell.getFamilyArray();
            byte familyLength = cell.getFamilyLength();
            int familyOffset = cell.getFamilyOffset();

            String family  = new String(familyArray,familyOffset,familyLength);*/
            byte[] rowBytes = CellUtil.cloneRow(cell);
            byte[] familyBytes = CellUtil.cloneFamily(cell);
            byte[] qualifierBytes = CellUtil.cloneQualifier(cell);
            byte[] valueBytes = CellUtil.cloneValue(cell);

            String row = Bytes.toString(rowBytes);
            String family = Bytes.toString(familyBytes);
            String qualifier = Bytes.toString(qualifierBytes);
            String value = Bytes.toString(valueBytes);

            System.out.println("rowkey:"+row +";列族为:"+family +";列名为:"+qualifier+"; 列值:"+value);
        }


        //5. 释放资源: @After
    }
```

### 6.5 删除数据

```JAVA
 //需求四: 删除某一条数据
    @Test
    public void test04() throws Exception{
        //1. 根据连接工厂创建连接对象: @Before
        //2. 根据连接对象, 获取管理对象: @Before
        //3. 执行相关的操作
        Delete delete = new Delete("4944191".getBytes());
        //delete.addColumn("C1".getBytes(),"NAME".getBytes());
        delete.addFamily("C1".getBytes());
        table.delete(delete);

        //4. 处理结果集(查询)

        //5. 释放资源: @After
    }
```

### 6.6 删除表

```java
// 需求五: 删除表
    @Test
    public void test05() throws Exception{
        //1. 根据连接工厂创建连接对象: @Before
        //2. 根据连接对象, 获取管理对象: @Before
        //3. 执行相关的操作
        // boolean flag = admin.isTableDisabled(TableName.valueOf(tableName)); //如果禁用返回true
        boolean flag = admin.isTableEnabled(TableName.valueOf(tableName));
        if(flag){
            admin.disableTable(TableName.valueOf(tableName)); // 禁用表
            admin.deleteTable(TableName.valueOf(tableName));  // 删除表
        }

        //4. 处理结果集(查询)

        //5. 释放资源: @After

    }
```

### 6.7: 导入数据的操作

* 1) 将资料中: 数据集\抄表数据\part-m-00000_10w  上传linux家目录下

* 2在从linux家目录下, 将数据上传到HDFS的目录下:

  ```properties
  hdfs dfs -mkdir -p /water_bill/output_ept_10w
  hdfs dfs -put part-m-00000_10w  /water_bill/output_ept_10w
  ```

* 3) 执行导入到Hbase的操作:

  ```properties
  导入语法格式:
  	hbase org.apache.hadoop.hbase.mapreduce.Import 表名 hdfs的数据所在路径
  操作案例: 
  hbase org.apache.hadoop.hbase.mapreduce.Import WATER_BILL /water_bill/output_ept_10w/part-m-00000_10w
  
  导出语法格式: 
  	hbase org.apache.hadoop.hbase.mapreduce.Export 表名 导出hdfs的路径
  ```

### 6.8: 基于scan的扫描查询

需求:  查询 2020年 6月份所有用户的用户量: C1:RECORD_DATE

```java
//需求六: 查询 2020年 6月份所有用户的用户量: C1:RECORD_DATE
    @Test
    public void test06() throws Exception{

        //1. 根据连接工厂创建连接对象: @Before
        //2. 根据连接对象, 获取管理对象: @Before
        //3. 执行相关的操作
        Scan scan = new Scan();
        // LATEST_DATE >= 2020-06-01
        SingleColumnValueFilter start_filter = new SingleColumnValueFilter("C1".getBytes(), "LATEST_DATE".getBytes(),
                CompareOperator.GREATER_OR_EQUAL, new BinaryComparator("2020-06-01".getBytes()));
        // LATEST_DATE < 2020-07-01
        SingleColumnValueFilter end_filter = new SingleColumnValueFilter("C1".getBytes(), "LATEST_DATE".getBytes(),
                CompareOperator.LESS, new BinaryComparator("2020-07-01".getBytes()));
        // 将两个条件合并在一起
        FilterList filterList = new FilterList();
        filterList.addFilter(start_filter);
        filterList.addFilter(end_filter);
        // 将条件封装到查询中
        scan.setFilter(filterList);

        scan.setLimit(10);
        // 执行查询操作
        ResultScanner results = table.getScanner(scan);

        //4. 处理结果集(查询)
        for (Result result : results) {
            List<Cell> listCells = result.listCells();

            for (Cell cell : listCells) {

                byte[] rowBytes = CellUtil.cloneRow(cell);
                byte[] familyBytes = CellUtil.cloneFamily(cell);
                byte[] qualifierBytes = CellUtil.cloneQualifier(cell);
                byte[] valueBytes = CellUtil.cloneValue(cell);

                String row = Bytes.toString(rowBytes);
                String family = Bytes.toString(familyBytes);
                String qualifier = Bytes.toString(qualifierBytes);
                if("NUM_CURRENT".equalsIgnoreCase(qualifier) || "NUM_PREVIOUS".equalsIgnoreCase(qualifier)
                        || "NUM_USAGE".equalsIgnoreCase(qualifier) || "TOTAL_MONEY".equalsIgnoreCase(qualifier)){
                    Double value = Bytes.toDouble(valueBytes);
                    System.out.println("rowkey:"+row +";列族为:"+family +";列名为:"+qualifier+"; 列值:"+value);
                }else {
                    String value = Bytes.toString(valueBytes);
                    System.out.println("rowkey:"+row +";列族为:"+family +";列名为:"+qualifier+"; 列值:"+value);
                }


            }
            System.out.println("------------------------");

        }

        //5. 释放资源: @After

    }
```

## 