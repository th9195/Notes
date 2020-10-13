# 集合 set



## 1- 集合的创建

``` python

#直接使用{}创建集合
# set_name = [ele1,ele2,...,elen]

heros = {"后裔","蔡文姬","妲己","孙悟空","亚瑟"}
print(heros,type(heros))

# 使用set()创建集合
# set_name = set(iteration)

heros = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
print(heros,type(heros))

# 创建 空 集合  只能使用set() 方法
heros = set()
print(type(heros))

# {} 表示的是一个空字典
heros = {}
print(type(heros))

结果：
  {'孙悟空', '妲己', '后裔', '亚瑟', '蔡文姬'} <class 'set'>
  {'孙悟空', '妲己', '后裔', '亚瑟', '蔡文姬'} <class 'set'>
  <class 'set'>
  <class 'dict'>
```



## 2- 集合的添加和删除

### 2-1 添加

``` python
# 集合添加元素
# set_name.add(ele)
heros = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
heros.add("安琪拉")
heros.add("鲁班七号")
print(heros)
结果： 
	{'鲁班七号', '孙悟空', '妲己', '后裔', '亚瑟', '安琪拉', '蔡文姬'}
```



### 2-2 删除

#### 2-2-1 随机删除元素 pop()

``` python
## 集合随机删除元素
## pop() 用于随机移除一个元素。并返回被删除的元素
heros = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
pop_hero = heros.pop()
print(pop_hero)
print(heros)
结果：
  亚瑟
  {'后裔', '蔡文姬', '妲己', '孙悟空'}
```

#### 2-2-2 remove(ele) 指定删除元素

``` python
## remove(ele) 指定删除元素 ，如果元素不存在 报错
heros = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
heros.remove("孙悟空")
print(heros)

heros.remove("打击")   ## 没有该元素 报错
print(heros)
结果：
  {'妲己', '后裔', '亚瑟', '蔡文姬'}
  Traceback (most recent call last):
    File "/Users/tanghui/work/Python/PythonStudy/day03/集合-set.py", line 48, in <module>
      heros.remove("打击")
  KeyError: '打击'
```



#### 2-2-3 清空集合 clear()

``` python
## clear() 清空集合
heros = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
print(heros)
heros.clear()
print(heros)

结果： 
	{'妲己', '孙悟空', '亚瑟', '后裔', '蔡文姬'}
	set()
```



2-2-4 删除集合

``` python
## del 删除整个集合
heros = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
print(heros)
del heros
print(heros)

结果：
	{'蔡文姬', '后裔', '妲己', '亚瑟', '孙悟空'}
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day03/集合-set.py", line 55, in <module>
    print(heros)
NameError: name 'heros' is not defined

```



## 3- 集合的交集、并集、差集、对称差集

``` python
## 集合 交集 &   并集 |  差集 -
## 对称差集 ^
hero1 = set (["后裔","蔡文姬","妲己","孙悟空","亚瑟"])
hero2 = set (["后裔","庄周","安琪拉","韩信","亚瑟"])

print(hero1)
print(hero2)

jiaoji = hero1 & hero2  # 交集
print(jiaoji)

bingji = hero1 | hero2  # 并集
print(bingji)

chaji = hero1 - hero2		# 差集
print(chaji)

duichengchaji = hero1 ^ hero2		#对称差集
print(duichengchaji)

结果： 
  {'妲己', '后裔', '孙悟空', '亚瑟', '蔡文姬'}
  {'庄周', '韩信', '后裔', '安琪拉', '亚瑟'}
  {'后裔', '亚瑟'}
  {'庄周', '妲己', '韩信', '后裔', '孙悟空', '安琪拉', '亚瑟', '蔡文姬'}
  {'孙悟空', '蔡文姬', '妲己'}
  {'韩信', '孙悟空', '蔡文姬', '安琪拉', '庄周', '妲己'}


```



