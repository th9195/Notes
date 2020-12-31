

## 一键安装JDK



``` shell
#!/bin/bash

## 1- 先卸载centos中自带的jdk

oldjava=$(rpm -qa | grep java)
for old in ${oldjava}
do
	echo "uninstall"${old}
	$(rpm -e -nodeps ${old})
done

## 2- 判断安装目录 /export/servers 目录是否存在，如果存在就直接安装， 如果不存在需要新建一个
installPath="/export/jdkservers/"
softwarePath="/export/software"
if [ ! -d ${installPath} ] ;then
	#$(mkdir -p ${installPath})
	mkdir -p ${installPath}
fi

## 3- 解压jdk
tar -xzvf ${softwarePath}"/"$1 -C ${installPath}

## 4- 拼接jdk安装的全路径
jdk_installSubPath=$(ls ${installPath} | grep jdk)
jdk_installPath=${installPath}${jdk_installSubPath}
echo "jdk 安装全路径:"${jdk_installPath}

## 5- 配置环境变量
pathFile="/etc/profile"

if ! grep "JAVA_HOME" /etc/profile 
then
	
	echo '# my java jdk 环境变量' >> ${pathFile}
	
	echo "export JAVA_HOME="${jdk_installPath} >> ${pathFile}
	
	echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ${pathFile}
fi


## 6- 加载环境变量
source /etc/profile

## 7- 测试
java -version



测试命令：
[root@tanghui export]# jdk_install jdk-8u241-linux-x64.tar.gz 
```

