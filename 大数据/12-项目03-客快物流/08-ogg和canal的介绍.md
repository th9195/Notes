# 1- ogg和canal的简单介绍



## 1-2 概率与特点

- ogg和canal都是[**数据库实时同步的工具**]()


- 特点:
  - 能够 [**实时的同步**]() 数据库中的[**增删改**]()操作
- ogg是读取[**oracle**]()的数据库[**系统日志**]()

- canal是读取**[mysql]()**的[**binlog日志**]()




## 2-2 基本原理

注意：[数据库比如mysql\oracle都有一些系统日志, 会记录下来对它们的所有更改操作]().再**发送给kafka**；

这些日志, 除了被我们抓取过来完成数据同步, 还能完成 跨区域同步, 主从同步等等.

![image-20210622201701293](https://image-set.oss-cn-zhangjiakou.aliyuncs.com/img-out/2021/06/22/20210622201701.png)



## 2-3 对比flume

- canal 和 flume本质上是不同的.


- [**canal 只用于mysql :**]() canal被设计成 采集mysql binlog的同步工具, 是一个 `专用的` 工具；

- flume是一个[**通用的**]()采集组件, [**source可以是任意的(自定义)**](), [**sink也是自定义**]()；


- ogg是oracle公司开发的, 也是一个`通用的`工具
  - ogg的通用在于,ogg不仅仅支持oracle 也支持 如 sqlserver  和 mysql 等等常见数据库

- canal 和 ogg的**共性**: 都是[**数据库同步工具**]()

