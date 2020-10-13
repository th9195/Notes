# -*- coding: utf-8 -*-
# @Time : 2020/10/13 10:27 上午
# @Author : tanghui
# @FileName: GetConstellation.py
# @Email : tanghui20_10@163.com
# @Software: PyCharm

# @Blog ：https://github.com/th9195/Notes


sdate = [20,19,21,20,21,22,23,23,23,24,23,22]

conts =['摩羯座','水瓶座','双鱼座','白羊座','金牛座','双子座','巨蟹座','狮子座','处女座','天秤座','天蝎座','射手座','摩羯座']

signs=['♑','♒','♓','♈','♉','♊','♋','♌','♍','♎','♏','♐','♑']


def sign(cmonth, cday):
    if cday < sdate[cmonth - 1] :
        print(conts[cmonth -1])
        print(signs[cmonth -1])
    else:
        print(conts[cmonth])
        print(signs[cmonth])




def getYouConstellation():
    birth = input("请输入您的出生日期,格式：2001-02-21\n").strip(" ")  # 去掉首位空格
    cbir = birth.split("-")

    if len(cbir) == 3 and cbir[1].isnumeric() and cbir[2].isnumeric():
        cmonth = int(cbir[1])
        cday = int(cbir[2])
        sign(cmonth,cday)
    else:
        print("您输入有误，请重试！")
        getYouConstellation()







if __name__ == '__main__':

    s1 = "000010"
    print(int(s1))

    getYouConstellation()