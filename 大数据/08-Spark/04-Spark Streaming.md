# 1- Spark Streaming概述

​		在传统的数据处理过程中，我们往往先将**数据存入数据库**中，当需要的时候再去数据库中进行检索查询，将处理的结果返回给请求的用户；另外，MapReduce 这类大数据处理框架，更多应用在离线计算场景中。而对于一些实时性要求较高的场景，我们期望延迟在秒甚至毫秒级别，就需要引出一种新的数据计算结构——**流式计算**，对**无边界的数据进行连续不断的处理、聚合和分析**。



## 1-1 新概率

**实时计算: 对流数据进行实时的计算, 在很短的时间内得到想要的结果**

**流数据: 数据源源不断的到来 不知何时结束, 只知道数据不断的涌进来.**

 

**实时计算 == 流式计算**



## 1-2 Streaming 应用场景

- **电商实时大屏**

![image-20210415094054111](images/image-20210415094054111.png)

- **商品推荐**

![image-20210415094045482](images/image-20210415094045482.png)

- **工业大数据**

![image-20210415094036543](images/image-20210415094036543.png)

- **集群监控**

![image-20210415094123442](images/image-20210415094123442.png)



## 1-3 Streaming 计算模式

前置概念:

``` properties
离线计算/批处理计算: 一批有界数据放在那里, 等着你一次性处理掉

流式计算/实时计算: 源源不断的无界数据实时处理

有界数据: 被处理的数据有明确的开始和明确的结束

无界数据: 被处理的数据有明确的开始,没有明确的结束(无界数据也一般称之为流数据)
```



​		流式处理任务是大数据处理中很重要的一个分支，关于流式计算的框架也有很多，如比较出名的Storm流式处理框架，是由Nathan Marz等人于 2010 年最先开发，之后将Storm开源，成为 Apache 的顶级项目，Trident 对Storm进行了一个更高层次的抽象；另外由LinkedIn贡献给社区的 Samza 也是一种流处理解决方案，不过其构建严重依赖于另一个开源项目 Kafka。

​		Spark Streaming 构建在Spark的基础之上的实时流处理框架，随着Spark的发展，Spark Streaming和Structured Streaming也受到了越来越多的关注。



## 1-4 流式计算模式

- 不同的流式处理框架有不同的特点，也适应不同的场景，主要有如下两种模式。

### 1-4-1 模式一：原生流处理（Native）

所有输入记录会**一条接一条地被处理**，上面提到的 **Storm 和 Flink** 都是采用这种方式；

绝对一次一条的模式

![img](images/wps1-1618451293241.jpg) 

### 1-4-2 模式二：微批处理（Batch）

​		将输入的数据以某一时间间隔 T，切分成多个微批量数据，然后对每个批量数据进行处理，**Spark Streaming 和StructuredStreaming 采用的是这种方式**；

​		也就是Spark本质上是一个 批处理框架, 但是可以将批做的很小来实现类似流处理的效果.比如间隔是1秒,就一秒钟处理一个批次

![img](images/wps2-1618451293242.jpg) 

 



## 1-4 Spark Streaming计算思想

​		Spark Streaming是Spark生态系统当中一个重要的框架，它建立在Spark Core之上，下图也可以看出Sparking Streaming在Spark生态系统中地位。

![img](images/wps3-1618451493559.jpg) 

官方定义Spark Streaming模块：

![img](images/wps4-1618451493559.jpg) 

**SparkStreaming是一个基于SparkCore之上的实时计算框架，可以从很多数据源消费数据并对数据进行实时的处理，具有高吞吐量和容错能力强等特点**。

![img](images/wps5-1618451493559.jpg) 

​		对于Spark Streaming来说，将流式数据封装的数据结构：**DStream（Discretized Stream，离散化数据流，连续不断的数据流）**，代表持续性的数据流和经过各种Spark算子操作后的结果数据流，其实就是**将流式数据按照时间间隔BatchInterval划分为很多Batch批次**，针对每个Batch批次数据当做RDD进行快速分析和处理。

SparkStreaming模块对流式数据处理，介于Batch批处理和RealTime实时处理之间处理数据方式。

![img](images/wps6-1618451493559.jpg) 



# 2- SparkStreaming数据抽象-DStream



## 2-1 DStream 是什么

​		Spark Streaming的核心是**DStream**，DStream类似于RDD，它实质上**一系列的RDD的集合，DStream可以按照秒、分等时间间隔将数据流进行批量的划分**。

​		如下图所示：<span style="color:red;background:white;font-size:20px;font-family:楷体;">**将流式数据按照【X seconds】划分很多批次Batch，每个Batch数据封装到RDD中进行处理分析，最后每批次数据进行输出。**</span>

![image-20210415100331735](images/image-20210415100331735.png)



​		对于目前版本的Spark Streaming而言，其最小的Batch Size的选取在0.5~5秒钟之间，所以Spark Streaming能够满足流式准实时计算场景，**对实时性要求非常高的如高频实时交易场景则不太适合**。

- **DStream代表了一种连续的数据流**，要么从某种数据源提取数据，要么从其他数据流映射转换而来。

- **DStream内部是由一系列连续的RDD组成的**，每个RDD都包含了特定时间间隔内的一批数据，

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**DStream：在时间线上的一组RDD集合**</span>

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**DStream：是不间断的 连续的数据对象(内容是无边界的)**</span>

  

  如下图所示：

![image-20210415100412049](images/image-20210415100412049.png)



- DStream本质上是一个：
  - <span style="color:red;background:white;font-size:20px;font-family:楷体;">**一系列时间上连续的RDD（Seq[RDD]），DStream = Seq[RDD]**</span>。

``` properties
DStream = Seq[RDD]
DStream相当于一个序列（集合），里面存储的数据类型为RDD（Streaming按照时间间隔划分流式数据）
```



- 对DStream的数据进行操作也是按照RDD为单位进行的。

![image-20210415100456840](images/image-20210415100456840.png)



​		通过WEB UI界面可知，对DStream调用函数操作，底层就是对RDD进行操作，发现很多时候DStream中函数与RDD中函数一样的。

![img](images/wps7-1618452308377.jpg) 



​		DStream中每批次数据RDD在处理时，各个RDD之间存在依赖关系，DStream直接也有依赖关系，RDD具有容错性，那么DStream也具有容错性。

![img](images/wps8.png) 

上图相关说明：

- 1）、每一个椭圆形表示一个RDD
- 2）、椭圆形中的每个圆形代表一个RDD中的一个Partition分区
- 3）、每一列的多个RDD表示一个DStream(图中有三列所以有三个DStream)
- 4）、每一行最后一个RDD则表示每一个Batch Size所产生的中间结果RDD



​		Spark Streaming将流式计算分解成多个Spark Job，对于每一时间段数据的处理都会经过Spark DAG图分解以及Spark的任务集的调度过程。





## 2-2 DStream Operations 算子

- DStream#Output Operations：将DStream中每批次RDD处理结果resultRDD输出

- DStream类似RDD，里面包含很多函数，进行数据处理和输出操作，主要分为两大类：
  - Transformation
  - output(action)(流水线开关)

### 2-2-1 Transformation

- 大多数和RDD中的类似，有一些特殊的针对特定类型应用使用的函数，比如:

  - updateStateByKey状态函数、

  - window窗口函数等

    

参考文档：[http://spark.apache.org/docs/2.4.5/streaming-programming-guide.html#transformations-on-dstreams](#transformations-on-dstreams)

 

![img](images/wps9-1618452856533.jpg) 

| **Transformation**                                           | **Meaning**                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| map(func)                                                    | 对DStream中的各个元素进行func函数操作，然后返回一个新的DStream |
| flatMap(func)                                                | 与map方法类似，只不过各个输入项可以被输出为零个或多个输出项  |
| filter(func)                                                 | 过滤出所有函数func返回值为true的DStream元素并返回一个新的DStream |
| union(otherStream)                                           | 将源DStream和输入参数为otherDStream的元素合并，并返回一个新的DStream. |
| reduceByKey(func, [numTasks])                                | 利用func函数对源DStream中的key进行聚合操作，然后返回新的(K，V)对构成的DStream |
| join(otherStream, [numTasks])                                | 输入为(K,V)、(K,W)类型的DStream，返回一个新的(K，(V，W)类型的DStream |
| <span style="color:red;background:white;font-size:20px;font-family:楷体;">**transform(func)**</span> | 通过RDD-to-RDD函数作用于DStream中的各个RDD，可以是任意的操作，从而返回一个新的RDD |



### 2-2-2 output(action)(流水线开关)

参考文档:[http://spark.apache.org/docs/2.4.5/streaming-programming-guide.html#output-operations-on-dstreams](#output-operations-on-dstreams)

![image-20210415101608418](images/image-20210415101608418.png)

| Output Operation                                             | Meaning                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <span style="color:red;background:white;font-size:20px;font-family:楷体;">**print()**</span> | 打印到控制台                                                 |
| saveAsTextFiles(prefix, [suffix])                            | 保存流的内容为文本文件，文件名为"prefix-TIME_IN_MS[.suffix]". |
| saveAsObjectFiles(prefix,[suffix])                           | 保存流的内容为SequenceFile，文件名为 "prefix-TIME_IN_MS[.suffix]". |
| saveAsHadoopFiles(prefix,[suffix])                           | 保存流的内容为hadoop文件，文件名为"prefix-TIME_IN_MS[.suffix]". |
| <span style="color:red;background:white;font-size:20px;font-family:楷体;">**foreachRDD(func)**</span> | 对Dstream里面的每个RDD执行func                               |





# 3- SparkStreaming实战

## 3-1 案例1-WordCount

### 3-1-1 需求

从TCP Socket数据源实时消费数据，对每批次Batch数据进行词频统计WordCount，流程图如下：

![image-20210415101705664](images/image-20210415101705664.png)

### 3-1-2 nc 工具

- 1.在node01上安装nc命令

``` shell
# nc是netcat的简称，原本是用来设置路由器,我们可以利用它向某个端口发送数据
yum install -y nc
```



- 2.在node01启动客户端工具发送消息

 ``` shell
[root@node1 sbin]# nc -lk 9999
 ```



### 3-1-2 代码演示

从官方文档可知，提供两种方式构建**StreamingContext**实例对象，如下：

- 第一种方式：构建SparkConf对象

  ​		![img](images/wps10-1618453173393.jpg) 



- 第二种方式：构建SparkContext对象

![img](images/wps11-1618453173394.jpg)

- 完整代码

``` scala
package cn.itcast.streaming

import org.apache.commons.lang3.StringUtils
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.streaming.dstream.{DStream, ReceiverInputDStream}
import org.apache.spark.streaming.{Seconds, StreamingContext}

/**
 * 基于IDEA集成开发环境，编程实现从TCP Socket实时读取流式数据，对每批次中数据进行词频统计。
 */
object SparkStreamingDemo01_WordCount {
  def main(args: Array[String]): Unit = {
    val conf: SparkConf = new SparkConf()
      .setAppName(this.getClass.getSimpleName.stripSuffix("$"))
      .setMaster("local[*]")
      
    val sc: SparkContext = new SparkContext(conf)
      
    sc.setLogLevel("WARN")
    //batchDuration the time interval at which streaming data will be divided into batches
    //流数据将被划分为批的时间间隔,就是每隔多久对流数据进行一次微批划分!
    val ssc: StreamingContext = new StreamingContext(sc, Duration(10000L))

    val inputDStream: ReceiverInputDStream[String] = ssc.socketTextStream("node1", 9999)

    val resultDStream: DStream[(String, Int)] = inputDStream
      .filter(StringUtils.isNotBlank(_))
      .flatMap(_.trim.split("\\s+"))
      .map((_, 1))
      .reduceByKey(_ + _)

    resultDStream.print(10)

    // 启动并等待程序停止
    // 对于流式应用来说，需要启动应用
    ssc.start()
    // 流式应用启动以后，正常情况一直运行（接收数据、处理数据和输出数据），除非人为终止程序或者程序异常停止
    ssc.awaitTermination()
    // 关闭流式应用(参数一：是否关闭SparkContext，参数二：是否优雅的关闭）
    ssc.stop(stopSparkContext = true, stopGracefully = true)
    //注意:
    //上面的代码可以做WordCount,但是只能对当前批次的数据进行累加!
  }
}
```



## 3-2 案例2-有状态计算

![image-20210415104329576](images/image-20210415104329576.png)

### 3-2-1 UpdateStateByKey （饿汉式）

- 概念

  ​		统计全局的key的状态，但是就算没有数据输入，他也会在每一个批次的时候返回之前的key的状态。假设5s产生一个批次的数据，那么5s的时候就会更新一次的key的值，然后返回。

  这样的缺点就是，**如果数据量太大的话，而且我们需要checkpoint数据，这样会占用较大的存储**。

  ​		**如果要使用updateStateByKey,就需要设置一个checkpoint目录，开启checkpoint机制**。因为key的state是在内存维护的，如果宕机，则重启之后之前维护的状态就没有了，所以要长期保存它的话需要启用checkpoint，以便恢复数据。

- 代码演示

``` scala
package com.fiberhom.sparkStreaming

import org.apache.spark.sql.SparkSession
import org.apache.spark.streaming.dstream.ReceiverInputDStream
import org.apache.spark.streaming.{Duration, StreamingContext}

import javax.net.ssl.SSLSessionContext

object Demo2_UpdateStateByKey {

    def main(args: Array[String]): Unit = {

        val spark = SparkSession
            .builder()
            .appName(this.getClass.getSimpleName)
            .master("local[*]")
            .getOrCreate()
        
        val sc = spark.sparkContext;
        sc.setLogLevel("WARN")

        val ssc = new StreamingContext(sc, Duration(10000L))

        // 1- 开启ssc 的checkpoint
        ssc.checkpoint("data/ck")

        // 2- 获取socket数据
        val socketDStream: ReceiverInputDStream[String] = ssc.socketTextStream("node1", 9999)

        // 3- 定义一个函数计算历史结果累加
        val updateFunc: (Seq[Int], Option[Int]) => Option[Int] = (current:Seq[Int], old:Option[Int])=>{
            if (current.nonEmpty){ // 因为流处理， 不是每个批次都会有数据
                // 有数据： 和历史数据聚合 在返回结果
                Option(current.sum + old.getOrElse(0))
            }else{
                // 表示没有数据； （饿汉式）直接返回历史结果  这样就导致： 有没有新数据都会返回结果（印象性能）
                old
            }
        }

        val resultDStream = socketDStream
                .flatMap(_.split("\\s+"))
                .map(_ -> 1)
                // .reduceByKey(_ + _)
                .updateStateByKey(updateFunc)// 完成历史状态的更新

        resultDStream.print()

        ssc.start()
        ssc.awaitTermination()
        ssc.stop(true,true)

    }
}

```



### 3-2-2 mapWithState（懒汉式）

- 概念

  ​		也是用于全局统计key的状态，但是它如果没有数据输入，便不会返回之前的key的状态，**有一点增量的感觉**。

  ​		这样做的好处是，我们可以**只是关心那些已经发生的变化的key，对于没有数据输入，则不会返回那些没有变化的key的数据**。这样的话，即使数据量很大，checkpoint也不会像updateStateByKey那样，占用太多的存储。

- mapWithState 与 UpdateStateByKey  对比

![image-20210415104632387](images/image-20210415104632387.png)

- 代码演示

``` scala
package com.fiberhom.sparkStreaming

import org.apache.spark.streaming.dstream.ReceiverInputDStream
import org.apache.spark.streaming.{Duration, State, StateSpec, StreamingContext}
import org.apache.spark.{SparkConf, SparkContext}

object Demo3_MapWithState {

    def main(args: Array[String]): Unit = {
        val conf = new SparkConf()
                .setAppName(this.getClass.getSimpleName)
                .setMaster("local[*]")
        
        val sc = new SparkContext(conf)
        sc.setLogLevel("WARN")

        val ssc = new StreamingContext(sc, Duration(10000L))

        // 开启checkpoint
        ssc.checkpoint("data/ck")

        // 准备mapWithSate中需要的函数
        // 参数2 ： value 不是一个seq集合了， 要求我们给的数据是当前数据已经预聚合好的结果
        val mappingFunction:(String,Option[Int],State[Int]) =>(String,Int) = (key, current,state) => {
            // 通过当前value + 历史value 计算出新的value
            val newValue = state.getOption().getOrElse(0) + current.getOrElse(0)

            // 手动更新 历史state对象
            state.update(newValue)

            // 返回结果
            key -> newValue // 这个返回值要求带key
        }


        // 获取 socket 流程数据
        val socketDStream: ReceiverInputDStream[String] = ssc.socketTextStream("node1", 9999)


        // 计算
        val resultDStream = socketDStream
                .flatMap(_.split("\\s+"))
                .map(_ -> 1)
                .reduceByKey(_ + _)  // 需要做预聚合
                .mapWithState(StateSpec.function(mappingFunction).numPartitions(10))

        // 打印结果
        resultDStream.print()

        ssc.start()
        ssc.awaitTermination()
        ssc.stop(true,true)
    }

}

```



## 3-3 案例3-状态恢复-扩展

- **实现SparkStreaming程序停止之后,再启动时还能够接着上次的结果进行累加**

- 代码演示

```scala
package com.fiberhom.sparkStreaming

import org.apache.spark.streaming.dstream.{DStream, ReceiverInputDStream}
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.streaming.{Duration, State, StateSpec, StreamingContext}

/**
 * 状态恢复
 */
object Demo4_StateRecovery {

    val CKP_PATH = "data/ck2"
    def main(args: Array[String]): Unit = {


        /**
         * 状态恢复，在Streaming恢复的是StreamingContext对象
         * getOrCreate 方法可以做到：
         * 1- 如果有checkPoint保存，从checkPoint中获取StreamingContext的内容，
         * 2- 如果没有checkPoint,就构建一个新的StreamContext对象
         *
         */
        val ssc = StreamingContext.getOrCreate(CKP_PATH, creatStreamingContext)
        val sc = ssc.sparkContext
        sc.setLogLevel("WARN")

        ssc.start()
        ssc.awaitTermination()
        ssc.stop(true,true)
    }

    /**
     * 定义一个获取StreamingContext 的函数
     *
     * ssc 如果要初始化完成， 必须有ssc的后续执行逻辑， 直接返回是没有意义的。
     */
    val creatStreamingContext : () => StreamingContext = () => {
        val conf = new SparkConf().setMaster("local[*]")
                .setAppName(this.getClass.getSimpleName)
        val sc = new SparkContext(conf)
        sc.setLogLevel("WARN")
        val ssc = new StreamingContext(sc, Duration(10000L))
        ssc.checkpoint(CKP_PATH)

        val socketDStream: ReceiverInputDStream[String] = ssc.socketTextStream("node1", 9999)

        val updateFunc: (Seq[Int], Option[Int]) => Option[Int] = (current:Seq[Int], old:Option[Int]) =>{
            if (current.nonEmpty ){
                Option(current.sum + old.getOrElse(0))
            }else{
                old
            }
        }

        val mappingFunc = (key:String,current:Option[Int],state:State[Int]) =>{
            val newValue = current.getOrElse(0) + state.getOption().getOrElse(0)

            // 更新state
            state.update(newValue)

            // 返回增量数据
            key -> newValue
        }

        val resultDStream: DStream[(String, Int)] = socketDStream
                .flatMap(_.split("\\s+"))
                .map(_ -> 1)
                .updateStateByKey(updateFunc)
//                .reduceByKey(_ + _)
//                .mapWithState(StateSpec.function(mappingFunc)) // 注意： mapWithState 不支持状态恢复

        resultDStream.print()

        ssc
    }

}

```



## 3-4 案例4-窗口计算  

- 设计到的方法：

``` properties
reduceByKeyAndWindow
```



### 3-4-1 需求

使用窗口计算: 每隔5s(滑动间隔)计算最近10s(窗口长度)的数据!



- 回顾窗口:

  - 窗口长度:要计算多久的数据

  - 滑动间隔:每隔多久计算一次

    

- 总结
  - 窗口长度10s > 滑动间隔5s : 	每隔5s计算最近10s的数据--滑动窗口
  - 窗口长度10s = 滑动间隔10s :   每隔10s计算最近10s的数据--滚动窗口
  - 窗口长度10s < 滑动间隔15s :   每隔15s计算最近10s的数据--会丢失数据,开发不用

![img](images/wps12-1618481592497.jpg) 

### 3-4-2 代码实现

``` scala
package cn.itcast.streaming

import org.apache.spark.streaming.dstream.{DStream, ReceiverInputDStream}
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.{SparkConf, SparkContext}

/**
 * 使用SparkStreaming接收Socket数据,node01:9999
 * 窗口长度:要计算多久的数据
 * 滑动间隔:每隔多久计算一次
 * 窗口长度10s > 滑动间隔5s:每隔5s计算最近10s的数据--滑动窗口
 * 窗口长度10s = 滑动间隔10s:每隔10s计算最近10s的数据--滚动窗口
 * 窗口长度10s < 滑动间隔15s:每隔15s计算最近10s的数据--会丢失数据,开发不用
 * 使用窗口计算: 每隔5s(滑动间隔)计算最近10s(窗口长度)的数据!
 */
object SparkStreamingDemo04_Window {
  def main(args: Array[String]): Unit = {
    //1.创建环境
    val conf: SparkConf = new SparkConf()
      .setAppName(this.getClass.getSimpleName.stripSuffix("$"))
      .setMaster("local[*]")
      
    val sc: SparkContext = new SparkContext(conf)
    sc.setLogLevel("WARN")
      
    //batchDuration the time interval at which streaming data will be divided into batches
    //流数据将被划分为批的时间间隔,就是每隔多久对流数据进行一次微批划分!
    val ssc: StreamingContext = new StreamingContext(sc, Seconds(5))

    // The checkpoint directory has not been set. Please set it by StreamingContext.checkpoint()
    //注意:因为涉及到历史数据/历史状态,也就是需要将历史数据/状态和当前数据进行合并,作为新的Value!
    //那么新的Value要作为下一次的历史数据/历史状态,那么应该搞一个地方存起来!
    //所以需要设置一个Checkpoint目录!
    ssc.checkpoint("./ckp")

    //2.接收socket数据
    val linesDS: ReceiverInputDStream[String] = ssc.socketTextStream("node1",9999)

    //3.做WordCount
    val resultDS: DStream[(String, Int)] = linesDS
      .flatMap(_.split(" "))
      .map((_, 1))
      //windowDuration:窗口长度:计算最近多久的数据,必须都是微批间隔的整数倍
      //slideDuration :滑动间隔:就是每隔多久计算一次,,必须都是微批间隔的整数倍
      //使用窗口计算: 每隔5s(滑动间隔)计算最近10s(窗口长度)的数据!
      .reduceByKeyAndWindow((v1:Int, v2:Int)=>v1+v2, Seconds(10),Seconds(5))

    //总结:实际开发中需要学会的是如何设置windowDuration:窗口长度和slideDuration :滑动间隔
    //如进行如下需求:
    //每隔30分钟(slideDuration :滑动间隔),计算最近24小时(windowDuration:窗口长度)的各个广告点击量,应该进行如下设置:
    //.reduceByKeyAndWindow((v1:Int, v2:Int)=>v1+v2, Minutes(24*60),Minutes(30))
    //每隔10分钟(slideDuration :滑动间隔),更新最近1小时(windowDuration:窗口长度)热搜排行榜
    //.reduceByKeyAndWindow((v1:Int, v2:Int)=>v1+v2, Minutes(60),Minutes(10))

    //4.输出
    resultDS.print()

    //5.启动并等待程序停止
    ssc.start()
    ssc.awaitTermination()
    ssc.stop(stopSparkContext = true, stopGracefully = true)
  }
}
```



## 3-5 案例5-TopN-transform

### 3-5-1 需求

使用窗口计算模拟热搜排行榜:

每隔10s计算最近20s的热搜排行榜!

![img](images/wps13-1618482032846.jpg) 

- 注意：

  ​		**DStream没有直接排序的方法! 所以应该调用transform方法对DStream底层的RDD进行操作,调用RDD的排序方法!**

<span style="color:red;background:white;font-size:20px;font-family:楷体;">**transform(函数),该函数会作用到DStream底层的RDD上!**</span>



### 3-5-2 代码实现

``` scala
package cn.itcast.streaming

import org.apache.spark.rdd.RDD
import org.apache.spark.streaming.dstream.{DStream, ReceiverInputDStream}
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.{SparkConf, SparkContext}

/**
 * 使用SparkStreaming接收Socket数据,node01:9999
 * 使用窗口计算模拟热搜排行榜:
 * 每隔10s计算最近20s的热搜排行榜!
 */
object SparkStreamingDemo05_TopN {
  def main(args: Array[String]): Unit = {
    //1.创建环境
    val conf: SparkConf = new SparkConf()
      .setAppName(this.getClass.getSimpleName.stripSuffix("$"))
      .setMaster("local[*]")
      
    val sc: SparkContext = new SparkContext(conf)
    sc.setLogLevel("WARN")
      
    val ssc: StreamingContext = new StreamingContext(sc, Seconds(5))
    ssc.checkpoint("./ckp")

    //2.接收socket数据
    val linesDS: ReceiverInputDStream[String] = ssc.socketTextStream("node1",9999)

    //3.做WordCount
    val wordAndCountDS: DStream[(String, Int)] = linesDS
      .flatMap(_.split(" "))
      .map((_, 1))
      //windowDuration:窗口长度:就算最近多久的数据,必须都是微批间隔的整数倍
      //slideDuration :滑动间隔:就是每隔多久计算一次,,必须都是微批间隔的整数倍
      //每隔10s(slideDuration :滑动间隔)计算最近20s(windowDuration:窗口长度)的热搜排行榜!
      .reduceByKeyAndWindow((v1:Int, v2:Int)=>v1+v2, Seconds(20),Seconds(10))

    //排序取TopN
    //注意:DStream没有直接排序的方法!所以应该调用DStream底层的RDD的排序方法!
    //transform(函数),该函数会作用到DStream底层的RDD上!
    val resultDS: DStream[(String, Int)] = wordAndCountDS.transform(rdd => {
      val sortedRDD: RDD[(String, Int)] = rdd.sortBy(_._2, false)
      val top3: Array[(String, Int)] = sortedRDD.take(3) //取出当前RDD中排好序的前3个热搜词!
      println("======top3--start======")
      top3.foreach(println)
      println("======top3--end======")
      sortedRDD
    })

    //4.输出
    resultDS.print()

    //5.启动并等待程序停止
    ssc.start()
    ssc.awaitTermination()
    ssc.stop(stopSparkContext = true, stopGracefully = true)
  }
}
```





## 3-6 案例6-自定义输出-foreachRDD

### 3-6-1 需求

对上述案例的结果数据输出到控制台外的其他组件,如MySQL/HDFS

注意:

​		**foreachRDD函数属于将DStream中结果数据RDD输出的操作，类似transform函数，针对每批次RDD数据操作，但无返回值**

- 总结

``` properties
写出数据使用foreachRDD
总结：
map :		 	处理每一行数据并返回
mapPartition :	处理每个分区 数据并返回
tranform: 		处理DStream中 每个RDD的数据并返回

foreach :  			处理每行数据无返回
foreachPartition: 	处理每个分区数据无返回
foreachRDD : 		处理DStream中 每个RDD 数据无返回
```



- DStream.print方法源码底层调用的也是foreachRDD：

![img](images/wps14-1618482131667.jpg) 



### 3-6-2 代码实现

```scala
package cn.itcast.streaming

import java.sql.{Connection, DriverManager, PreparedStatement, Timestamp}

import org.apache.commons.lang3.time.FastDateFormat
import org.apache.spark.rdd.RDD
import org.apache.spark.streaming.dstream.{DStream, ReceiverInputDStream}
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.{SparkConf, SparkContext}

/**
 * 使用SparkStreaming接收Socket数据,node01:9999
 * 对上述案例的结果数据输出到控制台外的其他组件,如MySQL/HDFS
 */
object SparkStreamingDemo06_Output {
  def main(args: Array[String]): Unit = {
    //1.创建环境
    val conf: SparkConf = new SparkConf().setAppName(this.getClass.getSimpleName.stripSuffix("$")).setMaster("local[*]")
      //设置数据输出文件系统的算法版本为2
      //https://blog.csdn.net/u013332124/article/details/92001346
      .set("spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version", "2")
    val sc: SparkContext = new SparkContext(conf)
    sc.setLogLevel("WARN")
    val ssc: StreamingContext = new StreamingContext(sc, Seconds(5))
    ssc.checkpoint("./ckp")

    //2.接收socket数据
    val linesDS: ReceiverInputDStream[String] = ssc.socketTextStream("node1",9999)

    //3.做WordCount
    val wordAndCountDS: DStream[(String, Int)] = linesDS
      .flatMap(_.split(" "))
      .map((_, 1))
      //windowDuration:窗口长度:就算最近多久的数据,必须都是微批间隔的整数倍
      //slideDuration :滑动间隔:就是每隔多久计算一次,,必须都是微批间隔的整数倍
      //每隔10s(slideDuration :滑动间隔)计算最近20s(windowDuration:窗口长度)的热搜排行榜!
      .reduceByKeyAndWindow((v1:Int, v2:Int)=>v1+v2, Seconds(20),Seconds(10))

    //排序取TopN
    //注意:DStream没有直接排序的方法!所以应该调用DStream底层的RDD的排序方法!
    //transform(函数),该函数会作用到DStream底层的RDD上!
    val resultDS: DStream[(String, Int)] = wordAndCountDS.transform(rdd => {
      val sortedRDD: RDD[(String, Int)] = rdd.sortBy(_._2, false)
      val top3: Array[(String, Int)] = sortedRDD.take(3) //取出当前RDD中排好序的前3个热搜词!
      println("======top3--start======")
      top3.foreach(println)
      println("======top3--end======")
      sortedRDD
    })

    //4.输出
    resultDS.print()

    resultDS.foreachRDD((rdd,time)=>{
      val df: FastDateFormat = FastDateFormat.getInstance("yyyy-MM-dd HH:mm:ss")
      val batchTime: String = df.format(time.milliseconds)
      println("-------自定义的输出-------")
      println(s"batchTime:${batchTime}")
      println("-------自定义的输出-------")
      if(!rdd.isEmpty()){
        //-1.输出到控制台
        rdd.foreach(println)
        //-2.输出到HDFS
        rdd.coalesce(1).saveAsTextFile(s"hdfs://node1:8020/wordcount/output-${time.milliseconds}")
        //-3.输出到MySQL
        /*
        CREATE TABLE `t_hotwords` (
        `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        `word` varchar(255) NOT NULL,
        `count` int(11) DEFAULT NULL,
        PRIMARY KEY (`time`,`word`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
         */
        rdd.foreachPartition(iter=>{
          val conn: Connection = DriverManager
            .getConnection("jdbc:mysql://localhost:3306/bigdata?characterEncoding=UTF-8","root","root")
          val sql:String = 
            "REPLACE INTO `t_hotwords` (`time`, `word`, `count`) VALUES (?, ?, ?);"
            
          val ps: PreparedStatement = conn.prepareStatement(sql)//获取预编译语句对象
          iter.foreach(t=>{
            val word: String = t._1
            val count: Int = t._2
            ps.setTimestamp(1,new Timestamp(time.milliseconds) )
            ps.setString(2,word)
            ps.setInt(3,count)
            ps.addBatch()
          })
          ps.executeBatch()
          ps.close()
          conn.close()
        })
      }
    })

    //5.启动并等待程序停止
    ssc.start()
    ssc.awaitTermination()
    ssc.stop(stopSparkContext = true, stopGracefully = true)
  }
}
```





# 4- Spark Streaming整合Kafka

​		在实际项目中，无论使用Storm还是SparkStreaming与Flink，主要**从Kafka实时消费数据**进行处理分析，流式数据实时处理技术架构大致如下：

![img](images/wps15-1618485615743.jpg) 

技术栈：<span style="color:red;background:white;font-size:20px;font-family:楷体;">**Flume/SDK/Kafka Producer API  -> KafKa  —>  SparkStreaming/Flink/Storm（Hadoop YARN） -> Redis  -> UI**</span>

``` properties
1）、阿里工具Canal：监控MySQL数据库binlog文件，将数据同步发送到Kafka Topic中
	https://github.com/alibaba/canal
	https://github.com/alibaba/canal/wiki/QuickStart
	
2）、Maxwell：实时读取MySQL二进制日志binlog，并生成 JSON 格式的消息，作为生产者发送给 Kafka，Kinesis、RabbitMQ、Redis、Google Cloud Pub/Sub、文件或其它平台的应用程序。
	http://maxwells-daemon.io/
	https://github.com/zendesk/maxwell
```

- 扩展：Kafka 相关常见面试题：

``` properties
1）、Kafka 集群大小（规模），Topic分区函数名及集群配置？
2）、Topic中数据如何管理？数据删除策略是什么？
3）、如何消费Kafka数据？
4）、发送数据Kafka Topic中时，如何保证数据发送成功？
```

Apache Kafka： 最原始功能【消息队列】，缓冲数据，具有**发布订阅**功能（类似微信公众号）。



## 4-1 Kafka快速回顾

​		Kafka 是一个分布式的基于发布/订阅模式的消息队列（Message Queue），主要应用与大数据实时处理领域。

- **消息队列**：Kafka 本质上是一个 MQ（Message Queue），使用消息队列的好处？（面试会问）：
  - 解耦：允许我们独立的扩展或修改队列两边的处理过程；

  - 可恢复性：即使一个处理消息的进程挂掉，加入队列中的消息仍可以在系统恢复后被处理；

  - 缓冲：有助于解决生产消息和消费消息的处理速度不一致的情况；

  - 灵活性&峰值处理能力：不会因为突发的超负荷的请求而完全崩溃，消息队列能够使关键组件顶住突发的访问压力；

  - 异步通信：消息队列允许用户把消息放入队列但不立即处理它；

    

- **发布/订阅模式**：

![img](images/wps16-1618485814946.jpg) 

​		一对多，生产者将消息发布到 Topic 中，有多个消费者订阅该主题，发布到 Topic 的消息会被所有订阅者消费，被消费的数据不会立即从 Topic 清除。

Kafka 框架架构图如下所示：

![img](images/wps17-1618485814946.jpg) 

​		Kafka 存储的消息来自任意多被称为 Producer 生产者的进程，数据从而可以被发布到不同的 Topic 主题下的不同 Partition 分区。在一个分区内，这些消息被索引并连同时间戳存储在一起。其它被称为 Consumer 消费者的进程可以从分区订阅消息。Kafka 运行在一个由一台或多台服务器组成的集群上，并且分区可以跨集群结点分布。Kafka 一些重要概念：

- 1）、**Producer**： 消息生产者，向 Kafka Broker 发消息的客户端；

  

- 2）、**Consumer**：消息消费者，从 Kafka Broker 取消息的客户端；

  

- 3）、**Consumer Group**：消费者组（CG），消费者组内每个消费者负责消费不同分区的数据，提高消费能力。一个分区只能由组内一个消费者消费，消费者组之间互不影响。所有的消费者都属于某个消费者组，即消费者组是逻辑上的一个订阅者；

  

- 4）、**Broker**：一台 Kafka 机器就是一个 Broker。一个集群由多个 Broker 组成。一个 Broker 可以容纳多个 Topic；

  

- 5）、**Topic**：可以理解为一个队列，Topic 将消息分类，生产者和消费者面向的是同一个 Topic；



- 6）、**Partition**：为了实现扩展性，提高并发能力，一个非常大的 Topic 可以分布到多个 Broker （即服务器）上，一个 Topic 可以分为多个 Partition，每个 Partition 是一个 有序的队列；



- 7）、**Replica**：副本，为实现备份的功能，保证集群中的某个节点发生故障时，该节点上的 Partition 数据不丢失，且 Kafka 仍然能够继续工作，Kafka 提供了副本机制，一个 Topic 的每个分区都有若干个副本，一个 Leader 和若干个 Follower；



- 8）、**Leader**：每个分区多个副本的“主”副本，生产者发送数据的对象，以及消费者消费数据的对象，都是 Leader；



- 9）、**Follower**：每个分区多个副本的“从”副本，实时从 Leader 中同步数据，保持和 Leader 数据的同步。Leader 发生故障时，某个 Follower 还会成为新的 Leader；

 

- 10）、**Offset**：消费者消费的位置信息，监控数据消费到什么位置，当消费者挂掉再重新恢复的时候，可以从消费位置继续消费；



- 11）、**Zookeeper**：Kafka 集群能够正常工作，需要依赖于 Zookeeper，Zookeeper 帮助 Kafka 存储和管理集群信息；

 

常用命令

- #启动kafka

/export/server/kafka/bin/kafka-server-start.sh -daemon /export/server/kafka/config/server.properties 

 

- #停止kafka

/export/server/kafka/bin/kafka-server-stop.sh 

 

- \#查看topic信息

/export/server/kafka/bin/kafka-topics.sh --list --zookeeper node1:2181

 

- \#创建topic

/export/server/kafka/bin/kafka-topics.sh --create --zookeeper node1:2181 --replication-factor 1 --partitions 3 --topic test

 

- \#查看某个topic信息

/export/server/kafka/bin/kafka-topics.sh --describe --zookeeper node1:2181 --topic streaming-kafka

 

 

- \#删除topic

/export/server/kafka/bin/kafka-topics.sh --zookeeper node1:2181 --delete --topic test

 

**启动生产者--控制台的生产者  (一般用于测试)**

<span style="color:red;background:white;font-size:20px;font-family:楷体;">**/export/server/kafka/bin/kafka-console-producer.sh --broker-list node1:9092 --topic streaming-kafka**</span>



- \# 启动消费者--控制台的消费者

/export/server/kafka/bin/kafka-console-consumer.sh --bootstrap-server node1:9092 --topic spark_kafka --from-beginning 

 

## 4-2 整合说明

### 4-2-1两种方式

#### 4-2-1-1 Receiver-based Approach（过时）

- 1.KafkaUtils.createDstream基于接收器方式，消费Kafka数据，已淘汰，企业中不再使用；

- 2.Receiver作为常驻的Task运行在Executor等待数据，但是一个Receiver效率低，需要开启多个，再手动合并数据(union)，再进行处理，很麻烦；

- 3.Receiver那台机器挂了，可能会丢失数据，所以需要开启WAL(预写日志)保证数据安全，那么效率又会降低；

- 4.Receiver方式是通过zookeeper来连接kafka队列，调用Kafka高阶API，offset存储在zookeeper，由Receiver维护；

- 5.Spark在消费的时候为了保证数据不丢也会在Checkpoint中存一份offset，可能会出现数据不一致；

#### 4-2-1-2 Direct Approach (No Receivers)(常用)



- 1.KafkaUtils.createDirectStream直连方式，Streaming中每批次的每个job直接调用Simple Consumer API获取对应Topic数据，此种方式使用最多，面试时被问的最多；

- 2.Direct方式是直接连接kafka分区来获取数据，从每个分区直接读取数据大大提高并行能力

- 3.Direct方式调用Kafka低阶API(底层API)，offset自己存储和维护，默认由Spark维护在checkpoint中，消除了与zk不一致的情况	；

- 4.当然也可以自己手动维护，把offset存在MySQL/Redis中；

 

![img](images/wps1-1618626376711.jpg) 

 

### 4-2-2 两个版本API



- Spark Streaming与Kafka集成，有两套API，原因在于Kafka Consumer API有两套，

- 文档：http://spark.apache.org/docs/2.4.5/streaming-kafka-integration.html

- **Kafka 0.8.x版本-早已淘汰**
  - 底层使用老的KafkaAPI:Old Kafka Consumer API
  - 支持Receiver(已淘汰)和Direct模式：

- **Kafka 0.10.x版本-开发中使用**
  - 底层使用新的KafkaAPI: New Kafka Consumer API
  - 只支持Direct模式



![image-20210417103104938](images/image-20210417103104938.png)

## 4-3 整合Kafka

### 4-3-1 Receiver模式

略......



### 4-3-2 Direct模式

#### 4-3-2-1 原理

http://spark.apache.org/docs/latest/streaming-kafka-0-10-integration.html#obtaining-offsets

添加相关Maven依赖：

``` xml
<dependency>
    <groupId>org.apache.spark</groupId>
    <artifactId>spark-streaming-kafka-0-10_2.11</artifactId>
    <version>${spark.version}</version>
</dependency>
```



 

 







# 5- 扩展阅读



## 5-2状态计算

计算分为 **有状态**  和  **无状态**两种

 

- **无状态计算**： 
  - 数据无需依赖其它数据，一条数据单独过来即可完成计算
  - 比如，CPU温度超过100度就报警。 这个计算单条就可以判断 是典型的无状态计算。

 

- **有状态计算**： 
  - 数据依赖其它数据才能完成计算。 单条数据单独无法计算。
  - 比如，CPU温度超过100度，并且连续5条数据均是温度上升的趋势，才进行报警。这样一条数据无法计算完成，需要找到前面的5条数据一起判断才可以。这就是有状态计算。

 

- 我们在Spark中使用的多数场景都是有状态的。
  - 比如典型的窗口计算，就是有状态的计算。
  - 以及聚合的场景，分组的场景等都是有状态的。
  - 同时CheckPoint恢复的状态就是有状态计算中需求的外部数据。