

# Python GUI





## 框架 wxpython



### 安装 wxpython

pip install wxpython 



如果无法下载超时：可以使用豆瓣源下载

pip install -i https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com wxpython

pip install -i https://pypi.doubanio.com/simple/  --trusted-host pypi.doubanio.com wxpython





### 使用wx.app

``` python
## 导入wx 包
import  wx

# 定义一个类继承wx.App
class MyApp(wx.App):
    # 定义 OnInit方法
    def OnInit(self):
        # 创建Frame
        my_frame = wx.Frame(parent = None,title = "hello wxpython")
        # 显示窗口
        my_frame.Show()

        return  True # 必须返回一个True


if __name__ == '__main__':
    # 创建APP
    app = MyApp()
    # 运行App
    app.MainLoop()
```

### 直接使用 wxApp

``` python
# 1- 导入wxpython
import wx

# 2- 创建wx.App()
my_app = wx.App()

# 3- 创建一个窗口
my_frame = wx.Frame(None,title = "hello wxpython")

# 4- 显示窗口
my_frame.Show()

# 5- 启动APP
my_app.MainLoop()
```









### 使用wx.Frame框架

``` python
## 使用子类 wx.Frame

# 1- 导入 wxpython
import  wx

# 2- 创建一个子类继承wx.Frame
class MyFrame(wx.Frame):
    # 3- 重写__init__方法
    def __init__(self,parent,id):
        # 4- 调用父类的__init__方法
        wx.Frame.__init__(self, parent, id, title = "创建一个窗口",pos = (500,200),size = (400,400))



if __name__ == '__main__':
    # 5- 创建一个App
    app = wx.App()

    # 6- 创建一个Frame
    my_frame = MyFrame(parent = None, id = -1)

    # 7- 显示Frame
    my_frame.Show()

    # 8- 运行App
    app.MainLoop()

```







## 控件

### StaticText 文本类 & wx.Font

``` python
import  wx

# 2- 创建 Frame 子类
class MyFrame(wx.Frame):
    def __init__(self,parent , id ):
        wx.Frame.__init__(self,parent,id,title = "StaticText--python之禅",pos = (300,100),size = (500,500))
        # 3- 创建一个画板
        panel = wx.Panel(self)
        h_size = 20

        # 4- 创建StaticText
        title = wx.StaticText(panel, label="Python之禅——Tim Peters", pos=(200, h_size))
        h_size = h_size + 20

        '''
            wx.Font(pointSize,family,style,weight,underline=False,faceName="",
            encoding=wx.FONTENCODING_DEFAULT)
            
            pointSize:字体的整数尺寸，单位为磅。
            family:用于快速指定一个字体而无需知道该字体的实际名字。
            style:指明字体是否倾斜。
            weight:是否加粗。
            underline:在Windows系统下有效，True：下划线；False:无下划线
            faceName : 字体名称
            encoding:编码选择，默认。
            
        '''
        font = wx.Font(20, wx.DEFAULT, wx.SLANT, wx.BOLD,underline=True)
        title.SetFont(font)


        # 4- 创建StaticText
        wx.StaticText(panel,label = "优美胜于丑陋",pos = (50,h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='明了胜于晦涩', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='简洁胜于复杂', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='复杂胜于凌乱', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='扁平胜于嵌套', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='间隔胜于紧凑', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='可读性很重要', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='即便假借特例的实用性之名，也不可违背这些规则', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='不要包容所有错误，除非你确定需要这样做', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='当存在多种可能，不要尝试去猜测', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='而是尽量找一种，最好是唯一一种明显的解决方案', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='虽然这并不容易，因为你不是 Python 之父', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='做也许好过不做，但不假思索就动手还不如不做', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='如果你无法向人描述你的方案，那肯定不是一个好方案;反之亦然', pos=(50, h_size))
        h_size = h_size + 20
        wx.StaticText(panel, label='命名空间是一种绝妙的理念，我们应当多加利用', pos=(50, h_size))

if __name__ == '__main__':
    app = wx.App()

    frame = MyFrame(parent=None,id = -1)

    frame.Show()

    app.MainLoop()
```





### TextCtrl输入文本类



### Button 按钮类



## BoxSizer布局

### 使用BoxSizer布局



## 事件处理



### 绑定事件













