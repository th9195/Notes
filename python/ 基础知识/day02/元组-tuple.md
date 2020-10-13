# 元组

## 1- 元组的创建和删除

### 1-2 创建元组

``` python

##元组
## 创建元组
# tuple_name = (element1,element2,element3)
t1 = ("google","百度","bing")
t2 = (1,2,3,4,5)
t3 = (6,7,"Tom",8,"Jerry")
t4 = 3,6,9,10

print(t1, type(t1))
print(t2, type(t2))
print(t3, type(t3))
print(t4, type(t4))



结果：
  ('google', '百度', 'bing') <class 'tuple'>
  (1, 2, 3, 4, 5) <class 'tuple'>
  (6, 7, 'Tom', 8, 'Jerry') <class 'tuple'>
  (3, 6, 9, 10) <class 'tuple'>
  
```



### 1-2 创建一个空元组

``` python
## 创建空元组
t5 = ()
print(t5,type(t5))

结果：
	() <class 'tuple'>
```



### 1-3 创建元组只有一个元素

``` python
# 当一个元组只有一个元素时需要注意  需要添加一个逗号 ","
tup1 = (50)
print(tup1,type(tup1))


tup2 = (50,)
print(tup2,type(tup2))

结果：
  50 <class 'int'>
  (50,) <class 'tuple'>
```



### 1-4 创建数值元组

``` python
# 创建数值元组
# tuple(data)

tup3 = tuple(range(10,20,2))
print(tup3,type(tup3))

结果：
	(10, 12, 14, 16, 18) <class 'tuple'>
```



### 1-5 删除元组

``` python

## 删除元组

tup = ('Google', 'Runoob', 1997, 2000)

print(tup)
del tup
print("删除后的元组 tup : ")
print(tup)

结果：
  ('Google', 'Runoob', 1997, 2000)
  删除后的元组 tup : 
  Traceback (most recent call last):
    File "/Users/tanghui/work/Python/PythonStudy/day03/元组-tuple.py", line 44, in <module>
      print(tup)
  NameError: name 'tup' is not defined
```





## 2- 访问元组

### 2-1 切片访问元素

``` python
# 访问元组元素
# tuple_name[start:end:step]   顾头不顾尾元组,
heros = ("猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白")
print(heros[4]) # 访问单个元素
print(heros[:len(heros):3])
print(heros[-1:0:-2])

结果：
  李白
  ('猴子', '小鲁班', '安其拉', '小鲁班')
  ('李白', '亚瑟', '安其拉', '李白', '亚瑟')
```

### 2-2 遍历元组

``` python
#遍历元组
heros = ("猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白")

for item in heros:
    print(item,end="-")

print()
for index ,item in enumerate(heros):
    print("heros[%s] = %s"%(index,item))
    
for index, item in enumerate(heros):
    if index % 2 == 0 :
        print(item,"\t\t",end="")
    else:
        print(item)
    
结果：
	猴子-后裔-亚瑟-小鲁班-李白-庄周-安其拉-蔡文姬-亚瑟-小鲁班-李白-
  heros[0] = 猴子
  heros[1] = 后裔
  heros[2] = 亚瑟
  heros[3] = 小鲁班
  heros[4] = 李白
  heros[5] = 庄周
  heros[6] = 安其拉
  heros[7] = 蔡文姬
  heros[8] = 亚瑟
  heros[9] = 小鲁班
  heros[10] = 李白
  猴子 		后裔
  亚瑟 		小鲁班
  李白 		庄周
  安其拉 		蔡文姬
  亚瑟 		小鲁班
  李白 	
```



## 3- 修改元组元素

### 3-1 修改元组

``` python
# 修改元组
heros = ("猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白")

#heros[0] = "孙悟空"   # 元组的元素不能修改
print(heros)
```



### 3-2 元组组合

``` python

# 元组组合
hero1 = ("猴子","后裔","亚瑟","小鲁班")
hero2 =("李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白")

heros = hero1 + hero2
print(hero1)
print(hero2)
print(heros)

结果：
('猴子', '后裔', '亚瑟', '小鲁班')
('李白', '庄周', '安其拉', '蔡文姬', '亚瑟', '小鲁班', '李白')
('猴子', '后裔', '亚瑟', '小鲁班', '李白', '庄周', '安其拉', '蔡文姬', '亚瑟', '小鲁班', '李白')
```



### 3-3 元组组合只能是两个元组组合，不能与别的序列组合

``` python
## 元组组合只能是两个元组组合，不能与别的序列组合
hero1 = ("猴子","后裔","亚瑟","小鲁班")
hero2 =["李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白"]

heros = hero1 + hero2
print(heros)

结果：
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/元组-tuple.py", line 91, in <module>
    heros = hero1 + hero2
TypeError: can only concatenate tuple (not "list") to tuple
```





## 4- 元组推导式



``` python
# tuple推导式
# tuple_name = （expression for var in list）
# 推导式生成的是一个生成器，并不是元组
import random
random_number = (random.randint(10,100) for idex in range(10))
print("生成的元组生成器为： " ,random_number)

random_number = tuple(random_number)
print("转换后：" ,random_number)

结果：
  生成的元组生成器为：  <generator object <genexpr> at 0x1022772d0>
  转换后： (29, 51, 86, 38, 71, 58, 53, 24, 56, 43)
```





## 5- 元组和列表的区别

列表 元素可变

元组 元素不可变

详情请看 列表-元组-字典-集合区别文档

