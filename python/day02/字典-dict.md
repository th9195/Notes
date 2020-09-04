# 字典

## 1- 字典的创建与删除

### 1-1 赋值直接创建

``` python
# 赋值创建一个字典
# dict = {'key1':'value1','key2':'value2','key3':'value3'}

student = {"name":"Tom","age":28,"sex":"男"}

print(student)

结果：
	{'name': 'Tom', 'age': 28, 'sex': '男'}
```



### 1-2 创建空字典

``` python
# 创建空字典
# dict_name = {}
# dict_name = dict()
dict1 = {}
dict2 = dict()
print(dict1)
print(dict2)
结果：
{}
{}

```



### 1-3 通过映射函数zip()创建字典

``` python
# 通过映射函数zip()创建字典
# dict_name = dict(zip(list1,list2))
actor = ["射手","辅助","法师","刺客","对抗"]
hero = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_hero = dict(zip(actor,hero))
print(actor_hero)

结果：
	{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
```



### 1-4 通过给定的关键字参数创建字典

``` python
# 通过给定的关键字参数创建字典
# dict_name = dict(key1 = value1,key2 = value2,key3 = value3)

actor_hero = dict(射手 ='后裔', 辅助 = '蔡文姬', 法师 ='安其拉', 刺客 = '孙悟空', 对抗 = '亚瑟')
print(actor_hero)

结果：
	{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
```



### 1-5 fromkeys()创建值为空的字典

``` python
# fromkeys()创建值为空的字典
# dict_name = dict.fromkeys(list1)
actor = ["射手","辅助","法师","刺客","对抗"]
heros_init = dict.fromkeys(actor)
print(heros_init)

结果：
	{'射手': None, '辅助': None, '法师': None, '刺客': None, '对抗': None}
```



### 1-6 元组为key， 但是list不能为key

``` python
# 创建一个元组为key, 列表为值得字典
actor = ("射手","辅助","法师","刺客","对抗")   # 元组
hero = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_hero = {actor:hero}
print(actor_hero)
结果：
	{('射手', '辅助', '法师', '刺客', '对抗'): ['后裔', '蔡文姬', '安其拉', '孙悟空', '亚瑟']}
  
  
  
actor = ["射手","辅助","法师","刺客","对抗"]	# list
hero = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_hero = {actor:hero}
print(actor_hero)

结果：
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/字典-dict.py", line 57, in <module>
    actor_hero = {actor:hero}
TypeError: unhashable type: 'list'
```



### 1-7 删除字典

#### 1-7-1 删除字典 del

``` python
# 删除字典
# del dictionary
actor = ["射手","辅助","法师","刺客","对抗"]
hero = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]
actor_hero = dict(zip(actor,hero))
print(actor_hero)
del actor_hero
print(actor_hero)
结果： 
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/字典-dict.py", line 68, in <module>
    print(actor_hero)
NameError: name 'actor_hero' is not defined
```



#### 1-7-2 清空字典 clear()

``` python
# 清空字典
# dict.clear()
actor = ["射手","辅助","法师","刺客","对抗"]
hero = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]
actor_hero = dict(zip(actor,hero))
print(actor_hero)
actor_hero.clear()
print(actor_hero)
结果：
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
{}
```



### 1-8 删除字典元素

#### 1-8-1 根据key删除元素 pop()

``` python
# 删除一个元素 pop() 根据key删除元素
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]
actor_hero = dict(zip(actor,heros))
print(actor_hero)

hero = actor_hero.pop("射手")  ## 返回被删除的元素的value
print(actor_hero)
print(hero)

actor_hero.pop("水手")        ## 删除不存在的key，报错
print(actor_hero)

结果：
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
{'辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
后裔
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/字典-dict.py", line 89, in <module>
    actor_hero.pop("水手")
KeyError: '水手'

```



#### 1-8-2 删除最后一个字典元素

``` python

# 删除最后一个字典元素
# popitem()   返回一个元组 被删除的key,value
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]
actor_hero = dict(zip(actor,heros))
print(actor_hero)

del_actor_hero = actor_hero.popitem()  # 返回一个元组
print(del_actor_hero,type(del_actor_hero))

print(actor_hero)

结果：
  {'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
  ('对抗', '亚瑟') <class 'tuple'>
  {'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空'}
```



#### 1-8-3 del删除元素

``` python
# del 删除字典元素
# del dict_name[key]
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]
actor_heros = dict(zip(actor,heros))
print(actor_heros)

del actor_heros["射手"]   ## 删除存在key 的元素 
print(actor_heros)

del actor_heros["水手"]		## 删除不存在key 的元素   报错
print(actor_heros)

结果：
  {'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
  {'辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
  Traceback (most recent call last):
    File "/Users/tanghui/work/Python/PythonStudy/day03/字典-dict.py", line 172, in <module>
      del actor_heros["水手"]
  KeyError: '水手'
```





## 2- 访问字典

### 2-1 通过key值访问value

``` python
## 通过key 访问value
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_heros = dict(zip(actor,heros))

print(actor_heros)

hero1 = actor_heros["刺客"]  # 访问有该key 的value
print(hero1)

hero2 = actor_heros["此刻"]   # 访问没有该key 的value
print(hero2)


结果：
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
孙悟空
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/字典-dict.py", line 119, in <module>
    hero2 = actor_heros["此刻"]   # 访问没有该key 的value
KeyError: '此刻'
```



### 2-2 当没有这个key，报错

``` python
## 通过key 访问value
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_heros = dict(zip(actor,heros))

print(actor_heros)

hero1 = actor_heros["刺客"]  # 访问有该key 的value
print(hero1)

hero2 = actor_heros["此刻"]   # 访问没有该key 的value
print(hero2)


结果：
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
孙悟空
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/字典-dict.py", line 119, in <module>
    hero2 = actor_heros["此刻"]   # 访问没有该key 的value
KeyError: '此刻'
```



### 2-3 get（）方法获取value

``` python

# get（）方法获取value
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_heros = dict(zip(actor,heros))
print(actor_heros)

hero1 = actor_heros.get("刺客")   # 访问有该key 的value
print(hero1)

hero2 = actor_heros.get("此刻")   # 访问没有该key 的value 不会报错，返回一个None
print(hero2)

hero3 = actor_heros.get("此刻","没有改角色的英雄")   # 访问没有该key 的value 设置默认值
print(hero3)

结果：
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
孙悟空
None
没有改角色的英雄
```



## 3- 遍历字典

``` python


# 字典遍历
# dict_name.iteam()
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_heros = dict(zip(actor,heros))
print(actor_heros)
for item in actor_heros.items():   ## items() 返回的是一个个元组
    print(item)

for key,value in actor_heros.items():
    print(key," = ",value)

# dict_name.keys()
for key in actor_heros.keys():
    value = actor_heros[key]
    print(key," = " ,value)

# dict_name.values()
for value in actor_heros.values():
    print(value)
```





## 4- 添加字典元素

``` python
## 添加元素
# dict_name[key] = value
actor = ["辅助","法师","刺客","对抗"]
heros = ["蔡文姬","安其拉","孙悟空","亚瑟"]
actor_heros = dict(zip(actor,heros))
print(actor_heros)

actor_heros["射手"] = "后裔"
print(actor_heros)

结果
{'辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
{'辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟', '射手': '后裔'}
```





## 5- 修改字典元素

 ``` python
# 修改元素
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]
actor_heros = dict(zip(actor,heros))
print(actor_heros)

actor_heros["法师"] = "妲己"
print(actor_heros)

结果：
  {'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
  {'射手': '后裔', '辅助': '蔡文姬', '法师': '妲己', '刺客': '孙悟空', '对抗': '亚瑟'}
 ```





## 6- 删除字典元素

请参考本文档中的 1-8



## 7- 字典推导式

``` python
## 字典推导式
## dict_name = {expression for var in range()}
import  random

random_dict = {i:random.randint(10,200) for i in range(10)}

print(random_dict)

结果：
	{0: 147, 1: 131, 2: 143, 3: 192, 4: 151, 5: 89, 6: 98, 7: 106, 8: 164, 9: 146}
```



``` python

## 推导式生成一个字典
actor = ["射手","辅助","法师","刺客","对抗"]
heros = ["后裔","蔡文姬","安其拉","孙悟空","亚瑟"]

actor_heros = {actor[i]:heros[i] for i in range(len(actor))}
print(actor_heros)

结果：
{'射手': '后裔', '辅助': '蔡文姬', '法师': '安其拉', '刺客': '孙悟空', '对抗': '亚瑟'}
```

