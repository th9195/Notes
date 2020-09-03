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



## 5- 逢7拍大腿游戏

``` python

'''
 逢 7 拍腿游戏
 只要是 7 的倍数 或者 7结尾

'''


l1 = list()

for i in range(-22,100):
    if i % 7 == 0 or str(i).endswith("7") > 0 :
        l1.append(i)
        continue


print(len(l1))
print(l1)

结果：
  27
  [-21, -17, -14, -7, 0, 7, 14, 17, 21, 27, 28, 35, 37, 42, 47, 49, 56, 57, 63, 67, 70, 77, 84, 87, 91, 97, 98]

```



## 6- 猜数字游戏

``` python
'''
猜数字游戏
'''


min_number = 0
max_number = 100
thunder_number = 0

guess_number = 0


thunder_number = int(input("请输入雷数字:"))
while True:
    guess_number = int(input("请输入您猜的数字:"))

    #判断您说的数字是否有效
    if guess_number > max_number or guess_number < min_number:
        print("您说的数字无效，请重试！%d 到 %d" % (min_number,max_number))
        continue
    else:
        #判断是否猜中
        if thunder_number == guess_number:
            print("恭喜您猜中！游戏结束")
            break
        else:
            #如果没有猜中重新设置范围
            if guess_number > thunder_number:
                max_number = guess_number
            elif guess_number < thunder_number:
                min_number = guess_number
            print("您没有猜中，游戏继续，{}到{}".format(min_number,max_number))
```



