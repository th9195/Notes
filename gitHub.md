

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

or git push   (后期可以直接使用这个即可)OK





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



