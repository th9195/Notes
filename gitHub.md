## 1- 创建仓库

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













