# sse-ftp-source.conf配置文件

``` properties

client.sources = ftp
client.sinks = s1
client.channels = ch1

#source
#自定义source接口类  注意： 跟自己定义的全类名保持一致
client.sources.ftp.type = cn.itcast.sse.SseQuotSource
#FTP连接参数
#主机名
client.sources.ftp.host = node01
#端口
client.sources.ftp.port = 21
#用户名
client.sources.ftp.userName = ftptest
#密码
client.sources.ftp.password = ftptest
#文件路径   FTP服务器上哪个目录？
client.sources.ftp.ftpDirectory = /home/ftptest
#文件名
client.sources.ftp.fileName = sse.txt

#本地文件路径  :下载到本地的那个路径中
client.sources.ftp.localDirectory = /export/servers/tmp/socket/local/
client.sources.ftp.delay = 1000

#线程池参数
#核心连接数
client.sources.ftp.corePoolSize = 50
#最大连接数
client.sources.ftp.maxPoolSize = 100
#线程生存时间
client.sources.ftp.keepAliveTime = 600
#阻塞队列大小
client.sources.ftp.capacity = 1000
client.sources.ftp.channels = ch1
#channels save to memory
#channel采用内存模式
client.channels.ch1.type = memory
client.channels.ch1.capacity = 1000
client.channels.ch1.transactionCapacity = 100

#channels save to file
#channel采用文件模式
#client.channels.ch1.type = file
#client.channels.ch1.capacity = 1000000
#client.channels.ch1.write-timeout = 1
#client.channels.ch1.transactionCapacity = 612000
#client.channels.ch1.maxFileSize = 2146435071
#client.channels.ch1.minimumRequiredSpace = 524288000
#client.channels.ch1.dataDirs = /tmp/dataDirs
#client.channels.ch1.checkpointDir = /tmp/checkpoint

#sinks
client.sinks.s1.channel = ch1
#写入kafka的类型
client.sinks.s1.type = org.apache.flume.sink.kafka.KafkaSink
#kafka topic
client.sinks.s1.kafka.topic = sse
client.sinks.s1.kafka.bootstrap.servers = node01:9092
client.sinks.s1.kafka.flumeBatchSize = 50
#ack机制
client.sinks.s1.kafka.producer.acks = 1

```

