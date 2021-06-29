```shell
启动kafka
/export/server/kafka/bin/kafka-server-start.sh -daemon /export/server/kafka/config/server.properties 

停止kafka
/export/server/kafka/bin/kafka-server-stop.sh 

查看topic信息
/export/server/kafka/bin/kafka-topics.sh --list --zookeeper node1:2181

创建topic
/export/server/kafka/bin/kafka-topics.sh --create --zookeeper node1:2181 --replication-factor 1 --partitions 3 --topic test

查看某个topic信息
/export/server/kafka/bin/kafka-topics.sh --describe --zookeeper node1:2181 --topic test

删除topic
/export/server/kafka/bin/kafka-topics.sh --zookeeper node1:2181 --delete --topic test

启动生产者--控制台的生产者--一般用于测试
/export/server/kafka/bin/kafka-console-producer.sh --broker-list node1:9092 --topic spark_kafka

启动消费者--控制台的消费者
/export/server/kafka/bin/kafka-console-consumer.sh --bootstrap-server node1:9092 --topic spark_kafka --from-beginning 
```



