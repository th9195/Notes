

# 异常 try except else finally



## 1- demo  try except

``` python
'''
语法：
try:
    block1
except [ExceptionName [as alias]]:
    block2

'''


def division():
    apple = int(input("请输入苹果的个数:"))
    children = int(input("请输入小朋友的个数:"))

    result = apple // children

    remain = apple % children

    print(f"apple = {apple},children = {children},result = {result},remain = {remain}")

if __name__ == '__main__':
    while True:
        try:
            division()
        except ValueError as v:
            print("error: ",v)
        except ZeroDivisionError as z:
            print("error: ",z)
            
            
结果：
  请输入苹果的个数:10.2
  error:  invalid literal for int() with base 10: '10.2'
  请输入苹果的个数:10
  请输入小朋友的个数:0
  error:  integer division or modulo by zero
  请输入苹果的个数:10
  请输入小朋友的个数:10
  apple = 10,children = 10,result = 1,remain = 0
  请输入苹果的个数:
```





## 2- demo try except except else

``` python
'''
语法：
try:
    block1
except [ExceptionName [as alias]]:
    block2
except [ExceptionName [as alias]]:
		block3
else:
		block4

'''


def division():
    apple = int(input("请输入苹果的个数:"))
    children = int(input("请输入小朋友的个数:"))

    result = apple // children

    remain = apple % children

    print(f"apple = {apple},children = {children},result = {result},remain = {remain}")

if __name__ == '__main__':
    while True:
        try:
            division()
        except ValueError as v:
            print("error: ",v)
        except ZeroDivisionError as z:
            print("error: ",z)
        else:
            print("完成！")
            break
结果： 
  请输入苹果的个数:20.5
  error:  invalid literal for int() with base 10: '20.5'
  请输入苹果的个数:20
  请输入小朋友的个数:0
  error:  integer division or modulo by zero
  请输入苹果的个数:20
  请输入小朋友的个数:15
  apple = 20,children = 15,result = 1,remain = 5
  完成！

  Process finished with exit code 0
```



## 3- demo try except except else finally

``` python
'''
语法：
try:
    block1
except [ExceptionName [as alias]]:
    block2
except [ExceptionName [as alias]]:
    block3
else:
    block4
finally:
    block5    ## 这里的代码一定会执行


'''


def division():
    apple = int(input("请输入苹果的个数:"))
    children = int(input("请输入小朋友的个数:"))

    result = apple // children

    remain = apple % children

    print(f"apple = {apple},children = {children},result = {result},remain = {remain}")

if __name__ == '__main__':
    count = 0
    while True:
        try:
            count += 1
            division()
        except ValueError as v:
            print("error: ",v)
        except ZeroDivisionError as z:
            print("error: ",z)
        else:
            print("完成！")
            break
        finally:
            print(f"第{count}次分苹果")
结果：
  请输入苹果的个数:20.3
  error:  invalid literal for int() with base 10: '20.3'
  第1次分苹果
  请输入苹果的个数:20
  请输入小朋友的个数:0
  error:  integer division or modulo by zero
  第2次分苹果
  请输入苹果的个数:20
  请输入小朋友的个数:8
  apple = 20,children = 8,result = 2,remain = 4
  完成！
  第3次分苹果

  Process finished with exit code 0
```



## raise

``` python
# -*- coding: utf-8 -*-
# @Time : 2020/9/11 2:31 下午
# @Author : tanghui
# @FileName: 异常-try_except_finally.py
# @Email : tanghui20_10@163.com
# @Software: PyCharm

# @Blog ：https://github.com/th9195/Notes

'''
语法：
try:
    block1
except [ExceptionName [as alias]]:
    block2
except [ExceptionName [as alias]]:
    block3
else:
    block4
finally:
    block5    ## 这里的代码一定会执行


'''


def division():
    apple = int(input("请输入苹果的个数:"))
    children = int(input("请输入小朋友的个数:"))

    if apple < children:
        raise ValueError("苹果太少了，每个小朋友分不到一个！")  # 手动抛出一个异常

    result = apple // children

    remain = apple % children

    print(f"apple = {apple},children = {children},result = {result},remain = {remain}")

if __name__ == '__main__':
    count = 0
    while True:
        try:
            count += 1
            division()
        except ValueError as v:
            print("error: ",v)
        except ZeroDivisionError as z:
            print("error: ",z)
        else:
            print("完成！")
            break
        finally:
            print(f"第{count}次分苹果")
            
结果：
  请输入苹果的个数:5
  请输入小朋友的个数:10
  error:  苹果太少了，每个小朋友分不到一个！
  第1次分苹果
  请输入苹果的个数:5
  请输入小朋友的个数:5
  apple = 5,children = 5,result = 1,remain = 0
  完成！
  第2次分苹果
```



## 断言 assert

``` python

# assert
# 语法： assert expression [,reason]
# 1- 当条件值为真时，什么都不做（不走断言，程序继续往下走）；
# 2- 当条件值为假时，走断言 抛出AssertionError 异常；并终止程序
def division():
    apple = int(input("请输入苹果的个数:"))
    children = int(input("请输入小朋友的个数:"))

    # if apple < children:
    #     raise ValueError("苹果太少了，每个小朋友分不到一个！")  # 手动抛出一个异常

    # 断言 assert
    assert apple > children , "苹果太少了，每个小朋友分不到一个！"

    result = apple // children

    remain = apple % children

    print(f"apple = {apple},children = {children},result = {result},remain = {remain}")

if __name__ == '__main__':
    count = 0
    while True:
        try:
            count += 1
            division()
        except ValueError as v:
            print("error: ",v)
        except ZeroDivisionError as z:
            print("error: ",z)
        else:
            print("完成！")
            break
        finally:
            print(f"第{count}次分苹果")

结果： 
请输入苹果的个数:5
请输入小朋友的个数:10
第1次分苹果
Traceback (most recent call last):
  File "/Users/tanghui/work/Python/PythonStudy/day05/异常-try_except_finally.py", line 48, in <module>
    division()
  File "/Users/tanghui/work/Python/PythonStudy/day05/异常-try_except_finally.py", line 35, in division
    assert apple > children , "苹果太少了，每个小朋友分不到一个！"
AssertionError: 苹果太少了，每个小朋友分不到一个！

Process finished with exit code 1
```

