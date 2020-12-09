<div align="right">
<img src="./soundai.png" height = "30" alt="SoundAI" align=middle />
</div>

# 本地 python 技能调试环境搭建说明

### python环境准备：

#### python安装：
推荐到官网下载安装，**需3.6.8以上版本**.
地址：https://www.python.org/downloads/
Ubuntu系统自带版本可能存在兼容性问，使用前请确保环境中python与pip版本一致，确认方法见下文。

windows与Ubuntu安装方式存在差别，具体如下：
###### windonws:

* 1.1 下载官网python3.6.8 解压免安装版本。

​		下载地址：https://www.python.org/ftp/python/3.6.8/python-3.6.8-embed-amd64.zip

* 1.2 解压后，添加路径 环境变量=》系统变量PATH  最前面

​		例如：D:\installsoftware\developer\Python\python-3.6.8\

* 1.3 安装pip工具
    * 删除python安装目录中的python36._pth
    * 通过https://bootstrap.pypa.io/get-pip.py下载pip脚本(项目根目录中已经存在了)
    * get-pip.py所在目录执行命令“python get-pip.py”
    * 添加路径 环境变量=》系统变量PATH: 
    “D:\installsoftware\developer\Python\python-3.6.8\Scripts\”

###### Ubuntu 16.04:
* 1.1 到python官网下载python源码包，3.6.8以上版本，此处使用的版本为3.6.10:
https://www.python.org/downloads/
* 1.2 下载完成解压后，编译并安装，此处选择的安装路径为/opt/python3.6，也可根据需要自行选择其它安装路径。
```
$ ./configure --prefix=/opt/python3.6
$ make
$ make install
```
若提示Permission denied等权限问题，在命令前添加sudo即可。
* 1.3 添加环境变量。在/etc/profile文件最后一行添加：
```
export PATH=$PATH:/opt/python3.6/bin
```
重启后生效，也可手动通过source命令确保生效。
* 1.4 建立软链接
```
$ cd /opt/python3.6/bin
$ sudo ln -s python3.6 python
$ sudo ln -s pip pip3
$ sudo ln -s pip3 pip
```
###### 确认版本：
执行如下两条命令：
```
$ python -V
Python 3.6.10

$ pip -V
pip 18.1 from /opt/python3.6/lib/python3.6/site-packages/pip (python 3.6)
```
若得到类似输出，则代表安装成功。**特别注意pip版本、路径与前面步骤安装的版本一致**。
### 安装项目根目录下lib中的所有安装包(在lib目录下执行pip install xxx.tar.gz)，例如:

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
##### 运行python SDK
执行如下命令。
```
$ python app.py 
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
INFO:werkzeug: * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)

```
若得到同样输出，或使用浏览器访问所提示的网址，看到“启动成功”字样，则代表运行成功。
##### 使用postman测试
保持python SDK运行，使用postman使用POST方法发送如下json串到地址http://127.0.0.1:5000/skill/sample
*注：skill/sample与index.py所在路径保持一致*

```
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
		"intent": {}
	}
}
```
##### 使用curl测试
保持python SDK运行，使用curl方法
*注：skill/sample与index.py所在路径保持一致*
```
curl -H "Content-Type:application/json" -X POST -d '{"version":"1.0","session":{"new":true,"sessionId":"token.domain-api.session.5e3c1a35d8dafe00060beec8","application":{"applicationId":"5e37d715a521820008e9a3f0"},"user":{"userId":"anonymous_2b861255e642461f9d89ad332da6e370"},"attributes":{"source_skill_mapping":{},"smarthome_skill_mapping":{},"ip":"114.220.24.57"}},"context":{"System":{"application":{"applicationId":"5e37d715a521820008e9a3f0"},"user":{"userId":"anonymous_2b861255e642461f9d89ad332da6e370"},"device":{"deviceId":"52e877f4956ba650dadb3185a3b54746","supportedInterfaces":{"AudioPlayer":{},"Display":{}}}}},"request":{"type":"IntentRequest","requestId":"e4308cca-6e8f-488b-a365-da70453972cf","timestamp":"2020-02-14T00:52:53.541Z","dialogState":"COMPLETED","intent":{}}}' \
"http://127.0.0.1:5000/skill/sample"
```
得到的返回如下，代表本地python技能调试环境搭建完成。
```
{
    "response": {
        "directives": [
            {
                "template": {
                    "textContent": {
                        "primaryText": {
                            "text": "欢迎使用技能",
                            "type": "PlainText"
                        }
                    },
                    "title": "欢迎使用技能",
                    "type": "BodyTemplate1"
                },
                "type": "Display.RenderTemplate"
            }
        ],
        "outputSpeech": {
            "ssml": "<speak>欢迎使用技能</speak>",
            "type": "SSML"
        },
        "shouldEndSession": true
    },
    "sessionAttributes": {
        "ip": "114.220.24.57",
        "smarthome_skill_mapping": {},
        "source_skill_mapping": {}
    },
    "userAgent": "ask-python/1.13.0 Python/3.6.10 ask-webservice flask-ask-sdk",
    "version": "1.0"
}
```
## 相关组件介绍

#### azero-sdk-util-*.tar.gz 自定义工具组件

支持以下功能：

​	**技能日志**

​	使用样例：

```python
from azero_log.azero_logger import logger
....
# 第二个参数必传
logger.debug("log message", request_envelope=handler_input.request_envelope)
logger.info("log message", request_envelope=handler_input.request_envelope)
logger.warn("log message", request_envelope=handler_input.request_envelope)
logger.error("log message", request_envelope=handler_input.request_envelope)
```

​	**ip解析城市**

​	使用样例：

```js
from azero_ipdb.ipdb_util import ipdb_city
...
city = ipdb_city.find_info("114.220.24.57", "CN").city_name

# 备注：局域网内网IP是查询不了的
```
#### azero-sdk-mongodb-persistence-adapter-*.tar.gz mongodb工具

​	用法如下：

​		项目根目录/lib安装

​		pip install azero-sdk-mongodb-persistence-adapter-*.tar.gz

​		数据库设置：

```python
#持久化配置
os.environ['DBURL'] = 'mongodb://user_name:password@127.0.0.1:27017'
os.environ['DATABASES'] = 'azero_skill'

# 或者 环境变量里设置
# DBURL = mongodb://user_name:password@127.0.0.1:27017
# DATABASES = azero_skill
```

​	使用样例：

```python
# 引入BD持久化包
from azero_sdk_mongodb.adapter import MongoDbPersistenceAdapter
try:
    import mock
except ImportError:
    from unittest import mock
...

# 初始化mongodb_adapter
partition_keygen = mock.Mock()
request_envelope = handler_input.request_envelope
partition_keygen.return_value = request_envelope.context.system.user.user_id
test_mongodb_adapter = MongoDbPersistenceAdapter(
    request_envelope=request_envelope,
    table_name="table_name", #要创建的表名
    attribute_name="attributes",#查询对象，不写默认为attributes
    partition_key_name="user_id",#查询关键字 不写默认为id
    partition_keygen=partition_keygen
)

data = {"mongo_adapter":{"test":"test1"}}
# 添加数据
test_mongodb_adapter.save_attributes(request_envelope=request_envelope, attributes=data)

# 查询数据
response = test_mongodb_adapter.get_attributes(request_envelope=request_envelope)
for result in response:
    print(result)

# 删除数据
test_mongodb_adapter.delete_attributes(request_envelope=request_envelope)
```

## Template展现模版 
* 为了更好的在有屏设备端上展现技能，AZERO提供了多种展现模板供开发者使用。展现模板分body template、list template、default template data三种类型。其中body template由图片和文字组成，list template由一系列list item组成，每个list item由图片和文字组成。default template date适用于需要携带额外信息给设备端。不同的展现模板适合不同的场景，开发者可以根据技能展现的需求选择合适的模板
* 添加返回端上的模版方法使用到addRenderTemplateDirective方法，示例代码如下:

~~~
"""以模板DefaultTemplateData为例"""

"""DefaultTemplateData的依赖 开始"""
from azero_sdk_model.interfaces.display.image_instance import ImageInstance
from azero_sdk_model.interfaces.display.image import Image

from azero_sdk_model.interfaces.display.default_template_data import DefaultTemplateData
from azero_sdk_model.interfaces.display.ext_content import ExtContent
from azero_sdk_model.interfaces.display.title import Title
"""DefaultTemplateData的依赖 结束"""

class CompletedDelegateHandler_test_test(AbstractRequestHandler):
    def can_handle(self, handler_input):
        return (ask_utils.is_request_type("IntentRequest")(handler_input) and
               ask_utils.is_intent_name("test_test")(handler_input) and
               ask_utils.get_dialog_state(handler_input).value == 'COMPLETED')
    def handle(self, handler_input):
        currentIntent = handler_input.request_envelope.request.intent
        speakOutput = '你好，我是小易'
        return (
        """编辑DefaultTemplateData模板开始处"""
        	handler_input.response_builder.add_directive(
                RenderTemplateDirective(
                    DefaultTemplateData(
                        token="token",
                        back_button="backButton",
                        background_image=Image(sources=[ImageInstance(url="http://ssds.background_image_sources.com")]),
                        title=Title(mainTitle="mainTitle", subTitle="subTitle"),
                        ext_content=ExtContent(data="data", type="type", tts_text="TTSText", asr_text="ASRText"),
                        text_field="textField"
                    )
                ))
       """编辑DefaultTemplateData模板结束处"""
        		.speak(speakOutput)
        		.set_should_end_session(True)
        		.response
        )
~~~



### BodyTemplate 共有5种类型模板可供选择

#### 文本展现模板 BodyTemplate1
* 此模板适用于展示纯文本信息场景，包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * textContent:技能交互时界面展示的文本信息
      * 一级文本:primaryText
      * 二级文本:secondaryText(可选)
      * 三级文本:tertiaryText(可选)


```python
{
  "type":"BodyTemplate1",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": Image,
  "title": "string",
  "textContent": TextContent
}
```

#### 图片和文本展现模板 BodyTemplate2
* 此模板适用于同时展示图片和文字的使用场景，其中图片展现在屏幕右侧，文字展现在屏幕左侧。包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * image:展示的图片
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * textContent:技能交互时界面展示的文本信息
      * 一级文本:primaryText
      * 二级文本:secondaryText(可选)
      * 三级文本:tertiaryText(可选)


```python
{
  "type":"BodyTemplate2",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": Image,
  "title": "string",
  "image": Image,
  "textContent": TextContent
}
```

#### 图片和文本展现模板 BodyTemplate3
* 此模板适用于同时展示图片和文字的使用场景，其中图片展现在屏幕左侧，文字展现在屏幕右侧。包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * image:展示的图片
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * textContent:技能交互时界面展示的文本信息
      * 一级文本:primaryText
      * 二级文本:secondaryText(可选)
      * 三级文本:tertiaryText(可选)


```python
{
  "type":"BodyTemplate3",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": Image,
  "title": "string",
  "image": Image,
  "textContent": TextContent
}
```

#### 图片和文本展现模板 BodyTemplate4
* 此模板适用于展示文字和背景图片使用场景，其中背景图片可在屏幕区域内进行自适应展示。包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * image:展示的图片
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * textContent:技能交互时界面展示的文本信息
      * 一级文本:primaryText
      * 二级文本:secondaryText(可选)
      * 三级文本:tertiaryText(可选)


```python
{
  "type":"BodyTemplate4",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": Image,
  "title": "string",
  "image": Image,
  "textContent": TextContent
}
```

#### 图片展现模板 BodyTemplate5
* 此模板适用于展示可缩放的前景图片以及带有背景图片的使用场景。包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * image:展示的图片
  * backgroundImage:技能交互时作为背景展示的图片（可选）


```python
{
  "type":"BodyTemplate5",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": Image,
  "title": "string",
  "image": Image
}
```

### ListTemplate 共有2种类型模板可供选择

#### ListTemplate1
* 此模板是纵向列表模板，适用于展现纵向的文本和图片场景。包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * listItems:列表项，包含文本和图片信息
    * token:图片的序号
    * image:背景图片
    * textContent:
        * 一级文本:primaryText
        * 二级文本:secondaryText(可选)
        * 三级文本:tertiaryText(可选)


```python
{
  "type": "ListTemplate1",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": "Image",
  "title": "string",
  "listItems": [
    {
      "token": "string",
      "image": Image,
      "textContent": TextContent
    },
    ...
    ...
    {
      "token": "string",
      "image": Image,
      "textContent": TextContent
    }
  ]
}
```

#### ListTemplate2
* 此模板是横向列表模板，适用于展现横向的文本和图片场景。包含以下内容：
  * title:技能名称或者技能当前页面主题
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * listItems:列表项，包含文本和图片信息
    * token:图片的序号
    * image:背景图片
    * textContent:
        * 一级文本:primaryText
        * 二级文本:secondaryText(可选)


```python
{
  "type": "ListTemplate2",
  "token": "string",
  "backButton": "VISIBLE"(default) | "HIDDEN",
  "backgroundImage": "Image",
  "title": "string",
  "listItems": [
    {
      "token": "string",
      "image": Image,
      "textContent": TextContent
    },
    ...
    ...
    {
      "token": "string",
      "image": Image,
      "textContent": TextContent
    }
  ]
}
```

#### DefaultTemplateData
* 包含以下内容：
  * token:模板的唯一标识
  * backButton:开发者在技能发布时需进行上传(可选)，返回按钮(展示/隐藏)
  * backgroundImage:技能交互时作为背景展示的图片（可选）
  * title:技能名称或者技能当前页面主题
    * mainTitle:主题
    * subTitle:子主题
  * extContent:
    * data:自定义数据，可以是一段json转为String，然后端上重新解析为Json，自定义操作内容
    * type:领域
    * TTSText:tts文本内容
    * ASRText:ASR结果


```python
{
    "type":"DefaultTemplateData",
    "token": "string",
    "backButton": "VISIBLE"(default) | "HIDDEN",
    "backgroundImage":Image,
    "title":{
        "mainTitle":"string",
        "subTitle":"string"
    },
    "extContent":{
        "data":"string",
        "type":"string",
        "TTSText":"string",
        "ASRText":"string"
    },
    "textField":"string"
}
```
### Q&A
##### Q:环境中自带了python，发生冲突怎么办？
A: 解决此问题有两种方式。
一种是指定运行python3.6，例如：
```
$ python3.6 app.py 
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
INFO:werkzeug: * Running on http://0.0.0.0:9930/ (Press CTRL+C to quit)
```
另外一种是将环境中其它版本的python卸载掉(不推荐)，并将python与pip建立软链到自己安装的版本，确保使用which命令查看python与pip时与下方结果类似：
```
$ which python
/opt/python3.6/bin/python
$ which pip
/opt/python3.6/bin/pip
```
