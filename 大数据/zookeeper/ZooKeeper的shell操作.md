## ZooKeeper的shell操作



### 客户端连接

``` shell
运行 zkCli.sh –server ip   进入命令行工具。
zkCli.sh  -server node1:2181
```



### shell基本操作

#### 操作命令



| 命令                           | 说明                                          | 参数                                             |
| ------------------------------ | --------------------------------------------- | ------------------------------------------------ |
| create [-s] [-e] path data acl | 创建Znode                                     | -s 指定是顺序节点<br>-e 指定是临时节点           |
| ls path [watch]                | 列出Path下所有子Znode                         |                                                  |
| get path [watch]               | 获取Path对应的Znode的数据和属性               |                                                  |
| ls2 path [watch]               | 查看Path下所有子Znode以及子Znode的属性        |                                                  |
| set path data [version]        | 更新节点                                      | version 数据版本                                 |
| delete path [version]          | 删除节点, 如果要删除的节点有子Znode则无法删除 | version 数据版本                                 |
| rmr path                       | 删除节点, 如果有子Znode则递归删除             |                                                  |
| setquota -n\|-b val path       | 修改Znode配额                                 | -n 设置子节点最大个数<br>-b 设置节点数据最大长度 |
| history                        | 列出历史记录                                  |                                                  |
|                                |                                               |                                                  |

​	

#### 操作实例

- 创建普通永久节点


``` shell
create /app1 hello
```



- 创建顺序节点

``` shell
create -s /app2 world
```



- 创建临时节点

``` shell
create -e /tempnode world
```



- 创建顺序的临时节点


``` shell
create -s -e /tempnode2 aaa
```



- 获取节点数据


  ``` shell
 get  /app1
  ```



- 修改节点数据


  ``` shell
 set /app1  hadoop
  ```



- 删除节点


  ``` shell
delete  /app1  #删除的节点不能有子节点

rmr    /app1   #递归删除
  ```

