##  HDFS的数据读写流程



### HDFS写数据流程

1. Client 发送上传指令；
2. namenode 检查相关信息后，如果没有问题通知Client可以上传；
3. Client开始对数据切片成多个block;
4. Client 向NameNode 申请上传第一个block;
5. NameNode 根据相关策略选出最合适的n台datanode 并告知Client;
6. Client 拿到dataNode与这个dataNode 建立连接，多个datanode之间也建立连接；
7. Client 通过packet将block发送给每个datanode;
8. datanode 接收到数据并存储数据，返回ACK;
9. Client 接收到n 个ACK 后，通知namenode 更新 元数据，比如大小、时间、block信息等；
10. 重复步骤4；



![01-文件的写入流程](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\01-文件的写入流程.png)

### HDFS读数据流程

1. Client 发送下载指令；
2. namenode 检查相关权限，文件是否存在后，再获取文件所以block信息列表并告知client;
3. client拿到block列表后根据相关策略选择最合适的datanode;
4. client 创建多线程与多个datanode建立连接，并通过packet 并行下载数据；
5. client 将所有下载下来的block 合并成原始数据；





![02-文件的读取过程](E:\笔记\MyNotes\Notes\大数据\02-Hadoop\image\02-文件的读取过程.png)





