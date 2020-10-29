

## 1- 快捷键







## 2- 文件模板

Setting-》Editor-》File and Code Templates-》Files-》Python Script进入代码片段编辑界面。

![截屏2020-09-08 下午7.52.52](/Users/tanghui/Desktop/截屏2020-09-08 下午7.52.52.png)



例如：

``` python
##!/usr/bin/python3
# -*- coding: utf-8 -*-
# @Time : ${DATE} ${TIME}
# @Author : $USER
# @FileName: ${NAME}.py
# @Email : tanghui20_10@163.com
# @Software: ${PRODUCT_NAME}

# @Blog ：https://github.com/th9195/Notes
if __name__ == '__main__':

    pass
```









## 3- 代码块模板

从File-》Setting-》Editor-》Live Templates-》Python进入代码片段编辑界面。



如： 定义一个函数

![截屏2020-09-08 下午7.41.48](/Users/tanghui/Desktop/截屏2020-09-08 下午7.41.48.png)



自定义设置变量属性

![截屏2020-09-08 下午7.49.29](/Users/tanghui/Desktop/截屏2020-09-08 下午7.49.29.png)



###  定义一个函数 def

``` python
def $NAME$($var1$):
    """
    参数：$var1$
    功能：$var2$
    作者：$USER$
    时间：$DATE$ $TIME$
    """
    $END$


def ():
    """
    参数：
    功能：
    作者：tanghui
    时间：2020/9/8 7:44 下午
    """
    

    return
```



### 定义一个for 循环

``` python
for $INDEX$ in $var1$($num$):
    $END$
    pass
```



### 







小结：

``` python
小结：
$ITERABLE$    表示光标初始停留的位置
$end$        表示光标中途停留的位置
 
$END$        表示光标最后停留的位置（tab切换）
$SELECTION$   表示被选中的代码
 
$class$       表示当前所在类名
$method$    表示当前所在方法名
$NAME$     名称位置标记（自定义），初始光标停留。一般多个$NAME$，用于同时命名。
$var$        变量位置标记（自定义），初始光标停留。一般多个$var$，用于同时命名。
$var1$       变量1，tab切换时，光标会在该处停留
$var2$       变量2，tab切换时，光标会在该处停留
$var3$       变量3，tab切换时，光标会在该处停留
```





### 使用豆瓣源下载

pip install -i https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com wxpython



### 升级

python -m pip install --upgrade pip













