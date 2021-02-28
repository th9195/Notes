# 1- ZooKeeper Watcher（监听机制）

​		ZooKeeper提供了分布式数据发布/订阅功能，一个典型的发布/订阅模型系统定义了一种一对多的订阅关系，能让多个订阅者同时监听某一个主题对象，当这个主题对象自身状态变化时，会通知所有订阅者，使他们能够做出相应的处理。

​		ZooKeeper中，引入了Watcher机制来实现这种分布式的通知功能。ZooKeeper允许客户端向服务端注册一个Watcher监听，当服务端的一些事件触发了这个Watcher，那么就会向指定客户端发送一个事件通知来实现分布式的通知功能。

​		**触发事件种类很多，如：节点创建，节点删除，节点改变，子节点改变等**。



总的来说可以概括Watcher为以下三个过程：

- 客户端向服务端注册Watcher；

- 服务端事件发生触发Watcher；

- 客户端回调Watcher得到触发事件情况；





# 2- Watch机制特点

## 2-1 一次性触发  

​		事件发生触发监听，一个watcher event就会被发送到设置监听的客户端，这种效果是一次性的，后续再次发生同样的事件，不会再次触发。





## 2-2 事件封装

​	ZooKeeper使用WatchedEvent对象来封装服务端事件并传递。

​	WatchedEvent包含了每一个事件的三个基本属性：

​	通知状态（keeperState），事件类型（EventType）和节点路径（path）



## 2-3 event异步发送  

​		watcher的通知事件从服务端发送到客户端是异步的。



## 2-4 先注册再触发

​		Zookeeper中的watch机制，必须客户端先去服务端注册监听，这样事件发送才会触发监听，通知给客户端。



# 3- 通知状态和事件类型

​		同一个事件类型在不同的通知状态中代表的含义有所不同，下表列举了常见的通知状态和事件类型。
事件封装: Watcher 得到的事件是被封装过的, 包括三个内容 keeperState, eventType, path

| **KeeperState** | **EventType**    | **触发条件**             | **说明**                           |
| --------------- | ---------------- | ------------------------ | ---------------------------------- |
|                 | None             | 连接成功                 |                                    |
| SyncConnected   | NodeCreated      | Znode被创建              | 此时处于连接状态                   |
| SyncConnected   | NodeDeleted      | Znode被删除              | 此时处于连接状态                   |
| SyncConnected   | NodeDataChanged  | Znode数据被改变          | 此时处于连接状态                   |
| SyncConnected   | NodeChildChanged | Znode的子Znode数据被改变 | 此时处于连接状态                   |
| Disconnected    | None             | 客户端和服务端断开连接   | 此时客户端和服务器处于断开连接状态 |
| Expired         | None             | 会话超时                 | 会收到一个SessionExpiredExceptio   |
| AuthFailed      | None             | 权限验证失败             | 会收到一个AuthFailedException      |

其中**连接状态事件(type=None, path=null)不需要客户端注册**，客户端只要有需要直接处理就行了。



# 4- Shell 客户端设置watcher

- 设置节点数据变动监听：

``` sql
get  /znode名称   match
```



- 通过另一个客户端更改节点数据：



- 此时设置监听的节点收到通知：