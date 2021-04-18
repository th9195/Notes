

# 1- 修改字体样式

- 格式

``` html
<span style="color:red;background:black;font-size:18px;font-family:楷体;">
xxxxxxx
</span>
```

- 案例：

<span style="color:red;background:white;font-size:20px;font-family:楷体;">**你要改色的文字**</span>





# 2- 加粗

- 格式

``` html
<b>xxxxx </b>
```

- 案例

<b>加粗</b>







# 3- 流程图

## 3-1 样式一：

``` flow
st=>start: 开始框

op=>operation: 处理框

cond=>condition: 判断框(是或否?)

sub1=>subroutine: 子流程

io=>inputoutput: 输入输出框

e=>end: 结束框



st->op->cond

cond(yes)->io->e

cond(no)->sub1(right)->op
```

## 3-2 样式二

``` flow
st=>start: 开始框

op=>operation: 处理框

cond=>condition: 判断框(是或否?)

sub1=>subroutine: 子流程

io=>inputoutput: 输入输出框

e=>end: 结束框

st(right)->op(right)->cond

cond(yes)->io(bottom)->e

cond(no)->sub1(right)->op
```

# 4- UML时序图

## 4-1 样式一：

``` sequence
对象A->对象B: 对象B你好吗?（请求）

Note right of 对象B: 对象B的描述

Note left of 对象A: 对象A的描述(提示)

对象B-->对象A: 我很好(响应)

对象A->对象B: 你真的好吗？
```

``` properties
对象A->对象B: 对象B你好吗?（请求）

Note right of 对象B: 对象B的描述

Note left of 对象A: 对象A的描述(提示)

对象B-->对象A: 我很好(响应)

对象A->对象B: 你真的好吗？
```



``` sequence
#Note left of Server : Server
#Note right of Client : Client

Server-> Client:你可以连接我了！
Client --> Server : connect
Server -> Client : reject
Client -> Server :connect second times
Server --> Client : accept


```

## 4-2 样式二

``` sequence
Title: 标题：复杂使用

对象A->对象B: 对象B你好吗?（请求）

Note right of 对象B: 对象B的描述

Note left of 对象A: 对象A的描述(提示)

对象B-->对象A: 我很好(响应)

对象B->小三: 你好吗

小三-->>对象A: 对象B找我了

对象A->对象B: 你真的好吗？

Note over 小三,对象B: 我们是朋友

participant C

Note right of C: 没人陪我玩
```

# 5- 思维导图

## 5-1 样式一

