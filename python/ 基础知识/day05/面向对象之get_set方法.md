

## Python get set方法

​	java中我们在定义类的成员变量时，如果是私有属性，我们通过调用属性对应的set和get方法来获取和设置变量的值，如果我们将这种方式来用于python那么代码如下



### 方法一  getName setName

``` python

# java中我们在定义类的成员变量时，如果是私有属性，我们通过调用属性对应的set和get方法来获取和设置变量的值，
# 如果我们将这种方式来用于python那么代码如下：

class Student(object):
    def __init__(self):
        self.name = None
        self.age = 0
        self.id = None

    def getName(self):
        return self.name

    def setName(self,name):
        if isinstance(name,str):
            self.name = name
        else:
            print("set Name error!")

if __name__ == '__main__':
    student = Student()
    print(student.getName())
    student.setName("Tom")
    print(student.getName())
    
    
结果： 
None
Tom
```



### 方法二python属性

``` python

# java中我们在定义类的成员变量时，如果是私有属性，我们通过调用属性对应的set和get方法来获取和设置变量的值，
# 如果我们将这种方式来用于python那么代码如下：

class Student(object):
    def __init__(self):
        self.name = None
        self.age = 0
        self.id = None

    def getName(self):
        return self.name

    def setName(self,name):
        if isinstance(name,str):
            self.name = name
        else:
            print("set name error!")

    def getAge(self):
        return self.age

    def setAge(self,age):
        if isinstance(age,int):
            self.age = age
        else:
            print("set age error!")

    nameProperty = property(getName,setName)
    ageProperty = property(getAge,setAge)

if __name__ == '__main__':
    student = Student()
    # print(student.getName())
    # student.setName("Tom")

    print(student.nameProperty)
    print(student.ageProperty)

    student.nameProperty = "Tom"
    student.ageProperty = 28

    print(student.nameProperty)
    print(student.ageProperty)
结果： 
None
0
Tom
28
```



### 方法三:使用property完全取代, @property @paramName.setter

``` python

# java中我们在定义类的成员变量时，如果是私有属性，我们通过调用属性对应的set和get方法来获取和设置变量的值，
# 如果我们将这种方式来用于python那么代码如下：

class Student(object):
    def __init__(self):
        self._name = None
        self._age = 0
        self._id = None

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self,name):
        if isinstance(name,str):
            self._name = name
        else:
            print("set name error")

    @property
    def age(self):
        return self._age

    @age.setter
    def age(self, age):
        if isinstance(age, int):
            self._age = age
        else:
            print("set age error")

    @property
    def id(self):
        return self._id

    @id.setter
    def id(self,id):
        if isinstance(id,str):
            self._id = id
        else:
            print("set id error!")


if __name__ == '__main__':
    student = Student()
    
    print(student.name)
    student.name = "tanghui"
    print(student.name)

    print(student.age)
    student.age = 30
    print(student.age)

    print(student.id)
    student.id = "92387387482"
    print(student.id)

结果： 
None
tanghui
0
30
None
92387387482
```

