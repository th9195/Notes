

# 1- 修改字体样式

- 格式

``` html
<span style="color:red;background:black;font-size:18px;font-family:楷体;">
xxxxxxx
</span>
```

- 案例：

<span style="color:red;background:white;font-size:20px;font-family:楷体;">**你要改色的文字**</span>



# 2- 流程图

## 2-1 样式一：

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

## 2-2 样式二

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

# 3- UML时序图

## 3-1 样式一：

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

## 3-2 样式二

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

# 4- 思维导图

## 4-1 样式一





# 5-生成目录：

``` properties
[TOC] + 按回车
```



# 6- 快捷键

``` properties
windows快捷键：#
无序列表：输入-之后输入空格
有序列表：输入数字+“.”之后输入空格
任务列表：-[空格]空格 文字
标题：ctrl+数字
表格：ctrl+t
生成目录：[TOC]按回车
选中一整行：ctrl+l
选中单词：ctrl+d
选中相同格式的文字：ctrl+e
跳转到文章开头：ctrl+home
跳转到文章结尾：ctrl+end
搜索：ctrl+f
替换：ctrl+h
引用：输入>之后输入空格
代码块：ctrl+alt+f
加粗：ctrl+b
倾斜：ctrl+i
下划线：ctrl+u
删除线：alt+shift+5
插入图片：直接拖动到指定位置即可或者ctrl+shift+i
插入链接：ctrl + k
```



# 7- 表情

输出表情需要借助 `：`符号。

栗子：`:smile` 显示为 😄,记住是左右两边都要冒号。

使用者可以通过使用`ESC`键触发表情建议补全功能，也可在功能面板启用后自动触发此功能。同时，直接从菜单栏`Edit` -> `Emoji & Symbols`插入UTF8表情符号也是可以的。

或者使用下面的方法

访问网站 https://emojikeyboard.org/，找到需要的符号，鼠标左键单击，然后粘贴到需要的地方就行了！🆗



# 8- 链接

<a href="http://baidu.com" target="_blank">link</a>

``` properties
<a href="http://baidu.com" target="_blank">link</a>
```



