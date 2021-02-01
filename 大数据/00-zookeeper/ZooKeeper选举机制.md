## ZooKeeper选举机制



zookeeper默认的算法是 **FastLeaderElection**，采用 **投票数大于半数则胜出** 的逻辑。



### 1- 第一次启动ZK集群选出一个Leader

- 每个主机启动都会先投票给自己；
- 和其它主机进行投票交换, 但是这时会失败。因为其它node还没有起来；
- 判断投票的票数是否过半？ 
- 如果投票个数过半，则直接比较myid的值，谁的myid最大，谁就是Leader。
- 如果投票过半后，Leader已经选出来了，后面的主机启动还是会投票给自己，但是它会发现Leader已经产生了。并标记自己为follwer;

注意： 

​		**只要投票票数过半，就开始选择Leader 。 就是直接比较myid。**



![zookeeper集群启动首次选出Leader](E:\笔记\MyNotes\Notes\大数据\zookeeper\image\zookeeper集群启动首次选出Leader.png)





### 2- Leader宕机，重选Leader

- 进入选举机制
- 发出广播看有多少主机存活。存活的主机会回复ACK;  (判断存活的主机是否过半)
- 如果宕机数量过半，集群就废了。
- 每一个存活的主机都投自己一票
- 比较mZxid (修改事务ID)；谁的mZxid 最大， 数据最新， 谁就是Leader。（一般mZxid都是一样的）
- 如果mZxid都相同，则比较myid；myid最大，谁就是Leader。



