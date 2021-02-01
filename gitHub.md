

## 账号

th9195

th448725485



## 创建仓库

https://github.com/th9195?tab=repositories

1. new repositories

![截屏2020-09-02 下午7.12.49](/Users/tanghui/Desktop/截屏2020-09-02 下午7.12.49.png)



2. 填写 repository name 和 Description

   ![截屏2020-09-02 下午7.14.05](/Users/tanghui/Desktop/截屏2020-09-02 下午7.14.05.png)



3. 获取给仓库的url
   
   1. https://github.com/th9195/Notes.git
   
   







## 在本地选中一个目录执行以下命令

``` python
echo "# Notes" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M master
git remote add origin https://github.com/th270/Notes.git
git push -u origin master
```



## 克隆 clone

``` python
git clone https://github.com/th9195/Notes.git

```



## 更新本地代码

git pull 



## 提交代码

git add .

git commit -m "添加注释"

git push origin master

或者  git push   (后期可以直接使用这个即可)OK





注意： 每次提交代码的时候需要先 git pull ,  再 git push.









​	git pull的时候发生冲突的解决方法之“error: Your local changes to the following files would be overwritten by merge”

##  方法二、放弃本地修改，直接覆盖

```
1 git reset --hard
2 git pull
```





如果希望保留生产服务器上所做的改动,仅仅并入新配置项, 处理方法如下:

git stash
git pull
git stash pop
然后可以使用git diff -w +文件名 来确认代码自动合并的情况.





反过来,如果希望用代码库中的文件完全覆盖本地工作版本. 方法如下:
git reset --hard
git pull
其中git reset是针对版本,如果想针对文件回退本地修改,使用







## 创建一个文件

``` python

mkdir day01
touch day01/readme.md

git add day01/readme.md

git commit -m "add new file"
git push origin master

例如：
(base) tanghuideMacBook-Pro:java tanghui$ mkdir day01
(base) tanghuideMacBook-Pro:java tanghui$ touch day01/readme.md
(base) tanghuideMacBook-Pro:java tanghui$ 
(base) tanghuideMacBook-Pro:java tanghui$ 
(base) tanghuideMacBook-Pro:java tanghui$ git add day01/readme.md
(base) tanghuideMacBook-Pro:java tanghui$ git commit -m "add new files"
[master e8f9a8f] add new files
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 java/day01/readme.md
(base) tanghuideMacBook-Pro:java tanghui$ git push origin master
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (5/5), 368 bytes | 368.00 KiB/s, done.
Total 5 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/th9195/Notes.git
   db3173c..e8f9a8f  master -> master
(base) tanghuideMacBook-Pro:java tanghui$ 
```





## 删除一个文件

``` python
rm day01/readme.md
git commit -m remove day01/readme.md
git push origin master
git push origin master


----------------------------------------------------
例如：
(base) tanghuideMacBook-Pro:java tanghui$ rm day01/readme.md 
(base) tanghuideMacBook-Pro:java tanghui$ git commit -m remove day01/readme.md
[master c215fee] remove
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 java/day01/readme.md
(base) tanghuideMacBook-Pro:java tanghui$ git push origin master
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 280 bytes | 280.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/th9195/Notes.git
   e8f9a8f..c215fee  master -> master
(base) tanghuideMacBook-Pro:java tanghui$ 
```







## 新电脑怎么使用git 

1- 下载git 默认安装即可；

2- 配置用户名邮箱

``` sql
git config --global user.name  "th9195"  
git config --global user.email  "tanghui20_10@163.com"

在用户下查看：
C:\Users\tanghui\.gitconfig 文件
[user]
	email = tanghui20_10@163.com
	name = th9195
```



3- 配置ssh

``` sql
 ssh-keygen -t rsa -C "tanghui20_10@163.com"
 
 C:\Users\tanghui\.ssh\目录下，看看有没有.ssh目录，如果有，再看看这个目录下有没有id_rsa和id_rsa.pub这两个文件
 id_rsa 是私钥，不能泄露出去;
 id_rsa.pub是公钥
 
```



4- 登陆GitHub，打开 头像-> settings->SSH and GPG keys，“SSH Keys”页面：

然后，点“New SSH Key”，填上任意Title，在Key文本框里粘贴id_rsa.pub文件的内容：



5- 去你的仓库copy SSH url 

```sql
git@github.com:th9195/Notes.git
```



6- 在新电脑上克隆

``` sql
git clone git@github.com:th9195/Notes.git
```







## 创建分支

### 1- 创建
$ git branch newbranch
然后输入这条命令检查是否创建成功



### 2- 查看
$ git branch
这时终端输出

 newbranch
\* master
这样就创建成功了，前面的*代表的是当前你所在的工作分支。我们接下来就要切换工作分支。



### 3- 切换分支
$ git checkout newbranch
这样就切换完了，可以 $ git branch 确认下。然后你要将你的改动提交到新的分支上。



### 4- 提交新代码
$ git add .
$ git commit -a
此时可以 $ git status 检查下提交情况。如果提交成功，我们接下来就要回主分支了，代码和之前一样。



### 5- 切换到主分支
$ git checkout master
然后我们要将新分支提交的改动合并到主分支上



### 6- 合并代码

$ git merge newbranch
合并分支可能产生冲突这是正常的，虽然我们这是新建的分支不会产生冲突，但还是在这里记录下。下面的代码可以查看产生冲突的文件，然后做对应的修改再提交一次就可以了。


$ git diff
我们的问题就解决了，接下来就可以push代码了。


$ git push -u origin master
新建分支的朋友别忘了删除这个分支


$ git branch -D newbranch