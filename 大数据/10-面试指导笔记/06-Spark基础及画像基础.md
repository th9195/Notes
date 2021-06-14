#  Spark内容回顾以及画像基础

## Spark的关键技术回顾

* 面试题

* <img src="06-Spark基础及画像基础.assets/image-20200902145040924.png" alt="image-20200902145040924" style="zoom:150%;" />

* 参考画图：

* Spark的内存管理

* ![image-20210515113205376](06-Spark基础及画像基础.assets/image-20210515113205376.png)

* ![image-20210515113226835](06-Spark基础及画像基础.assets/image-20210515113226835.png)

* ![image-20210515113300205](06-Spark基础及画像基础.assets/image-20210515113300205.png)

* ![image-20210515113510872](06-Spark基础及画像基础.assets/image-20210515113510872.png)

* ![image-20210515113645847](06-Spark基础及画像基础.assets/image-20210515113645847.png)

* 根据一道面试题突出的部分

* 面试中问到，Spark的shuffle机制如何理解？

* <img src="06-Spark基础及画像基础.assets/image-20210515114954333.png" alt="image-20210515114954333" style="zoom:150%;" />

* Shuffle机制原理？

* ShuffleWriter分为几类？

* <img src="06-Spark基础及画像基础.assets/image-20210515115919742.png" alt="image-20210515115919742" style="zoom:150%;" />

* 作业：根据视频学习Shuffle的源码讲解及Spark源码讲解--在面试中可以讲解

* SparkSQL

* ![image-20200902154315486](06-Spark基础及画像基础.assets/image-20200902154315486.png)

* <img src="06-Spark基础及画像基础.assets/image-20210515161022123.png" alt="image-20210515161022123" style="zoom:150%;" />

* ![image-20210515162232828](06-Spark基础及画像基础.assets/image-20210515162232828.png)

  <img src="images/image-20210518140834769.png" alt="image-20210518140834769" style="zoom:150%;" />

<img src="images/image-20210518141216834.png" alt="image-20210518141216834" style="zoom: 150%;" />





* **SparkStreaming**

* <img src="06-Spark基础及画像基础.assets/image-20200902155728158.png" alt="image-20200902155728158" style="zoom:150%;" />

* <img src="06-Spark基础及画像基础.assets/image-20200902155813035.png" alt="image-20200902155813035" style="zoom:150%;" />

* **SparkStreaming反压**：

* <img src="06-Spark基础及画像基础.assets/image-20200902160325178.png" alt="image-20200902160325178" style="zoom:150%;" />

* <img src="06-Spark基础及画像基础.assets/image-20200902160720475.png" alt="image-20200902160720475" style="zoom:150%;" />

* 背压在SParkStreaing中自动动态的根据接收器接受最大速率和kafka的topic的分区的个数确定

* ```scala
  package cn.itcast.sparkstreaming.kafka
  
  import org.apache.kafka.clients.consumer.ConsumerRecord
  import org.apache.kafka.common.serialization.StringDeserializer
  import org.apache.spark.SparkConf
  import org.apache.spark.streaming.dstream.{DStream, InputDStream}
  import org.apache.spark.streaming.kafka010.{ConsumerStrategies, KafkaUtils, LocationStrategies}
  import org.apache.spark.streaming.{Seconds, StreamingContext}
  
  /**
   * DESC:
   * 1-导入有kafka和spark整合的Jar包
   * 2-调用streamingCOntext
   * 3-KafkaUtils.creatDriectlyStream的方法直接连接Kafka集群的分区
   * 4-获取record记录中的value的值
   * 5-根据value进行累加求和wordcount
   * 6-ssc.statrt
   * 7-ssc.awaitTermination
   * 8-ssc.stop(true,true)
   */
  object _01SparkStreamingKafkaAuto {
    def updateFunc(curentValue: Seq[Int], histouryValue: Option[Int]): Option[Int] = {
      val sum: Int = curentValue.sum + histouryValue.getOrElse(0)
      Option(sum)
    }
  
    val kafkaParams = Map[String, Object](
      "bootstrap.servers" -> "node1:9092",
      "key.deserializer" -> classOf[StringDeserializer],
      "value.deserializer" -> classOf[StringDeserializer],
      "group.id" -> "spark_group",
      //offset的偏移量自动设置为最新偏移量，有几种设置偏移量的方法
      // //这里的auto.offset.reset代表的是自动重置offset为latest就表示的是最新的偏移量，如果没有偏移从最新的位置开始
      "auto.offset.reset" -> "latest",
      //是否自动提交，这里设置为自动提交，提交到kafka指导的__consumertopic中，有kafka自己维护，如果设置为false可以使用ckeckpoint或者是将offset存入mysql
      // //这里如果是false手动提交，默认由SparkStreaming提交到checkpoint中，在这里也可以根据用户或程序员将offset偏移量提交到mysql或redis中
      "enable.auto.commit" -> (true: java.lang.Boolean),
      //自动设置提交的时间
      "auto.commit.interval.ms" -> "1000"
    )
  
  
  
    def main(args: Array[String]): Unit = {
      //1-导入有kafka和spark整合的Jar包
      //2-调用streamingCOntext
      val ssc: StreamingContext = {
        val conf: SparkConf = new SparkConf().setAppName(this.getClass.getSimpleName.stripSuffix("$")).setMaster("local[*]")
        val ssc = new StreamingContext(conf, Seconds(5))
        ssc
      }
      ssc.checkpoint("data/baseoutput/cck3")
      //3-KafkaUtils.creatDriectlyStream的方法直接连接Kafka集群的分区
      //ssc: StreamingContext,
      //locationStrategy: LocationStrategy,
      //consumerStrategy: ConsumerStrategy[K, V]
      val streamRDD: InputDStream[ConsumerRecord[String, String]] = KafkaUtils.createDirectStream[String, String](ssc,
        LocationStrategies.PreferConsistent,
        ConsumerStrategies.Subscribe[String, String](Array("spark_kafka"), kafkaParams))
      //4-获取record记录中的value的值
      val mapValue: DStream[String] = streamRDD.map(_.value())
      //5-根据value进行累加求和wordcount
      val resultRDD: DStream[(String, Int)] = mapValue
        .flatMap(_.split("\\s+"))
        .map((_, 1))
        .updateStateByKey(updateFunc)
      resultRDD.print()
      //6-ssc.statrt
      ssc.start()
      //7-ssc.awaitTermination
      ssc.awaitTermination()
      //8-ssc.stop(true,true)
      ssc.stop(true, true)
    }
  }
  ```

* 结构化流

* ```scala
  package cn.iitcast.structedstreaming.kafka
  
  import org.apache.spark.SparkConf
  import org.apache.spark.sql.streaming.{OutputMode, StreamingQuery, Trigger}
  import org.apache.spark.sql.{DataFrame, Dataset, Row, SparkSession}
  
  /**
   * DESC:
   * * 1-准备上下文环境
   * * 2-读取Kafka的数据
   * * 3-将Kafka的数据转化，实现单词统计技术
   * * 4-将得到结果写入控制台
   * * 5.query.awaitTermination
   * * 6-query.stop
   */
  object _01KafkaSourceWordcount {
    def main(args: Array[String]): Unit = {
      //1-准备上下文环境
      val conf: SparkConf = new SparkConf()
        .setAppName(this.getClass.getSimpleName.stripSuffix("$"))
        .setMaster("local[*]")
      val spark: SparkSession = SparkSession
        .builder()
        .config(conf)
        .config("spark.sql.shuffle.partitions", "4")
        .getOrCreate()
      //spark.sparkContext.setLogLevel("WARN")
      import spark.implicits._
      //2-读取Kafka的数据
      val streamDF: DataFrame = spark.readStream
        .format("kafka")
        .option("kafka.bootstrap.servers", "node1:9092")
        .option("subscribe", "wordstopic")
        .load()
      //streamDF.printSchema()
      //root
      // |-- key: binary (nullable = true)
      // |-- value: binary (nullable = true)
      // |-- topic: string (nullable = true)
      // |-- partition: integer (nullable = true)
      // |-- offset: long (nullable = true)
      // |-- timestamp: timestamp (nullable = true)
      // |-- timestampType: integer (nullable = true)
      //3-将Kafka的数据转化，实现单词统计技术
      val result: Dataset[Row] = streamDF
        .selectExpr("cast (value as string)") //因为kafka得到的数据是binary类型的数据需要使用cast转换
        .as[String]
        .flatMap(x => x.split("\\s+")) // |-- value: string (nullable = true)
        .groupBy($"value")
        .count()
        .orderBy('count.desc)
      //.groupBy("value")
      //4-将得到结果写入控制台
      val query: StreamingQuery = result
        .writeStream
        .format("console")
        .outputMode(OutputMode.Complete())
        .trigger(Trigger.ProcessingTime(0))
        .option("numRows", 10)
        .option("truncate", false)
        .start()
      //5.query.awaitTermination
      query.awaitTermination()
      //6-query.stop
      query.stop()
    }
  }
  ```

* Spark复习答案：

* 1-Spark使用的版本2.2.0(cdh5.14.0),因为CDH5.14.0中Spark默认的版本是1.6.0同时阉割了SarkSQL，需要重新编译
  2-Spark几种部署方式？Local(local[*],所有的cpu cores)，StandAlone(Master-local)，StandAloneHA(多个Master)，Yarn(RS-NM)
  3-Spark的提交任务的方式？
  bin/spark-submit  \
  --master local/spark:node01:7077/spark:node01:7077,node02:70777 \
  --deploy-mode client/cluster \  #client指的是driver启动在本地，cluster指的是driver启动在Worker接点水行
  --class application-main
  --executor-memory	 每个executor的内存，默认是1G
  --total-executor-cores	 所有executor总共的核数。仅仅在 mesos 或者 standalone 下使用
  --executor-core	 每个executor的核数。在yarn或者standalone下使用
  --driver-memory	 Driver内存，默认 1G
  --driver-cores	 Driver 的核数，默认是1。在 yarn 或者 standalone 下使用
  --num-executors	 启动的executor数量。默认为2。在 yarn 下使用
  .....
  jar包地址
  参数1 参数2
  4-使用Spark-shell的方式也可以交互式写Spark代码？
  bin/spark-shell --master local --executor-core 2 --executor-memory 512m
  5-SparkCore：
  什么是RDD？
  （1）RDD是弹性分布式数据集
  （2）RDD有五大属性：1-RDD是可分区的(0-1-2号分区) 2-RDD有作用函数(map) 3-RDD是依赖关系 4-对key-value的类型RDD的默认分区HashPartitoner 5-位置优先性
  （3）RDD的宽依赖和窄依赖：根据父RDD有一个或多个子RDD对应，因为窄依赖可以在任务间并行，宽依赖会发生Shuffle
  （3）RDD血缘关系linage：linage会记录当前rdd依赖于上一个rdd，如果一个rdd失效可以重建RDD，容错关键
  （4）RDD的缓存：cache和persist，cache会将数据缓存在内存中，persist可以指定多种存储级别，cache底层调用的是persist
  （5）RDD的检查点机制：Checkpoint会截断所有的血缘关系，而缓存会将血缘的关系全部保存在内存或磁盘中
  （6）Spark如何实现容错？Spark会首先查看内存中是否已经cache或persist当前的rdd的链条，否则查看linage是否checkpoint值hdfs中，重建rdd
  （7）Spark共享变量？
  累加器(在driver端定义的变量在executor端拿到的是副本，exector执行完计算不会更新到driver)
  广播变量(对于1M的数据，开启1000个maptask，当前的1M的数据会发送到所有的task中进行计算，会产生1G网络数据传输，引入广播变量将1M数据共享在Executor中而不是task中，me米格task共享的是一个变量的副本，广播变量是只读的，不能再exectour端修改)
  （8）Spark的任务执行?
  1-Spark一个Application拥有多个job，一个action操作会出发一个Job划分
  2-Spark一个Job有多个Stages，发生shuffle操作触发一个Stage的划分
  3-一个Stage有很多个tasksets，一个RDD的不同的分区就是代表的taskset，很多的taskset组成tasksets
  4-一个taskset由很多个RDD的分区组成，一个RDD的分区的数据需要由一个task线程拉取执行，而不是进程
  （9）Spark的rdd的几种类型？transformation和action类型
  （10）Spark的Transformation算子有几类？
  3类
  单value：如mapValue，map，filter
  双value：union，zip，distinct
  key-value类型：reduceBykey(一定不属于Action算子)，foldByKey
  （11）RDD创建的三种方法？sc.textfile,sc.makerdd/paralleise,RDD之间的转换
  
* 6-SparkSQL：
  （1）RDD-DataSet和DataFrame的区别和联系？RDD+Scheme=DataFrame.as[]+泛型=DataSet.rdd=RDD，DataFrame是弱类型的数据类型，在运行时候数据类型检查，DataSet是强类型的数据类型，在编译时候进行类型检查
  （2）SparkSQL中查询一列的字段的方法有几种？df.select(['id']),df.select(col('id')),df.select(colomns('id')),df.select('id),df.select($"")
  （3）SparkSQL中的如何动态增加Schema?StructedType(StructedFileld(data,name,nullable)::Nil),new StructedType().add(data,name,nullable).add()
  （4）SparkSQL中DSL和SQL风格差异？DSL风格df.select,SQL风格需要注册一张临时表或试图进行展示
  （5）SparkSQL中SQL风格全局Session和局部的Session的差别是什么？全局的Session可以跨Session访问注册的临时试图或表，局部Session只能访问临时试图或表
  （6）SparkSQL整合Hive：Spark引擎替代了HIve的执行引擎，可以在SPark程序中使用HIve的语法完成SQ的分析
  （7）[非常重要]SparkSQL如何执行SQL的，SQL的查询引擎
  基于规则优化（Rule-based optimization, RBO----过滤下推，常量折叠）-逻辑执行计划中，进行逻辑计划优化
  基于代价优化（Cost-based optimization, CBO）----物理执行计划中选择最优物理执行计划
  
* 7-SparkStreaming
  （1）SparkStreaming几种编程模式？有状态(updateStateByKey\mapState)、无状态(reduceByKey)、窗口操作(windows，reduceByKeyANdWIndows)
  （2）对于DStream如何使用RDD的方法?(transform)
  （2）SparkStreaming的有状态的几种形式？updateStateByKey\mapState
  （3）SparkStreaming和Kafka的整合，如何获取Offset，010整合
  
  ``` scala
  KafkaUtils.createdirctstream(SSC,Kafka的parititon和Spark的eceutor是否在一个节点，Consumer.subscribe(Array(kafkatopic),params))
  获取Offset：StreamData.asInstanceOf[HasOffSetRanges].offsetRanges
  提交Offset：StreamData.asInstanceOf[CancommitOffSetRanges].async(offSetRanges)
  #http://spark.apache.org/docs/latest/streaming-kafka-0-10-integration.html
  val kafkaParams = Map[String, Object](
    "bootstrap.servers" -> "localhost:9092,anotherhost:9092",
    "key.deserializer" -> classOf[StringDeserializer],
    "value.deserializer" -> classOf[StringDeserializer],
    "group.id" -> "use_a_separate_group_id_for_each_stream",
    "auto.offset.reset" -> "latest",
    "enable.auto.commit" -> (false: java.lang.Boolean)
  )
  
  val topics = Array("topicA", "topicB")
  val stream = KafkaUtils.createDirectStream[String, String](
    streamingContext,
    PreferConsistent,
    Subscribe[String, String](topics, kafkaParams)
  )
  stream.map(record => (record.key, record.value))
  stream.foreachRDD { rdd =>
    val offsetRanges = rdd.asInstanceOf[HasOffsetRanges].offsetRanges
    // some time later, after outputs have completed
    stream.asInstanceOf[CanCommitOffsets].commitAsync(offsetRanges)
  }
  ```
  
  （4）SparkStreaming有两个时间？
  Spark Streaming接收器接收到的数据在存储到Spark中之前的时间间隔被分成数据块。 最低建议-50毫秒。
  一个时间是接收器接受数据的时间--默认是200ms，数据到来每隔200ms获取一次数据，合并数据形成DStream
  一个时间是SParkStreaming获取到数据后处理时间--StreamingContext(sc,Second(5))，这才是SparkStreaming批处理时间
  （5）当生产者生产数据过多，消费者SparkStreaming来不及消费，请问造成什么现象？背压，或反压
  在SParkStreaming中是默认关闭，在Flink中是默认开启的，背压在SParkStreaing中自动动态的根据接收器接受最大速率和kafka的topic的分区的个数确定

## 画像部分

* 

## Flink和SparkStreaming区别和联系

* https://mp.weixin.qq.com/s/jllAegJMYh_by95FhHt0jA

* Flink的四大基石

* Flink的转换算子

* Flink的状态管理分类

* Flink的流处理特性

* Flink的状态存储

* FLink on yarn提交方式

* flink中水位线waterMarker技术

* Flink中的几种并行度的设置

* 使用Java或Scala开发批或流的wordcount

* Flink+Kafka实现流式数据处理

* 答案

* Flink
  Flink:task，Spark中taskSet
  Spark:task，Flink中对应是subtask
  JobManager学校--takManager教室--Slot固定座位100个---task任务逻辑(90个学生)-并行度
  面试题1：Slot和并行度的关系
  Slot是固定的物理概念，并行度是动态的资源的概念，可以在Application，算子层面各个方面你设置并行度
  FLink的并行度是根据任务动态指定的，与分区数是没有关系的，也就是并行度决定task的个数。并行度5分区数10,也是可以执行的
  解析：
  Slot的数量一般是固定的，可以通过配置文件去设置，一般slot的数量和cores数量是相等，
  在当前服务器部署了flink的前提下，同一个Slot在同一时间只能有一个task执行。
  这里的task相当于Spark中的taskSet，实际上flink中最小的任务单元是subtask，
  subtask数量就是由并行度paralleise决定的，而spark中task的数量由分区的数量决定的，并行度的设置有多重方式，每个application可以单独设置并行度。

  * Flink的四大基石：time，window，checkpoint ，stated
  * Flink的转换算子：map/FlatMap
  * Flink的状态管理分类:
  Flink中有两种基本类型的State
  Keyed State&Operator State
  Keyed State和Operator State，可以以两种形式存在：原始状态(raw state)托管状态(managed state)
  * Flink的流处理特性:Exactly-once/低延迟/分布式快照
  * Flink的状态存储：目前，Checkpoint持久化存储可以使用如下三种: 
   MemStateBackend
    该持久化存储主要将快照数据保存到JobManager的内存中，仅适合作为测试以及快照的数据量非常小时使用，并不推荐用作大规模商业部署。
    FsStateBackend
    该持久化存储主要将快照数据保存到文件系统中，目前支持的文件系统主要是 HDFS和本地文件。
    RocksDBStateBackend
    RocksDBStatBackend介于本地文件和HDFS之间，平时使用RocksDB的功能，将数 据持久化到本地文件中，当制作快照时，将本地数据制作成快照，并持久化到 FsStateBackend中(FsStateBackend不必用户特别指明，只需在初始化时传入HDFS 或本地路径即可
  * FLink on yarn提交方式：Session会话模式/job分离模式
  * FLink中的重启策略：默认/无重启/固定延迟/失败率....
  * Flink的四大基石的time的分类：EventTime事件时间，Ingestiontime摄入时间，ProcessingTime处理时间
  * FLink的分布式缓存和广播变量：
  广播变量：将Flink集合转为本地集合缓存到TaskManager中
  分布式缓存：将还魂的HDFS文件缓存在TaskManager中
  * flink中水位线waterMarker技术：
  WaterMarker就是额外的时间戳，WaterMarker=目前该窗口的最大的事件时间-最大允许的延迟时间或乱序时间
  当WaterMarker>=窗口结束时间段额时候出发该窗口计算。在一定程度上可以解决乱序的问题
  对于延迟特别久的数据flink中也提供了侧道输出
  * Flink中的几种并行度的设置：算子级别>env级别>client级别>配置文件级别
  * 使用Java或Scala开发批或流的wordcount
   //获取flink的执行环境
      val env = ExecutionEnvironment.getExecutionEnvironment
      //导入隐式转换
      import org.apache.flink.api.scala._
      //加载/创建初始数据
      val text = env.fromElements("i love beijing", "i love shanghai")
      //指定这些数据的转换
      val splitWords = text.flatMap(_.toLowerCase().split(" "))
      val filterWords = splitWords.filter(x=> x.nonEmpty)
      val wordAndOne = filterWords.map(x=> (x, 1))
      val groupWords = wordAndOne.groupBy(0)
      val sumWords = groupWords.sum(1)
      /**
        * 触发程序执行
        * 1: 本地输出
        *   sumWords.print()
           */
            sumWords.print()
  * Flink+Kafka实现流式数据处理
  	package cn.itcast.stream.source

  	import java.util
  	import java.util.Properties

  	import org.apache.commons.collections.map.HashedMap
  	import org.apache.flink.api.common.serialization.SimpleStringSchema
  	import org.apache.flink.streaming.api.scala.StreamExecutionEnvironment
  	import org.apache.flink.streaming.connectors.kafka.FlinkKafkaConsumer011
  	import org.apache.flink.streaming.connectors.kafka.internals.KafkaTopicPartition

  	object StreamingKafkaSourceScala {
  	  def main(args: Array[String]): Unit = {
  		val env = StreamExecutionEnvironment.getExecutionEnvironment
  		//隐式转换
  		import org.apache.flink.api.scala._

  		//指定消费者主题
  		val topic = "test"
  		
  		val props = new Properties();
  		props.setProperty("bootstrap.servers","node01:9092");
  		props.setProperty("group.id","test091601");
  		props.setProperty("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
  		props.setProperty("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
  		
  		//动态感知kafka主题分区的增加 单位毫秒
  		props.setProperty("flink.partition-discovery.interval-millis", "5000");
  		val myConsumer = new FlinkKafkaConsumer011[String](topic, new SimpleStringSchema(), props)
  		
  		/**
  		 * Map<KafkaTopicPartition, Long> Long参数指定的offset位置
  		 * KafkaTopicPartition构造函数有两个参数，第一个为topic名字，第二个为分区数
  		 * 获取offset信息，可以用过Kafka自带的kafka-consumer-groups.sh脚本获取
  		 */
  		val offsets =  new java.util.HashMap[KafkaTopicPartition, java.lang.Long]();
  		offsets.put(new KafkaTopicPartition(topic, 0), 11111111l);
  		offsets.put(new KafkaTopicPartition(topic, 1), 222222l);
  		offsets.put(new KafkaTopicPartition(topic, 2), 33333333l);
  		
  		/**
  		 * Flink从topic中最初的数据开始消费
  		 */
  		myConsumer.setStartFromEarliest();
  		
  		/**
  		 * Flink从topic中指定的时间点开始消费，指定时间点之前的数据忽略
  		 */
  		myConsumer.setStartFromTimestamp(1559801580000l);
  		
  		/**
  		 * Flink从topic中指定的offset开始，这个比较复杂，需要手动指定offset
  		 */
  		myConsumer.setStartFromSpecificOffsets(offsets);
  		
  		/**
  		 * Flink从topic中最新的数据开始消费
  		 */
  		myConsumer.setStartFromLatest();
  		
  		/**
  		 * Flink从topic中指定的group上次消费的位置开始消费，所以必须配置group.id参数
  		 */
  		myConsumer.setStartFromGroupOffsets();
  		
  		//添加消费源
  		val text = env.addSource(myConsumer)
  		
  		text.print()
  		env.execute("StreamingFromCollectionScala")
  		  }
  		}
  	
  * ![image-20200902171124571](06-Spark基础及画像基础.assets/image-20200902171124571.png)

## 总结

* #FLink和SparkStreaming对比：https://mp.weixin.qq.com/s/jllAegJMYh_by95FhHt0jA
  #FLink架构和Spark架构
  Flink采取的主从式架构，Flink启动程序后输出的是StreamGraph，优化成JobGraah，JobManager根据JobGraph生成ExecutionGraph，ExecutorGraph才是Flink真正执行graph
  #FLink的容错：
  Flink的checkpoint两阶段提交
  Flink checkpointing 开始时便进入到 pre-commit 阶段。具体来说，一旦 checkpoint 开始，Flink 的 JobManager 向输入流中写入一个 checkpoint barrier ，将流中所有消息分割成属于本次 checkpoint 的消息以及属于下次 checkpoint 的，barrier 也会在操作算子间流转。对于每个 operator 来说，该 barrier 会触发 operator 状态后端为该 operator 状态打快照。data source 保存了 Kafka 的 offset，之后把 checkpoint barrier 传递到后续的 operator。
  Flink如何保障Execatly-once，根据barrier以及barrier align对其机制完成FLink的一致性语义
  SparkStreaming除非在一个事务中提交或携带Offset提交才能够摆正一致性语义
  #背压机制：
  Spark Streaming 跟 kafka 结合是存在背压机制的，目标是根据当前 job 的处理情况来调节后续批次的获取 kafka 消息的条数。为了达到这个目的，Spark Streaming 在原有的架构上加入了一个 RateController，利用的算法是 PID
  Flink 的背压与 Spark Streaming 的背压不同的是，Flink 背压是 jobmanager 针对每一个 task 每 50ms 触发 100 次 Thread.getStackTrace() 调用，求出阻塞的占比。
  阻塞占比在 web 上划分了三个等级：
  OK: 0 <= Ratio <= 0.10，表示状态良好；
  LOW: 0.10 < Ratio <= 0.5，表示有待观察；
  HIGH: 0.5 < Ratio <= 1，表示要处理了。

## 建议

* 此次两天课程主要还是帮助大家回忆
  * Hive开始遗忘
  * Spark遗忘
  * Flink记得一点点
  * Hbase+Kafka
* 克服遗忘：
  * 重点知识重点复习
  * 可以做一个xmind和回顾和复习
  * 符合记忆曲线，每个一天看一次，可以稍微记忆一下
* 复习的节奏就是根据
  * 以项目驱动的方式进行复习即可