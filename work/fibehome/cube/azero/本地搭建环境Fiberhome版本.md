

# 本地 python 技能调试环境搭建说明-Fiberhome版本



## python安装：

### windows

- 1.1 下载官网python3.6.8 解压免安装版本。

 下载地址：https://www.python.org/ftp/python/3.6.8/python-3.6.8-embed-amd64.zip

- 1.2 解压后，添加路径 环境变量=》系统变量PATH 最前面

 例如：D:\installsoftware\developer\Python\python-3.6.8\

- 1.3 安装pip工具
  - 删除python安装目录中的python36._pth
  - 通过https://bootstrap.pypa.io/get-pip.py下载pip脚本(项目根目录中已经存在了)
  - get-pip.py所在目录执行命令“python get-pip.py”
  - 添加路径 环境变量=》系统变量PATH: “D:\installsoftware\developer\Python\python-3.6.8\Scripts\”

### 验证是否按照python成功

执行如下两条命令：

``` python
$ python -V
Python 3.6.10

$ pip -V
pip 18.1 from /opt/python3.6/lib/python3.6/site-packages/pip (python 3.6)
```

若得到类似输出，则代表安装成功。**特别注意pip版本、路径与前面步骤安装的版本一致**。



## 获取azero本地调试项目并搭建环境

### 获取版本



``` python
https://github.com/sai-azero/azero-skills-kit-sdk-for-python
```



### 安装项目根目录下lib中的所有安装包

(在lib目录下执行pip install xxx.tar.gz)，例如:

```python
pip install azero-sdk-2.0.2.tar.gz
pip install azero-sdk-util-1.0.3.tar.gz
pip install azero-sdk-mongodb-persistence-adapter-1.0.1.tar.gz
```

### 安装必要库：

```python
pip install -r requirements.txt
```

注意：如果某个库无法下载，请删除requirements.txt中的库的版本号。



### 运行python SDK并使用postman测试



#### 运行python SDK

执行如下命令。

```python
$ python app.py 
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
INFO:werkzeug: * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

若得到同样输出，或使用浏览器访问所提示的网址，看到“启动成功”字样，则代表运行成功。



#### 使用postman测试

保持python SDK运行，使用postman使用POST方法发送如下json串到地址http://127.0.0.1:5000/skill/sample *注：skill/sample与index.py所在路径保持一致*

``` python
{
	"version": "1.0",
	"session": {
		"new": true,
		"sessionId": "token.domain-api.session.5e3c1a35d8dafe00060beec8",
		"application": {
			"applicationId": "5e37d715a521820008e9a3f0"
		},
		"user": {
			"userId": "anonymous_2b861255e642461f9d89ad332da6e370"
		},
		"attributes": {
			"source_skill_mapping": {},
			"smarthome_skill_mapping": {},
			"ip": "114.220.24.57"
		}
	},
	"context": {
		"System": {
			"application": {
				"applicationId": "5e37d715a521820008e9a3f0"
			},
			"user": {
				"userId": "anonymous_2b861255e642461f9d89ad332da6e370"
			},
			"device": {
				"deviceId": "52e877f4956ba650dadb3185a3b54746",
				"supportedInterfaces": {
					"AudioPlayer": {},
					"Display": {}
				}
			}
		}
	},
	"request": {
		"type": "IntentRequest",
		"requestId": "e4308cca-6e8f-488b-a365-da70453972cf",
		"timestamp": "2020-02-14T00:52:53.541Z",
		"dialogState": "COMPLETED",
		"intent": {"如果需要命中意图并获取意图标识以及槽位信息在这里处理"}    
	}
}
```



![postman ](G:\笔记\Notes\work\fibehome\cube\azero\image\postman .jpg)



#### 遇到问题



第一次使用postman 会报错

![第一次postman请求报错](G:\笔记\Notes\work\fibehome\cube\azero\image\第一次postman请求报错.png)

服务器报错

![第一次postman请求报错-02](G:\笔记\Notes\work\fibehome\cube\azero\image\第一次postman请求报错-02.png)

原因：在azero本地调试的项目工程中的index.py文件中的IntentRequestHandler 使用了Mongodb持久化的功能，将对于的代码注释掉即可。

![注释掉MongoDB代码](G:\笔记\Notes\work\fibehome\cube\azero\image\注释掉MongoDB代码.png)



注释代码后再postman试试

![注释MongoDB代码后尝试-ok](G:\笔记\Notes\work\fibehome\cube\azero\image\注释MongoDB代码后尝试-ok.png)



修改index中的代码后再试试，

修改如下：

![修改index中代码](G:\笔记\Notes\work\fibehome\cube\azero\image\修改index中代码.png)



postman测试结果

![修改后postman测试ok](G:\笔记\Notes\work\fibehome\cube\azero\image\修改后postman测试ok.png)



## 强化调试手段 （重点）

上面的测试都只能走到每个技能的IntentRequestHandler 类中的handle方法中，那么怎么走到我们自定义的意图中呢？

### 调试自定义的意图

比如：自定义意图

![自定义意图python代码](G:\笔记\Notes\work\fibehome\cube\azero\image\自定义意图python代码.png)

再看看postman 请求json数据中的request字段：

![postman请求josn数据request字段调试自定义意图代码](G:\笔记\Notes\work\fibehome\cube\azero\image\postman请求josn数据request字段调试自定义意图代码.png)

​	注意：intent中添加了 "name":"test"

注意： 

​	json中的type 就是python代码can_handle方法中的request_type

​	json中的dialogState就是python代码can_handle方法中的dialog_state

​	json中的name就是python代码can_handle方法中的intent_name



postman测试结果

![postman测试自定义意图代码](G:\笔记\Notes\work\fibehome\cube\azero\image\postman测试自定义意图代码.png)





###调试自定义意图标识和字典标识

#### 疑问：

 在python代码中需要获取意图标识和词典标识的时候，使用postman中的json数据如何配置呢？

1- 意图标识：

​	上面“调试自定义的意图” 中 postman json数据intent下新添加的 "name":"test" ， test就是意图标识；

2- 字典标识：

​	首先在azero平台测试中可以获取到槽位的格式

![槽位标识-意图标识](G:\笔记\Notes\work\fibehome\cube\azero\image\槽位标识-意图标识.png)

​	槽位信息的json格式为：

``` json
"intent": {
            "slots": {
                "airconditioner": {
                    "confirmationStatus": "CONFIRMED",
                    "name": "airconditioner",
                    "value": "livingAirConditioner_219_cloud"
                }
            },
            "name": "open_1"
        }
```



将slots数据放到postman请求的json格式的数据中

![postman中添加槽位信息](G:\笔记\Notes\work\fibehome\cube\azero\image\postman中添加槽位信息.png)





#### python代码

##### 1- 添加引用

``` python
"""自定义模板需要的依赖 开始"""
from azero_sdk_model.interfaces.display.image_instance import ImageInstance
from azero_sdk_model.interfaces.display.image import Image

from azero_sdk_model.interfaces.display.default_template_data import DefaultTemplateData
from azero_sdk_model.interfaces.display.ext_content import ExtContent
from azero_sdk_model.interfaces.display.title import Title

"""自定义模板需要的依赖 结束"""
```



![自定义意图代码-01](G:\笔记\Notes\work\fibehome\cube\azero\image\自定义意图代码-01.png)

##### 2- 使用自定义意图返回模板

DefaulTemplateData()

``` python
speakOutput = '好哒'
        myDictData = getMyDictData(handler_input)

        return (
            handler_input.response_builder.add_directive(
                RenderTemplateDirective(
                    DefaultTemplateData(
                        ext_content=ExtContent(data=myDictData, type="type", tts_text="TTSText", asr_text="ASRText")
                    )
                ))
                .speak(speakOutput)
                .set_should_end_session(True)
                .response
        )
```



![自定义意图代码-02](G:\笔记\Notes\work\fibehome\cube\azero\image\自定义意图代码-02.png)



##### 3- 抽取的getMyDictData方法

``` python

def getMyDictData(handler_input):
    currentIntent = handler_input.request_envelope.request.intent
    name = currentIntent.name
    attributes = handler_input.request_envelope.session.attributes

    airconditioner = azero_utils.get_slot_value(handler_input, 'airconditioner')
    temperature = azero_utils.get_slot_value(handler_input, 'temperature')
    timeMin = azero_utils.get_slot_value(handler_input, "timeMin")
    timeHour = azero_utils.get_slot_value(handler_input, "timeHour")


    # 获取ASR
    content = ''
    if attributes is not None:
        if 'asr_text' in attributes:
            content = attributes['asr_text']

    airItems = airconditioner.split("_")
    nameItems = name.split("_")

    airItems[1] = airItems[1] + nameItems[1]
    airItems.append(nameItems[0])
    name = "_".join(airItems)

    myDictData = {}
    myDictData["name"] = name
    myDictData["temperature"] = temperature
    myDictData["content"] = content
    myDictData["timeMin"] = timeMin
    myDictData["timeHour"] = timeHour

    return myDictData
```



![自定义意图代码-03](G:\笔记\Notes\work\fibehome\cube\azero\image\自定义意图代码-03.png)



#### postman调试

``` json
{
	"version": "1.0",
	"session": {
		"new": true,
		"sessionId": "token.domain-api.session.5e3c1a35d8dafe00060beec8",
		"application": {
			"applicationId": "5e37d715a521820008e9a3f0"
		},
		"user": {
			"userId": "anonymous_2b861255e642461f9d89ad332da6e370"
		},
		"attributes": {
			"source_skill_mapping": {},
			"smarthome_skill_mapping": {},
			"ip": "114.220.24.57"
		}
	},
	"context": {
		"System": {
			"application": {
				"applicationId": "5e37d715a521820008e9a3f0"
			},
			"user": {
				"userId": "anonymous_2b861255e642461f9d89ad332da6e370"
			},
			"device": {
				"deviceId": "52e877f4956ba650dadb3185a3b54746",
				"supportedInterfaces": {
					"AudioPlayer": {},
					"Display": {}
				}
			}
		}
	},
	"request": {
		"type": "IntentRequest",
		"requestId": "e4308cca-6e8f-488b-a365-da70453972cf",
		"timestamp": "2020-02-14T00:52:53.541Z",
		"dialogState": "COMPLETED",
		"intent": {
            "slots": {
                "airconditioner": {
                    "confirmationStatus": "CONFIRMED",
                    "name": "airconditioner",
                    "value": "livingAirConditioner_219_cloud"
                }
            },
            "name":"open_1"
        }
	}
}

```



![自定义意图-字典postman测试结果](G:\笔记\Notes\work\fibehome\cube\azero\image\自定义意图-字典postman测试结果.png)



