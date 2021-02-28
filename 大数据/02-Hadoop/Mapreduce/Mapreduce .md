# MapReduce

## MapReduce的输入和输出

- MapReduce框架运转在<key,value>**键值对**上，也就是说，框架把作业的输入看成是一组<key,value>键值对，同样也产生一组<key,value>键值对作为作业的输出，这两组键值对可能是不同的。

- 一个MapReduce作业的输入和输出类型如下图所示：可以看出在整个标准的流程中，会有三组<key,value>键值对类型的存在。

  

![MapReduce的输入和输出](.\image\MapReduce的输入和输出.png)



## MapReduce分区

### 分区概述

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**分区就是分文件**</span>

- 在 MapReduce 中, 通过我们指定分区, 会将同一个分区的数据发送到同一个Reduce当中进行处理。例如: 为了数据的统计, 可以把一批类似的数据发送到同一个 Reduce 当中, 在同一个 Reduce 当中统计相同类型的数据, 就可以实现类似的数据分区和统计等

- 其实就是相同类型的数据, 有共性的数据, 送到一起去处理, 在Reduce过程中，可以根据实际需求（比如按某个维度进行归档，类似于数据库的分组），把Map完的数据Reduce到不同的文件中。<span style="color:red;background:white;font-size:20px;font-family:楷体;">**分区的设置需要与ReduceTaskNum配合使用**</span>。比如想要得到5个分区的数据结果。那么就得设置5个ReduceTask。

#### 自定义Partitioner

- 主要的逻辑就在这里, 这也是这个案例的意义, 通过 Partitioner 将数据分发给不同的 Reducer

``` java
/**
 * 这里的输入类型与我们map阶段的输出类型相同  K2  V2
 */
public class MyPartitioner extends Partitioner<Text,NullWritable>{
    /**
     * 返回值表示我们的数据要去到哪个分区
     * 返回值只是一个分区的标记，标记所有相同的数据去到指定的分区
     */
    @Override
    public int getPartition(Text text, NullWritable nullWritable, int i) {
        String result = text.toString().split("\t")[5];
        if (Integer.parseInt(result) > 15){
            return 1;
        }else{
            return 0;
        }
    }
}
```

#### 主类中设置分区类和ReduceTask个数

- job.setPartitionerClass(MyPartitioner.class);

- job.setNumReduceTasks(2);

```java
public class PartitionerRunner {
    public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
        //1、创建建一个job任务对象
        Configuration configuration = new Configuration();
        Job job = Job.getInstance(configuration, "mypartitioner");

        //2、指定job所在的jar包
        job.setJarByClass(PartitionerRunner.class);

        //3、指定源文件的读取方式类和源文件的读取路径
        job.setInputFormatClass(TextInputFormat.class); //按照行读取
        TextInputFormat.addInputPath(job, new Path("hdfs://node1:8020/input/partitioner")); //只需要指定源文件所在的目录即可
        // TextInputFormat.addInputPath(job, new Path("file:///E:\\input\\partitioner")); //只需要指定源文件所在的目录即可

        //4、指定自定义的Mapper类和K2、V2类型
        job.setMapperClass(PartitionerMapper.class); //指定Mapper类
        job.setMapOutputKeyClass(Text.class); //K2类型
        job.setMapOutputValueClass(NullWritable.class);//V2类型

        //5、指定自定义分区类（如果有的话）
        job.setPartitionerClass(MyPartitioner.class);
        //6、指定自定义分组类（如果有的话）
        //7、指定自定义的Reducer类和K3、V3的数据类型
        job.setReducerClass(PartitionerReducer.class); //指定Reducer类
        job.setOutputKeyClass(Text.class); //K3类型
        job.setOutputValueClass(NullWritable.class);  //V3类型


        //设置Reduce的个数
        job.setNumReduceTasks(2);

        //8、指定输出方式类和结果输出路径
        job.setOutputFormatClass(TextOutputFormat.class);
        TextOutputFormat.setOutputPath(job, new  Path("hdfs://node1:8020/output/partitioner")); //目标目录不能存在，否则报错
        //TextOutputFormat.setOutputPath(job, new  Path("file:///E:\\output\\partitoner")); //目标目录不能存在，否则报错

        //9、将job提交到yarn集群
        boolean bl = job.waitForCompletion(true); //true表示可以看到任务的执行进度

        //10.退出执行进程
        System.exit(bl?0:1);
    }
}
```







## MapReduce排序

1. 定义实体类（Bean）需要实现WritableComparable接口
2. 重新compareTo方法；
3. 重新实现序列化write方法；
4. 重新实现反序列readFields方法；

- 注意： <span style="color:red;background:white;font-size:20px;font-family:楷体;">**write 和 readFields 方法中的顺序要保持一致**</span>；
- 案例

```java
public class SortBean implements WritableComparable<SortBean>{

  private String word;
  private int  num;

  public String getWord() {
	  return word;
  }

  public void setWord(String word) {
	  this.word = word;
  }

  public int getNum() {
	  return num;
  }

  public void setNum(int num) {
	  this.num = num;
  }

  @Override
  public String toString() {
	  return   word + "\t"+ num ;
  }

  //实现比较器，指定排序的规则
  /*
	规则:
	  第一列(word)按照字典顺序进行排列    //  aac   aad
	  第一列相同的时候, 第二列(num)按照升序进行排列
   */
  /*
	  a  1
	  a  5
	  b  3
	  b  8
   */
  @Override
  public int compareTo(SortBean sortBean) {
	  //先对第一列排序: Word排序
	  int result = this.word.compareTo(sortBean.word);
	  //如果第一列相同，则按照第二列进行排序
	  if(result == 0){
		  return  this.num - sortBean.num;
	  }
	  return result;
  }

  //实现序列化
  @Override
  public void write(DataOutput out) throws IOException {
	  out.writeUTF(word);
	  out.writeInt(num);
  }

  //实现反序列
  @Override
  public void readFields(DataInput in) throws IOException {
		  this.word = in.readUTF();
		  this.num = in.readInt();
  }
}
```



## MapReduce局部聚合Combiner

#### 概念

​		每一个 map 都可能会产生大量的本地输出，Combiner 的作用就是对 map 端的输出先做一次合并，以减少在 map 和 reduce 节点之间的数据传输量，以提高网络IO 性能，是 MapReduce 的一种优化手段之一

- combiner 是 MR 程序中 Mapper 和 Reducer 之外的一种组件

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**combiner 组件的父类就是 Reducer**</span>

- combiner 和 reducer 的区别在于运行的位置
  - <span style="color:blue;background:white;font-size:20px;font-family:楷体;">**Combiner 是在每一个 maptask 所在的节点运行**</span>
  - <span style="color:blue;background:white;font-size:20px;font-family:楷体;">**Reducer 是接收全局所有 Mapper 的输出结果**</span>

- <span style="color:red;background:white;font-size:20px;font-family:楷体;">**combiner 的意义就是对每一个 maptask 的输出进行局部汇总，以减小网络传输量**</span>



#### 实现步骤

1- 自定义一个 combiner 继承 Reducer，重写 reduce 方法

``` java
public class MyCombiner extends Reducer<Text,LongWritable,Text,LongWritable> {


    /*
       key : hello
       values: <1,1,1,1>
     */
    @Override
    protected void reduce(Text key, Iterable<LongWritable> values, Context context) throws IOException, InterruptedException {
        long count = 0;
        //1:遍历集合，将集合中的数字相加，得到 V3
        for (LongWritable value : values) {
            count += value.get();
        }
        //2:将K3和V3写入上下文中
        context.write(key, new LongWritable(count));
    }
}
```

2- 在 job 中设置 job.setCombinerClass(CustomCombiner.class)

``` java
job.setCombinerClass(MyCombiner.class);
```



## MapReduce分组

#### 概念

​		GroupingComparator是mapreduce当中reduce端的一个功能组件，主要的作用是决定哪些数据作为一组，调用一次reduce的逻辑，默认是每个不同的key，作为多个不同的组，每个组调用一次reduce逻辑，我们可以自定义GroupingComparator实现不同的key作为同一个组，调用一次reduce逻辑

#### 第一步：定义OrderBean

注意：<span style="color:red;background:white;font-size:20px;font-family:楷体;">**根据什么字段分组就必须先将该字段相同的数据先放到一起，再根据另外一个字段排序**</span>

``` java
public class OrderBean implements WritableComparable<OrderBean> {
    private String orderId;
    private Double price;
    @Override
    public int compareTo(OrderBean o) {
        
        /**
        先将所有orderId相同的放在一起； 
        再根据price排序；
        **/
        
        //比较订单id的排序顺序
        int i = this.orderId.compareTo(o.orderId);
        if(i==0){ 
          //如果订单id相同，则比较金额，金额大的排在前面
           i = - this.price.compareTo(o.price);
        }
        return i;
    }
    @Override
    public void write(DataOutput out) throws IOException {
            out.writeUTF(orderId);
            out.writeDouble(price);
    }
    @Override
    public void readFields(DataInput in) throws IOException {
        this.orderId =  in.readUTF();
        this.price = in.readDouble();
    }
    public OrderBean() {
    }
    public OrderBean(String orderId, Double price) {
        this.orderId = orderId;
        this.price = price;
    }
    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    public Double getPrice() {
        return price;
    }
    public void setPrice(Double price) {
        this.price = price;
    }
    @Override
    public String toString() {
        return  orderId +"\t"+price;
    }
}
```

#### 第二步：自定义groupingComparator

- 继承WriteableComparator
-  调用父类的有参构造
-  指定分组的规则(重写方法)

``` java
/*

  1: 继承WriteableComparator
  2: 调用父类的有参构造
  3: 指定分组的规则(重写方法)
 */

import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.io.WritableComparator;

// 1: 继承WriteableComparator
public class OrderGroupComparator extends WritableComparator {
    // 2: 调用父类的有参构造
    public OrderGroupComparator() {
        super(OrderBean.class,true);
    }

    //3: 指定分组的规则(重写方法)
    @Override
    public int compare(WritableComparable a, WritableComparable b) {
        //3.1 对形参做强制类型转换
        OrderBean first = (OrderBean)a;
        OrderBean second = (OrderBean)b;

        //3.2 指定分组规则
        return first.getOrderId().compareTo(second.getOrderId());
    }
}
```

#### 第三步：在Job 中设置自定义的分组类

​		指定自定义分组类（如果有的话）
​        job.setGroupingComparatorClass(GroupingComparator.class);

``` java
public class GroupingRunner {
    public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
        //1、创建建一个job任务对象
        Configuration configuration = new Configuration();
        Job job = Job.getInstance(configuration, "grouping_demo");

        //2、指定job所在的jar包
        job.setJarByClass(GroupingRunner.class);

        //3、指定源文件的读取方式类和源文件的读取路径
        job.setInputFormatClass(TextInputFormat.class); //按照行读取
        //TextInputFormat.addInputPath(job, new Path("hdfs://node1:8020/input/wordcount")); //只需要指定源文件所在的目录即可
        TextInputFormat.addInputPath(job, new Path("file:///E:\\input\\grouping_demo")); //只需要指定源文件所在的目录即可

        //4、指定自定义的Mapper类和K2、V2类型
        job.setMapperClass(GroupingMapper.class); //指定Mapper类
        job.setMapOutputKeyClass(OrderBean.class); //K2类型
        job.setMapOutputValueClass(Text.class);//V2类型

        //5、指定自定义分区类（如果有的话）
        job.setPartitionerClass(MyPartitioner.class);
        //6、指定自定义分组类（如果有的话）
        job.setGroupingComparatorClass(GroupingComparator.class);
        //7、指定自定义Combiner类(如果有的话)
        //job.setCombinerClass(MyCombiner.class);


        //设置ReduceTask个数
        job.setNumReduceTasks(3);

        //8、指定自定义的Reducer类和K3、V3的数据类型
        job.setReducerClass(GroupingReducer.class); //指定Reducer类
        job.setOutputKeyClass(Text.class); //K3类型
        job.setOutputValueClass(NullWritable.class);  //V3类型

        //9、指定输出方式类和结果输出路径
        job.setOutputFormatClass(TextOutputFormat.class);
        //TextOutputFormat.setOutputPath(job, new  Path("hdfs://node1:8020/output/wordcount")); //目标目录不能存在，否则报错
        TextOutputFormat.setOutputPath(job, new  Path("file:///E:\\output\\grouping_demo")); //目标目录不能存在，否则报错

        //10、将job提交到yarn集群
        boolean bl = job.waitForCompletion(true); //true表示可以看到任务的执行进度

        //11.退出执行进程
        System.exit(bl?0:1);
    }
}

```



## MapReduce的运行过程



### 注意事项：

- maptask的个数是根据splits 切片对应的，并不是block的个数，只不过默认splits = block;

- 环形缓冲区；

- 有3次排序

  - 分区后有一次**快速排序**
  - 局部聚合Combiner后有一次**归并排序**
  - 最后整个有一次**归并排序**

- 一共有五次落盘

  - 在map-shuffle阶段分区后有个小文件需要落盘；

  - 排序打标签后需要落盘；

  - 在reduce-shuffle阶段环形缓冲区益出的小文件需要落盘；

  - 分组后的中间文件需要落盘；

  - 最后结果文件需要落盘；

    

![MapReduce的运行过程](.\image\MapReduce的运行过程.bmp)

