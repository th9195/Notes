## ZooKeeper java API操作



​		这里操作Zookeeper的JavaAPI使用的是一套zookeeper客户端框架 Curator ，解决了很多Zookeeper客户端非常底层的细节开发工作 。
Curator包含了几个包：

``` shell
curator-framework：对zookeeper的底层api的一些封装
curator-recipes：封装了一些高级特性，如：Cache事件监听、选举、分布式锁、分布式计数器等
```



Maven依赖(使用curator的版本：2.12.0，对应Zookeeper的版本为：3.4.x，如果跨版本会有兼容性问题，很有可能导致节点操作失败)：

### 引入maven坐标

``` xml
<dependencies>
        <dependency>
            <groupId>org.apache.curator</groupId>
            <artifactId>curator-framework</artifactId>
            <version>2.12.0</version>
        </dependency>

        <dependency>
            <groupId>org.apache.curator</groupId>
            <artifactId>curator-recipes</artifactId>
            <version>2.12.0</version>
        </dependency>

        <dependency>
            <groupId>com.google.collections</groupId>
            <artifactId>google-collections</artifactId>
            <version>1.0</version>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>RELEASE</version>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-simple</artifactId>
            <version>1.7.25</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <!-- java编译插件 -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.2</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
        </plugins>
   </build>
```



### 创建一个节点

``` java
@Test
    public void demoCreateZnode() throws Exception {
        // 1- 创建重试策略
        /**
         * param1 : 重试时间间隔
         * param2 : 重试最大次数
         */
        ExponentialBackoffRetry retry = new ExponentialBackoffRetry(1000, 3);
        // 2- 创建客户端
        /**
         * param1 ： 要连接的Zookeeper服务器列表
         * param2 :  会话的超时时间
         * param3 :  连接超时时间
         * param4 :  重试策略
         */
        String connectionStr="node1:2181,node2:2181,node3:2181";
        CuratorFramework client = CuratorFrameworkFactory.newClient(connectionStr, 15000, 15000, retry);


        // 3- 开启客户端
        client.start();


        // 4- 节点操作
        /**
         * creatingParentsIfNeeded  // 可以递归创建节点；
         * withMode : 指定节点类型
         *      节点类型:
         * 		   CreateMode.PERSISTENT:永久节点
         * 		   CreateMode.PERSISTENT_SEQUENTIAL:永久序列化节点
         * 		   CreateMode.EPHEMERAL:临时节点
         * 		   CreateMode.EPHEMERAL_SEQUENTIAL:临时序列化节点
         * forPath ： 节点名称 和 value
         */
        client.create().
                creatingParentsIfNeeded().
                withMode(CreateMode.PERSISTENT).
                forPath("/kafuka","hello my kafuka".getBytes());


        // 5- 关闭客户端
        client.close();
    }
```



### 代码分解

``` java
	private ExponentialBackoffRetry retry = null;
    private CuratorFramework client = null;
	// private String connectionStr = "192.168.88.161:2181,192.168.88.162:2181,192.168.88.163:2181";
    private String connectionStr = "node1:2181,node2:2181,node3:2181";
    
    @Before
    public void init(){
        // 1- 创建重试策略
        retry = new ExponentialBackoffRetry(8000, 3);

        // 2- 创建一个客户端
        client = CuratorFrameworkFactory.newClient(connectionStr, retry);

        // 3- 开启客户端
        client.start();
    }

    @After
    public void  after() throws InterruptedException {
        //Thread.sleep(Integer.MAX_VALUE);
        client.close();
    }

    @Test
    /**
     * 创建节点
     */
    public void createZnode() throws Exception {
        String path = client.create().
                creatingParentsIfNeeded().
                withMode(CreateMode.PERSISTENT).
                forPath("/app1/app2/app3", "app123".getBytes());
        System.out.println("path == " + path);

    }
    @Test
    /**
     * 修改节点数据
     */
    public void setZnode() throws Exception {
        Stat stat = client.setData().forPath("/kafuka", "kafuka".getBytes());
        System.out.println("stat = " + stat);
    }

    @Test
    /**
     * 删除节点
     */
    public void deleteNode() throws Exception {
        client.delete().deletingChildrenIfNeeded().forPath("/app1");
    }

```



### 修改connectionStr

// private String connectionStr = "192.168.88.161:2181,192.168.88.162:2181,192.168.88.163:2181";
    private String connectionStr = "node1:2181,node2:2181,node3:2181";

``` shell
C:\Windows\System32\drivers\etc\
在最后添加
192.168.88.161 node1  
192.168.88.162 node2  
192.168.88.163 node3 
```



### watch机制

#### 创建client并启动

``` java
	@Before
    public void init(){
        // 1- 创建重试策略
        retry = new ExponentialBackoffRetry(8000, 3);

        // 2- 创建一个客户端
        client = CuratorFrameworkFactory.newClient(connectionStr, retry);

        // 3- 开启客户端
        client.start();
    }

   
```

#### 创建监听器并开启监听

``` java
/**
     * watch 机制
     */
    @Test
    public void testWatch() throws Exception {
        // 4- 将要监听的节点树存入缓存中
        TreeCache treeCache = new TreeCache(client, "/app1");

        // 5- 自定义监听器
        treeCache.getListenable().addListener(new TreeCacheListener() {
            // 一旦发现要监控的节点有变化，则会执行该方法
            @Override
            public void childEvent(CuratorFramework curatorFramework, TreeCacheEvent treeCacheEvent) throws Exception {
                switch (treeCacheEvent.getType()){
                    case NODE_ADDED:
                        System.out.println("添加");
                        break;
                    case NODE_REMOVED:
                        System.out.println("删除");
                        break;
                    case NODE_UPDATED:
                        System.out.println("修改");
                        break;
                }

                // 获取事件中的信息
                ChildData data = treeCacheEvent.getData();
                if (data != null) {
                    String path = data.getPath();
                    System.out.println("path == " + path);
                    String value = new String(data.getData());
                    System.out.println("value == " + value);
                    Stat stat = data.getStat();
                    System.out.println("stat == " + stat);
                }
            }
        });

        // 6- 开始监听
        treeCache.start();

        // 7- 让程序挂起
        Thread.sleep(Integer.MAX_VALUE);
    }
```





#### 结束client

``` java
 @After
    public void  after() throws InterruptedException {
        //Thread.sleep(Integer.MAX_VALUE);
        client.close();
    }
```



