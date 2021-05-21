- 1-Spark使用的版本

- **2.4.5**，3.1.1最新版本

  

- 2-Spark拥有哪些模块？

  - SparkCore，
  - SparkSQL，
  - SparkStreaming，
  - StructuredStreaming，
  - SparkMllib，
  - SparkGraphX

  

- 3-你对RDD是怎么理解的？

  - （1）RDD是弹性分布式数据集

  - （2）RDD有五大属性：

    - 分区，
    - 计算函数，
    - 依赖关系，
    - Key-Value类型分区器(RDD默认分区HashPartitioner),

    ``` properties
    问: wordount的时候：哪个算子会产生一个KV类型的分区器？ 
      sc.textFile().flatmap().map().reduceByKey()
    答: 	reduceByKey()
    
    问:如何查看当前算子是什么分区器？
    答:	函数rdd.partitioner
    ```

    - 位置优先性；

  ![image-20210518082329703](images/image-20210518082329703.png)

  

  - 总结：

  ``` properties
  一个Application 有多个Job;
  每个Action算子触发一个Job；
  一个Job 对应一个DAG;
  一个Job有多个Stage;
  一个Stage 有多个TaskSet;（一个RDD算子就是一个TaskSet）
  一个TaskSet 有多个Task;
  每个分区中的一个Task需要一个CpuCore;
  
  ```

  

  

  - （3）**RDD的宽依赖和窄依赖**：根据父RDD有一个或多个子RDD对应，因为窄依赖可以在任务间并行，宽依赖会发生Shuffle
    **并不是所有的bykey算子都会产生shuffle？需要注意的是（1）分区器一致（2）分区个数一致**;

    

  - （4）RDD**血缘关系linage** ： linage会记录当前rdd依赖于上一个rdd，如果一个rdd失效可以重建RDD，容错关键;

    

  - （5）RDD的缓存：cache和persist，cache会将数据缓存在内存中，persist可以指定多种存储级别，cache底层调用的是persist;

    

  - （6）RDD的检查点机制：Checkpoint会截断所有的血缘关系，而缓存会将血缘的关系全部保存在内存或磁盘中

    

  - （7）**Spark如何实现容错？**

    ``` properties
    - Spark会首先查看内存中是否已经cache或persist还原，
      否则查看linage是否checkpoint在hdfs中
      根据依赖关系重建rdd
    ```

    

- 4-Spark几种部署方式？
  - Local(local[*],所有的cpu cores)，
  - StandAlone(Master-local)，
  - StandAloneHA(多个Master)，
  - Yarn(RS-NM)

- 5-Spark的提交任务的方式？
  bin/spark-submit  \
  --master local/spark:node01:7077/spark:node01:7077,node02:70777 \
  --deploy-mode client/cluster \  #client指的是driver启动在本地，cluster指的是driver启动在Worker接点水行
  --class application-main
  --executor-memory	 **每个executor的内存，默认是1G**
  --total-executor-cores	 **所有executor总共的核数**。仅仅在 mesos 或者 standalone 下使用
  --executor-core	 每个executor的核数。在yarn或者standalone下使用
  --driver-memory	 **Driver内存，默认 1G**
  --driver-cores	 **Driver 的核数，默认是1**。在 yarn 或者 standalone 下使用
  --num-executors	 **启动的executor数量**。默认为2。在 yarn 下使用
  .....
  jar包地址
  参数1 参数2



- 6-使用Spark-shell的方式也可以交互式写Spark代码？

  ``` properties
  bin/spark-shell --master local --executor-core 2 --executor-memory 512m
  ```

  

- 7-SparkCore：

  - （1）Spark共享变量？

    ``` properties
    1- 累加器(在driver端定义的变量在executor端拿到的是副本，exector执行完计算不会更新到driver)
    
    2- 广播变量(对于1M的数据，开启1000个maptask，当前的1M的数据会发送到所有的task中进行计算，会产生1G网络数据传输，
    引入广播变量将1M数据共享在Executor中而不是task中，
    task共享的是一个变量的副本，广播变量是只读的，不能再exectour端修改)
    ```

    

  - （2）Spark的任务执行?

    ``` properties
    1-Spark一个Application拥有多个job，一个action操作会出发一个Job划分
    2-Spark一个Job有多个Stages，发生shuffle操作触发一个Stage的划分
    3-一个Stage有很多个tasksets，一个RDD的不同的分区就是代表的taskset，很多的taskset组成tasksets
    4-一个taskset由很多个RDD的分区组成，一个RDD的分区的数据需要由一个task线程拉取执行，而不是进程
    ```

    

  - （3）Spark的rdd的几种类型？

    ``` properties
    transformation和action类型
    ```

    

  - （4）Spark的Transformation算子有几类？

    ``` properties
    3类
    单value:如mapValue，map，filter
    双value:union，zip，distinct
    key-value类型:reduceBykey(一定不属于Action算子)，foldByKey
    ```

    

  - （5）RDD创建的三种方法？

    ``` properties
    1- sc.textfile;
    2- sc.makerdd;  # 底层调用的是paralleise;
    3- sc.paralleise;
    
    ```

    



8-SparkSQL：
（1）RDD-DataSet和DataFrame的区别和联系？
RDD+Scheme=DataFrame.as[]+泛型=DataSet.rdd=RDD，
DataFrame是弱类型的数据类型，在运行时候数据类型检查，
DataSet是强类型的数据类型，在编译时候进行类型检查
（2）SparkSQL中查询一列的字段的方法有几种？
df.select(['id']),
df.select(col('id')),
df.select(colomns('id')),
df.select('id),
df.select($"")
（3）SparkSQL中的如何动态增加Schema?
StructedType(StructedFileld(data,name,nullable)::Nil),
new StructedType().add(data,name,nullable).add()
（4）SparkSQL中DSL和SQL风格差异？
DSL风格df.select,SQL风格需要注册一张临时表或试图进行展示
（6）SparkSQL整合Hive？
SparkSQL除了引用Hive的元数据的信息之外，其他的Hive部分都没有耦合
Spark引擎替代了HIve的执行引擎，可以在SPark程序中使用HIve的语法完成SQ的分析
第一步：将hive-site.xml拷贝到spark安装路径conf目录
第二步：将mysql的连接驱动包拷贝到spark的jars目录下
第三步：Hive开启MetaStore服务
第四步：测试Sparksql整合Hive是否成功
IDEA远程连接远程集群
（7）[非常重要]SparkSQL如何执行SQL的，SQL的查询引擎
基于规则优化（Rule-based optimization, RBO----过滤下推，常量折叠）-逻辑执行计划中，进行逻辑计划优化
基于代价优化（Cost-based optimization, CBO）----物理执行计划中选择最优物理执行计划
7-SparkStreaming
（1）SparkStreaming几种编程模式？有状态(updateStateByKey\mapState)、无状态(reduceByKey)、窗口操作(windows，reduceByKeyANdWIndows)
（2）对于DStream如何使用RDD的方法?(transform)
（2）SparkStreaming的有状态的几种形式？updateStateByKey\mapState
（3）SparkStreaming和Kafka的整合，如何获取Offset，010整合
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
（4）SparkStreaming有两个时间？
Spark Streaming接收器接收到的数据在存储到Spark中之前的时间间隔被分成数据块。 最低建议-50毫秒。
一个时间是接收器接受数据的时间--默认是200ms，数据到来每隔200ms获取一次数据，合并数据形成DStream
一个时间是SParkStreaming获取到数据后处理时间--StreamingContext(sc,Second(5))，这才是SparkStreaming批处理时间
（5）当生产者生产数据过多，消费者SparkStreaming来不及消费，请问造成什么现象？背压，或反压
在SParkStreaming中是默认关闭，在Flink中是默认开启的，背压在SParkStreaing中自动动态的根据接收器接受最大速率和kafka的topic的分区的个数确定

# 
*Flink
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
	#FLink和SparkStreaming对比：https://mp.weixin.qq.com/s/jllAegJMYh_by95FhHt0jA
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