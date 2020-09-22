# 时间time



## 时间元组格式

``` python

"""
    时间元组（年、月、日、时、分、秒、一周的第几日、一年的第几日、夏令时）
        一周的第几日: 0-6
        一年的第几日: 1-366
        夏令时: -1, 0, 1

    tm_year=2018,
    tm_mon=9,
    tm_mday=3,
    tm_hour=9,
    tm_min=4,
    tm_sec=1,
    tm_wday=6,
    tm_yday=246,
    tm_isdst=0

"""

```



## 格式化时间格式

``` python

"""
    python中时间日期格式化符号：
    ------------------------------------
    %y 两位数的年份表示（00-99）
    %Y 四位数的年份表示（000-9999）
    %m 月份（01-12）
    %d 月内中的一天（0-31）
    %H 24小时制小时数（0-23）
    %I 12小时制小时数（01-12）
    %M 分钟数（00=59）
    %S 秒（00-59）
    %a 本地简化星期名称
    %A 本地完整星期名称
    %b 本地简化的月份名称
    %B 本地完整的月份名称
    %c 本地相应的日期表示和时间表示
    %j 年内的一天（001-366）
    %p 本地A.M.或P.M.的等价符
    %U 一年中的星期数（00-53）星期天为星期的开始
    %w 星期（0-6），星期天为星期的开始
    %W 一年中的星期数（00-53）星期一为星期的开始
    %x 本地相应的日期表示
    %X 本地相应的时间表示
    %Z 当前时区的名称  # 乱码
    %% %号本身
"""
```



## 常用格式化时间 的格式

``` python
formatTimeStr1 = "%Y-%m-%d %H:%M:%S"  		# 年-月-日 时:分:秒
formatTimeStr2 = "%a %b %d %H:%M:%S %Y" 	# 周几 月 日 时:分:秒 年
formatTimeStr3 = "%A %B %d %H:%M:%S %Y"		# 周几 月 日 时:分:秒 年   （完整的周几、月）

```



## 时间戳、时间元组、可视化（格式化）时间相互转换

``` python
if __name__ == '__main__':
    import time
    import calendar
    # 当前时间的时间戳
    mytime = time.time()
    print("mytime = ",mytime)

    time.sleep(1)

    # 获取当前时间的时间元组    时间戳 -> 时间元组
    tupleTime1 = time.localtime()
    print("tupleTime1 = ",tupleTime1)

    tupleTime2 = time.localtime(1538271871.226226)
    print("tupleTime2 = ",tupleTime2)

    # 时间戳->时间元组 time.gmtime(时间戳)
    mygmtime = time.gmtime(time.time())
    print("mygmtime = ",mygmtime)

    # 时间元组 -> 时间戳  calendar.timegm(时间元组)
    mytimegm = calendar.timegm(mygmtime)
    print("mytimegm = ",mytimegm)

    time.sleep(2)

    # 时间戳 -> 可视化时间
    myctime1 = time.ctime(1538271871.226226)
    myctime2 = time.ctime()  # 默认当前时间的时间戳
    print("myctime1 = ",myctime1)
    print("myctime2 = ",myctime2)

    time.sleep(3)
    # 时间元组 -> 时间戳
    # 1538271871
    mymktime1 = time.mktime((2018, 9, 30, 9, 44, 31, 6, 273, 0))
    mytupletime = time.localtime()
    mymktime2 = time.mktime((mytupletime.tm_year,
                             mytupletime.tm_mon,
                             mytupletime.tm_mday,
                             mytupletime.tm_hour,
                             mytupletime.tm_min,
                             mytupletime.tm_sec,
                             mytupletime.tm_wday,
                             mytupletime.tm_yday,
                             mytupletime.tm_isdst))
    myasctime = time.asctime(mytupletime)

    print("mymktime1 = ",mymktime1)
    print("mymktime2 = ",mymktime2)
    print("myasctime = ",myasctime)

    time.sleep(4)
    # 时间元组 → 可视化时间（定制） strftime
    myformattime1 = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime())
    myformattime2 = time.strftime("%A %B %d %H:%M:%S %Y",time.localtime())
    print("myformattime1 = ",myformattime1)
    print("myformattime2 = ",myformattime2)

    time.sleep(5)
    # 可视化时间（定制） → 时间元祖
    mytupletime = time.strptime('2018-9-30 11:32:23', '%Y-%m-%d %H:%M:%S')
    print("mytupletime = ",mytupletime)

结果：
mytime =  1600754857.790401
tupleTime1 =  time.struct_time(tm_year=2020, tm_mon=9, tm_mday=22, tm_hour=14, tm_min=7, tm_sec=38, tm_wday=1, tm_yday=266, tm_isdst=0)
tupleTime2 =  time.struct_time(tm_year=2018, tm_mon=9, tm_mday=30, tm_hour=9, tm_min=44, tm_sec=31, tm_wday=6, tm_yday=273, tm_isdst=0)
mygmtime =  time.struct_time(tm_year=2020, tm_mon=9, tm_mday=22, tm_hour=6, tm_min=7, tm_sec=38, tm_wday=1, tm_yday=266, tm_isdst=0)
mytimegm =  1600754858
myctime1 =  Sun Sep 30 09:44:31 2018
myctime2 =  Tue Sep 22 14:07:40 2020
mymktime1 =  1538271871.0
mymktime2 =  1600754863.0
myasctime =  Tue Sep 22 14:07:43 2020
myformattime1 =  2020-09-22 14:07:47
myformattime2 =  Tuesday September 22 14:07:47 2020
mytupletime =  time.struct_time(tm_year=2018, tm_mon=9, tm_mday=30, tm_hour=11, tm_min=32, tm_sec=23, tm_wday=6, tm_yday=273, tm_isdst=-1)


```





## calendar  日历相关

``` python

import  calendar

'''
默认参数 w l c m
w:  连续day之间的空格
l:  每周之间间隔几行？
c:  每月之间间隔的空格
m:
'''
if __name__ == '__main__':

    #打印出某个月的信息
    month = calendar.month(2020,9,w=2,l=1)
    print(month)

    # 打印出某年的信息
    mycalendar = calendar.calendar(2020,w = 2 , l = 1 , c = 6)
    print("mycalendar : \n",mycalendar)


    # 判断是否为闰年
    isleap1 = calendar.isleap(2000)
    isleap2 = calendar.isleap(2020)
    print("isleap1 = ",isleap1)
    print("isleap2 = ",isleap2)

    # 计算 year1 到year2之间有多少个闰年
    leaps = calendar.leapdays(2000,2020)
    print("leaps = ",leaps)

    # 获取当月的详细信息
    myMonth = calendar.month(2020, 9, w=2, l=1)
    print("myMonth is: \n",myMonth)

    mymonthcalendar = calendar.monthcalendar(2020,9)
    print(mymonthcalendar)

    # 获取当月是周几开始（0-6）和 一共有多少天
    mymonthrange = calendar.monthrange(2020, 10)
    print("mymonthrange = " ,mymonthrange)

    # 获取指定日期的周几
    myweekday = calendar.weekday(2020, 9, 22)
    print("myweekday = ",myweekday)

结果： 
   September 2020
Mo Tu We Th Fr Sa Su
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30

mycalendar : 
                                   2020

      January                   February                   March
Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su
       1  2  3  4  5                      1  2                         1
 6  7  8  9 10 11 12       3  4  5  6  7  8  9       2  3  4  5  6  7  8
13 14 15 16 17 18 19      10 11 12 13 14 15 16       9 10 11 12 13 14 15
20 21 22 23 24 25 26      17 18 19 20 21 22 23      16 17 18 19 20 21 22
27 28 29 30 31            24 25 26 27 28 29         23 24 25 26 27 28 29
                                                    30 31

       April                      May                       June
Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su
       1  2  3  4  5                   1  2  3       1  2  3  4  5  6  7
 6  7  8  9 10 11 12       4  5  6  7  8  9 10       8  9 10 11 12 13 14
13 14 15 16 17 18 19      11 12 13 14 15 16 17      15 16 17 18 19 20 21
20 21 22 23 24 25 26      18 19 20 21 22 23 24      22 23 24 25 26 27 28
27 28 29 30               25 26 27 28 29 30 31      29 30

        July                     August                  September
Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su
       1  2  3  4  5                      1  2          1  2  3  4  5  6
 6  7  8  9 10 11 12       3  4  5  6  7  8  9       7  8  9 10 11 12 13
13 14 15 16 17 18 19      10 11 12 13 14 15 16      14 15 16 17 18 19 20
20 21 22 23 24 25 26      17 18 19 20 21 22 23      21 22 23 24 25 26 27
27 28 29 30 31            24 25 26 27 28 29 30      28 29 30
                          31

      October                   November                  December
Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su      Mo Tu We Th Fr Sa Su
          1  2  3  4                         1          1  2  3  4  5  6
 5  6  7  8  9 10 11       2  3  4  5  6  7  8       7  8  9 10 11 12 13
12 13 14 15 16 17 18       9 10 11 12 13 14 15      14 15 16 17 18 19 20
19 20 21 22 23 24 25      16 17 18 19 20 21 22      21 22 23 24 25 26 27
26 27 28 29 30 31         23 24 25 26 27 28 29      28 29 30 31
                          30

isleap1 =  True
isleap2 =  True
leaps =  5
myMonth is: 
    September 2020
Mo Tu We Th Fr Sa Su
    1  2  3  4  5  6
 7  8  9 10 11 12 13
14 15 16 17 18 19 20
21 22 23 24 25 26 27
28 29 30

[[0, 1, 2, 3, 4, 5, 6], [7, 8, 9, 10, 11, 12, 13], [14, 15, 16, 17, 18, 19, 20], [21, 22, 23, 24, 25, 26, 27], [28, 29, 30, 0, 0, 0, 0]]
mymonthrange =  (3, 31)
myweekday =  1

```

