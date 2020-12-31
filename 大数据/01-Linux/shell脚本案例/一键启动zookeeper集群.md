## 一键启动zookeeper集群

``` shell
#!/bin/bash

## 所有zookeeper 服务列表
myArrNodes=("node1" "node2" "node3")

echo "欢迎使用一键安装zookeeper集群"
PS3="Please enter you choice:"
select operation in "start" "status" "stop"
do
	case ${operation} in 
	"start")
		echo "you have chose "${operation}
		;;
		
	"status")
		echo "you have chose "${operation}
		;;
		
	"stop")
		echo "you have chose "${operation}
		;;
		
	*)
		echo "You have chose error , Please try again!"
		continue
		;;
		
	esac

break;
done

echo "*****************${operation}*****************"

# source /etc/profile 命令
commandSource="source /etc/profile"

# ZK 命令
commandZKServer="zkServer.sh"

# 判断环境变量中是否有ZK的命令
if ! grep "ZOOKEEPER_HOME" /etc/profile
then
	# 如果没有配置环境变量需要使用全路径执行命令
	commandZKServer="/export/server/zookeeper-3.4.6/bin/"${commandZKServer}
fi

# 遍历所有服务并执行命令
for node in ${myArrNodes[@]} 
do 
	ssh ${node} "${commandSource} ; ${commandZKServer} ${operation}"	
	echo "----------${operation} ${node} ok----------"
done

echo "*****************end ${operation}*****************"


```

