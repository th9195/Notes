# 编译jar包-并引用



## 编译JAR包

### 创建工程

​		01- 创建工程01

![创建工程](G:\笔记\Notes\java\IDEA\image\创建工程.png)

​		02- 创建工程02

![创建工程02](G:\笔记\Notes\java\IDEA\image\创建工程02.png)

​		03- 创建工程03

![创建工程03](G:\笔记\Notes\java\IDEA\image\创建工程03.png)

​		04- 生成的工程

![生成的工程](G:\笔记\Notes\java\IDEA\image\生成的工程.png)

​		05- 修改类名

![修改类名](G:\笔记\Notes\java\IDEA\image\修改类名.png)

​		06-编写新增接口代码

![编写新增接口方法](G:\笔记\Notes\java\IDEA\image\编写新增接口方法.png)

### 设置模块编译JAR包

file->

​	ProjectStructure->

​		ProjectSetting->

​			Artifacts->

​				"+"->

​					JAR->

​						from moudles with dependencxxx ->

![设置编译jar模板](G:\笔记\Notes\java\IDEA\image\设置编译jar模板.png)

![设置编译jar模板02](G:\笔记\Notes\java\IDEA\image\设置编译jar模板02.png)



### 编译

​	Build-> Build Artifacts...->Build



### 生成的jar包

![生成的jar包](G:\笔记\Notes\java\IDEA\image\生成的jar包.png)





## 使用jar包



### 创建使用jar包工程

![创建使用jar包工程](G:\笔记\Notes\java\IDEA\image\创建使用jar包工程.png)

### 配置工程保证可正常运行

Edit Configuratios->"+"->Application

![先保证工程科正常执行](G:\笔记\Notes\java\IDEA\image\先保证工程科正常执行.png)



### 添加jar包

file->

​	ProjectStructure->

​		ProjectSetting->

​			Libraries->

​				"+" ->

​					java ->

01- 配置新增jar包

![添加jar包](G:\笔记\Notes\java\IDEA\image\添加jar包.png)



02- 新增jar包后查看

![新增jar包后显示](G:\笔记\Notes\java\IDEA\image\新增jar包后显示.png)



03- 使用jar包中的接口方法

![编写java代码引用jar包中的接口](G:\笔记\Notes\java\IDEA\image\编写java代码引用jar包中的接口.png)