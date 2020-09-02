# 循环

## while

``` python
'''

找出一个数字 
余 3 等于 2
余 5 等于 3 
余 7 等于 2

'''
number = 1
none = True
while none:
    number += 1
    if number % 3 == 2 and number % 5 == 3 and number % 7 == 2:
        none = False


print("这个数字 number == " ,number)

```



## for

### 1- 遍历列表



``` python

'''
遍历列表
'''
l1 = [1,2,"abc","kdjf",55.555]

len = len(l1)

for item in l1:

    index = l1.index(item)
    if index < len - 1 :
        print(item, end="---")
    else:
        print(item)

```



### 2- 遍历range

``` python
'''
内置函数 range(0,10,2)
参数1：    从0开始；
参数2：    不超过10；
参数3：    步长为2；

'''
for i in range(1,10,2):
    print(i,end="#")
```



### 3- 遍历字符串

``` python
'''
遍历字符串
'''

str = "hello world"
for ch in str:
    print(ch,end="-")
```



### 4- 九九乘法表

``` python
'''
    九九乘法表
'''
for i in range(1,10):
    for j in range(1,i + 1):
        print(j,"*",i,"=",i * j ,"\t",end="")
    print()
```

