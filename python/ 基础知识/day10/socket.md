# 网络编程



## Server 

``` python
import  socket
import sys


def startServer():

    # 创建socket对象
    serverSocket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

    # 获取本地主机名
    host = "127.0.0.1"

    port = 9999

    # 绑定端口号
    serverSocket.bind((host,port))

    # 设置最大连接数， 超过后排队
    serverSocket.listen(5)

    while True:

        # 建立客户端连接
        print("灯带客户端连接：")
        clientsocket ,addr = serverSocket.accept()

        print("连接地址: %s" % str(addr))

        msg = "欢迎来到我家做客！\r\n"

        while True:
            clientsocket.send(msg.encode('utf-8'))
            msg = input("you say:")
            if "exit" == msg:
                break;


        clientsocket.close()
```





## Client

``` python
import  socket
import sys
import  time

def startClient():
    host = "127.0.0.1"
    port = 9999
    buffersize = 1024
    addr = (host,port)

    clientSocket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

    clientSocket.connect(addr)

    time.sleep(1)

    while True:
        data = clientSocket.recv(buffersize)
        str = data.decode("utf-8")
        if "exit"==str:
            break;
        print(str)


    clientSocket.close()
```

