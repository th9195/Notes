## 1- 添加引用

``` python

"""自定义模板需要的依赖 开始"""
from azero_sdk_model.interfaces.display.image_instance import ImageInstance
from azero_sdk_model.interfaces.display.image import Image

from azero_sdk_model.interfaces.display.default_template_data import DefaultTemplateData
from azero_sdk_model.interfaces.display.ext_content import ExtContent
from azero_sdk_model.interfaces.display.title import Title

"""自定义模板需要的依赖 结束"""
```



## 2- 使用DefaultTemplateData模板返回信息

例如：

``` python
class CompletedDelegateHandler_close_0(AbstractRequestHandler):
    def can_handle(self, handler_input):
        return (azero_utils.is_request_type("IntentRequest")(handler_input) and
                azero_utils.is_intent_name("close_0")(handler_input) and
                azero_utils.get_dialog_state(handler_input).value == 'COMPLETED')

    def handle(self, handler_input):
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

## 3- 抽取的getMyDictData方法

``` python

def getMyDictData(handler_input):
    currentIntent = handler_input.request_envelope.request.intent
    name = currentIntent.name # 获取意图标识
    attributes = handler_input.request_envelope.session.attributes

    # 获取槽位 airconditioner 的value
    airconditioner = azero_utils.get_slot_value(handler_input, 'airconditioner') 
    # 获取槽位 temperature 的value
    temperature = azero_utils.get_slot_value(handler_input, 'temperature')
    # 获取槽位 timeMin 的value
    timeMin = azero_utils.get_slot_value(handler_input, "timeMin")
    # 获取槽位 timeHour 的value
    timeHour = azero_utils.get_slot_value(handler_input, "timeHour")


    # 获取ASR  需要azero同事配合处理一下才能拿到ASR
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













