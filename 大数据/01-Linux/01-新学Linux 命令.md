## Linux 命令



### find指令
用于查找符合条件的文件
示例：

``` sql
find / -name 'ins*' #查找/目录下以文件名ins开头的文件 
find / -type f -size +100M #查找/目录下文件大小大于100M的文件
```



### grep命令
``` javascript
grep 命令可以对文件进行文本查询
grep lang anaconda-ks.cfg #在文件中查找lang
```



### 用户创建和密码设置

useradd 用户名
passwd  用户名

```  javascript
useradd  itheima #创建新用户itheima
passwd  itheima #设置用户itheima密码
```





### 用户删除
``` javascript
user -r 用户名
userdel -r itheima #删除用户itheima
```



### 网络状态查看命令netstat
``` javascript
netstat -nltp
```



### systemctl命令

``` javascript
systemctl start 服务名	开启服务
systemctl stop 服务名	关闭服务
systemctl status 服务名	显示服务状态
systemctl enable 服务名	设置开机自启动
systemctl disable 服务名	关闭开机自启动
```



### 网络操作

``` javascript
systemctl status network   # 查看网络服务状态 
systemctl stop network     # 停止网络服务
systemctl start network     # 启动网络服务
systemctl restart network   # 重启网络服务
```



### 防火墙操作
``` javascript
systemctl stop firewalld.service          #停止firewall
systemctl disable firewalld.service       #禁止firewall开机启动
systemctl status firewalld.service        #查看防火墙状态
```





### vim 命令行模式常用命令

| 命令 | 功能                        |
| ---- | --------------------------- |
| o    | 在当前行后面插入一空行      |
| O    | 在当前行前面插入一空行      |
| dd   | 删除光标所在行              |
| ndd  | 从光标位置向下连续删除 n 行 |
| yy   | 复制光标所在行              |
| nyy  | 从光标位置向下连续复制n行   |
| p    | 粘贴                        |
| u    | 撤销上一次命令              |
| gg   | 回到文件顶部                |
| G    | 回到文件末尾                |
| /str | 查找str                     |



### vim 底行模式常用命令

#### 设置行号

``` javascript
:set nu 	设置行号
```



#### 文本替换

``` javascript
:%s/旧文本/新文本/g	 文本替换
```



#### 显示高亮

``` sql

```



#### 取消高亮

``` sql
linux vim取消高亮显示:
:nohl即可
```



### curl命令行下直接获取当前IP信息



#### curl cip.cc

``` javascript
[root@node01 ~]# curl cip.cc
IP	: 223.104.20.95
地址	: 中国  湖北  移动

数据二	: 湖北省 | 移动数据上网公共出口

数据三	: 

URL	: http://www.cip.cc/223.104.20.95
[root@node01 ~]# 

```



#### curl -L tool.lu/ip

``` javascript
[root@node01 ~]# curl -L tool.lu/ip
当前IP: 223.104.20.95
归属地: 中国 湖北省 武汉市
[root@node01 ~]# 

[root@node01 ~]# curl -L https://tool.lu/ip
当前IP: 223.104.20.95
归属地: 中国 湖北省 武汉市
[root@node01 ~]# 


```



#### curl myip.ipip.net

``` javascript
[root@node01 ~]# curl myip.ipip.net
当前 IP：223.104.20.95  来自于：中国 湖北   移动
[root@node01 ~]# 

```



#### curl ipinfo.io

``` javascript
[root@node01 ~]# curl ipinfo.io
{
  "ip": "223.104.20.95",
  "city": "Wuhan",
  "region": "Hubei",
  "country": "CN",
  "loc": "30.5833,114.2667",
  "org": "AS9808 Guangdong Mobile Communication Co.Ltd.",
  "timezone": "Asia/Shanghai",
  "readme": "https://ipinfo.io/missingauth"
}[root@node01 ~]# 

```



