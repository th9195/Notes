# 列表-list

## 1- 创建和删除列表

### 1-1 使用赋值运算符直接创建列表

``` python
# 使用赋值运算符直接创建列表
# listname = [ele1,ele2,ele3,ele4,...,elen]
num = [7,14,21,28,35,42]
verse = ["自古1","自古2","自古3","自古4"]
untitle = ["python",28,["爬虫","自动化运维","Web开发"]]
print(num)
print(verse)
print(untitle)

```

### 1-2 创建一个空列表

``` python
## 创建一个空列表
emptylist = []
```



### 1-3 创建数值列表

``` python
## 创建数值列表
#data_list = list(data)

data_list = list(range(10,20,2))
print(data_list)
```



### 1-4 删除列表

``` python
#删除列表
# 注意： 在删除一个列表的时候一定要保证这个列表存在
team = ["猴子","后裔","亚瑟","小鲁班"]
print(team)
del team
```







## 2- 访问列表

``` python

## 输出每日一贴

import  datetime  # 导入日期时间类

#定义一个列表
mot = [
    "今天星期一：\n坚持下去不是因为我很坚强，而是因为我别无选择",
    "今天星期二：\n含泪播种的人一定能笑着收获",
    "今天星期三：\n做对的事情比把事情做对重要",
    "今天星期四：\n命运给予我们的不是失望之酒，而是机会之杯",
    "今天星期五：\n不要等到明天，明天太遥远，今天就行动",
    "今天星期六：\n求知若饥，虚心若愚",
    "今天星期日：\n成功将属于那些从不说'不可能'的人"
    ]
day = datetime.datetime.now().weekday()
print(day)
print(mot[day])

```



## 3- 遍历列表

``` python
## 遍历列表
# for
team = ["猴子","后裔","亚瑟","小鲁班"]
for item in team:
    print(item,end="-")
print()

#使用 enumerate遍历
for index ,item in enumerate(team):
    print("team[%s] = %s"%(index ,item))
    
    
# 分两列显示    
for index , item in enumerate(team):
    if index % 2 == 0:
        print(item,"\t\t",end="")
    else:
        print(item)
```





## 4- 添加删除修改列表



### 4-1 添加元素

``` python

# 添加元素
# listname.append(obj)   在末尾添加
# listname.insert(index,obj) 在指定位置添加
# listname.extend(seq) 将两个列表合并
# seq1 + seq2
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬"]

len1 = len(team)
print(len1)
print(team)

team.append("百里守约")
len2 = len(team)
print(len2)
print(team)

# 在指定位置添加
team.insert(0,"赵云")
len3 = len(team)
print(len3)
print(team)

# extend
new_team = ["韩信","猪八戒","狄仁杰"]
team.extend(new_team)
print(len(team))
print(team)

#也可以是用 加法
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬"]
new_team = ["韩信","猪八戒","狄仁杰"]
print(team + new_team)
```



### 4-2 修改元素

``` python
# 修改元素
# listname[index] = new_value
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬"]

team[0] = "孙悟空"
print(team)
```



### 4-3 删除元素 remove

``` python
# 删除元素
# 根据索引删除  del listname[index]
# 根据值删除    listname.remove
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬"]
del team[1]   # 根据索引删除
print(team)

team.remove("李白")  # 根据元素值删除 注意： 如果列表中没有改元素会报错 x not in list
print(team)

```



### 4-4 删除元素 pop

``` python
# 使用pop 删除元素
# list.pop([index=-1])  默认是删除最后一个
# pop() 函数用于移除列表中的一个元素（默认最后一个元素），并且返回该元素的值。
heros = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白"]
del_hero = heros.pop(1)
print(del_hero)
print(heros)

结果：
  后裔
  ['猴子', '亚瑟', '小鲁班', '李白', '庄周', '安其拉', '蔡文姬', '亚瑟', '小鲁班', '李白']
```



## 5- 列表统计和计算

1. count

2. index

3. sum

   

### 5-1 获取指定元素出现的次数

``` python
# 获取指定元素出现的次数
# listname.count(obj)
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白"]
count_libai = team.count("李白")
print("李白出现了",count_libai)
```



### 5-2 获取指定元素首次出现的下标

``` python
# 获取指定元素首次出现的下标
# listname.index(obj)
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白"]
print(team.index("李白")) # 注意：如果列表中没有这个元素将会报错： is not in list
```



### 5-3 统计数值列表的元素和

``` python
# 统计数值列表的元素和
nums = [100,200,300,400]
print(sum(nums))
```



## 6- 列表排序



### 6-1 sort

``` python

# 排序 sort
# listname.sort(ken=None,reverse=False)
team = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白"]
print(team)
team.sort()
print("升序: ",team)
team.sort(reverse=True)
print("降序: ",team)

# key = str.lower  不区分大小写
animals = ['cat','Tom',"Angela",'pet']
animals.sort()
print("区分大小写",animals)
animals.sort(key=str.lower)
print("不区分大小写",animals)

# key = xxxx   如果元素是由序列组成，可以选择根据元素中序列的第几个子元素排序
def take_index(elem):
    return elem[1]
numss = [(1,'a'),(3,'d'),(4,"b"),(2,"c")]
print(numss)
numss.sort(key=take_index)
print(numss)
```



### 6-2 sorted

``` python
# 排序 内置方法sorted
# sorted(iterable,key = None,reverse = False)
# 注意：列表对象的sort方法和sorted内置函数的作用基本相同；
# 不同点是sort()方法改变的是原来列表的元素顺序；
# sorted()内置函数会建立一个新的列表返回，原来列表不变

grade = [98,99,97,100,100,95,96,94,89]
grade_as = sorted(grade)
print("升序",grade_as)
grade_des = sorted(grade,reverse=True)
print("降序",grade_des)
print("原来序列",grade)
```



## 7- 列表推导式

### 7-1 生成指定范围的数值列表

``` yacas

# 生成指定范围的数值列表
# listname = [expression for var in range]

# 生成10 个 10-100 之间的数值
import random
new_nums = [random.randint(10,100) for i in range(10)]
print(new_nums)
```



### 7-2 根据列表生成指定需求的列表

``` python
# 根据列表生成指定需求的列表
# listname = [expression for var in list]

price = [77, 64, 74, 34, 21, 53, 54, 79, 83, 64]
sale = [int(item * 0.5) for item in price]
print(sale)
```



### 7-3 从列表中选择符合条件的元素组成新的列表

``` python
# 从列表中选择符合条件的元素组成新的列表
# listname = [expression for var in list if condition]
old_nums = [77, 64, 74, 34, 21, 53, 54, 79, 83, 64]
new_nums = [item for item in old_nums if item < 50]
print(new_nums)

```

### 7-4 生成新的列表元素也是一个列表

``` python
# 生成新的列表元素也是一个列表
# listname [expression for var in list if condition]
heros = ["猴子","后裔","亚瑟","小鲁班","李白","庄周","安其拉","蔡文姬","亚瑟","小鲁班","李白"]

new_heros = [(index,item) for index,item in enumerate(heros)]
print(new_heros)
```



## 8- 二维列表

``` python

# 二维列表的使用
# 1- 直接定义二维列表
'''
listname = [
    [元素11,元素12,元素13,元素14],
    [元素21,元素22,元素23,元素24],
    [元素31,元素32,元素33,元素34],
    [元素41,元素42,元素43,元素44],
    [元素51,元素52,元素53,元素54]
]
'''

# 射手 刺客 法师 对抗 辅助
heros = [
    ["后裔","鲁班七号"],
    ["孙悟空","李白"],
    ["安其拉","妲己"],
    ["亚瑟","吕布"],
    ["蔡文姬","庄周"]
]
print(heros)


# 使用嵌套的for循环创建
arr = []
for i  in range(4):
    arr.append([])
    for j in range(5):
        arr[i].append(j)

print(arr)

# 使用列表推导式创建
aar = [[str(i)+str(j) for j in range(5)] for i in range(4)]
print(aar)

```

