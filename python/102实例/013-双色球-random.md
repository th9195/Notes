## 技术点



**random中的一些重要函数的用法：**

1 )、random() 返回0<=n<1之间的随机实数n；
2 )、choice(seq) 从序列seq中返回随机的元素；
3 )、getrandbits(n) 以长整型形式返回n个随机位；
4 )、shuffle(seq[, random]) 原地指定seq序列；
5 )、sample(seq, n) 从序列seq中选择n个随机且独立的元素；

　

**详细介绍：**

**random.random()**函数是这个模块中最常用的方法了，它会生成一个随机的浮点数，范围是在0.0~1.0之间。

**random.uniform()**正好弥补了上面函数的不足，它可以设定浮点数的范围，一个是上限，一个是下限。

**random.randint()**随机生一个整数int类型，可以指定这个整数的范围，同样有上限和下限值，python random.randint。

**random.choice()**可以从任何序列，比如list列表中，选取一个随机的元素返回，可以用于字符串、列表、元组等。

**random.shuffle()**如果你想将一个序列中的元素，随机打乱的话可以用这个函数方法。

**random.sample()**可以从指定的序列中，随机的截取指定长度的片断，不作原地修改。



## 案例

``` python
# -*- coding: utf-8 -*-
# @Time : 2020/10/23 9:34 上午
# @Author : tanghui
# @FileName: 013-双色球彩票.py
# @Email : tanghui20_10@163.com
# @Software: PyCharm

# @Blog ：https://github.com/th9195/Notes

'''
**random.random()**函数是这个模块中最常用的方法了，它会生成一个随机的浮点数，范围是在0.0~1.0之间。

**random.uniform()**正好弥补了上面函数的不足，它可以设定浮点数的范围，一个是上限，一个是下限。

**random.randint()**随机生一个整数int类型，可以指定这个整数的范围，同样有上限和下限值，python random.randint。

**random.choice()**可以从任何序列，比如list列表中，选取一个随机的元素返回，可以用于字符串、列表、元组等。

**random.shuffle()**如果你想将一个序列中的元素，随机打乱的话可以用这个函数方法。

**random.sample()**可以从指定的序列中，随机的截取指定长度的片断，不作原地修改。
'''
import random

def testrandomchoice():

    print("test random choice".center(50,"*"))
    countrys = ["aaa","bbbb","cddd","dddd","eeee","f","g","h","i"]

    print(random.choice(countrys))


def testrandomsample():
    print("test random sample".center(50,"*"))

    slice = random.sample(range(20,100,2),10)  # 生成的10个数不能重复

    print("type :" ,type(slice))
    print("slice = " ,slice)


def testrandomuniform():

    print("test random uniform".center(50, "*"))

    fnum = random.uniform(6,3)  # 跟random 类似，可以指定范围

    print("type : ",type(fnum))
    print("fnum = " ,fnum)


def testrandomrandomint():
    print("test random randomint".center(50, "*"))
    ranintnum = random.randint(10,20)
    print("ranintnum = " , ranintnum)


def testrandomrandom():
    print("test random random".center(50, "*"))
    randnum = random.random()
    print("randnum = ",randnum)


def testrandomshuffle():
    print("test random shuffle".center(50, "*"))
    li = list(range(10))
    print(li)
    random.shuffle(li)
    print("li = ", li)


def testzfill():
    myhex = hex(15)
    myhex = myhex.replace("0x","")
    print(myhex)
    if 1 == len(myhex):
        myhex = myhex.zfill(2)

    print(myhex)


def doublecolorball():
    print("福彩双色球".center(50,"*"))
    print("=="*27)
    nums = []

    for i in range(1,10):
        red = [str(item).zfill(2) for item in (random.sample(range(1,31),6))]
        blue = str(random.choice(range(1,16))).zfill(2)
        newnum = ",".join(red) + "," + blue
        print(newnum.center(50))
        nums.append(newnum)



if __name__ == '__main__':
    # 可以从任何序列，比如list列表中，选取一个随机的元素返回，可以用于字符串、列表、元组等
    testrandomchoice()

    # 可以从指定的序列中，随机的截取指定长度的片断，不作原地修改
    testrandomsample()

    # 正好弥补了上面函数的不足，它可以设定浮点数的范围，一个是上限，一个是下限
    testrandomuniform()

    # 随机生一个整数int类型，可以指定这个整数的范围，同样有上限和下限值
    testrandomrandomint()

    # 函数是这个模块中最常用的方法了，它会生成一个随机的浮点数，范围是在0.0~1.0之间
    testrandomrandom()

    # random.shuffle()**如果你想将一个序列中的元素，随机打乱的话可以用这个函数方法。
    testrandomshuffle()


    # 字符串前面补0
    testzfill()


    # 双色球
    doublecolorball()
```







