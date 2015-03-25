controller控制器
===============

## 修改HelloWord/app/views/index.xml项目为:
```
<Alloy>
  <Window class="container" layout="vertical" >
    <View height="200" backgroundColor="red">
      <View top="50" height="100" width="Ti.UI.FILL" backgroundColor="green" layout="horizontal">
        <View width="Ti.UI.SIZE">
          <Label id="label" textid="user" color="red"></Label>
        </View>
        <TextField id="textfield" borderStyle="Ti.UI.INPUT_BORDERSTYLE_ROUNDED" backgroundColor="white" color="#336699" width="200" height="40" left="20">
        </TextField>
      </View>
      <Button id="submit" title="提交" bottom="0" left="25" width="44" height="25" backgroundColor="white" color="black"></Button>
    </View>
    <View backgroundColor="blue">
      <ListView id="namelist" top="7" right="7" left="7" bottom="0" separatorColor="transparent" backgroundColor="white" separatorStyle="-1" defaultItemTemplate="name">
        <Templates>
          <ItemTemplate name="name" height="30" >
            <View bindId="container" height="100%" width="100%" backgroundColor="gray">
              <View layout="horizontal" left="10">
                <Label text="Name is "></Label>
                <Label bindId="name"></Label>
              </View>
            </View>
          </ItemTemplate>
        </Templates>
        <ListSection></ListSection>
      </ListView>
    </View>
  </Window>
</Alloy>
```

## 模板
这里使用了模板来构建每一个items。
```
<ItemTemplate name="name" height="30" >
创建了一个名字叫做"name"的模板
```

```
<ListView ... defaultItemTemplate="name">
这里默认使用叫做"name"的模板
```


## 增加代码到HelloWord/app/controllers/index.js:
```
$.submit.addEventListener( "click", function() {
  var name = $.textfield.value;
  if ( name == '' || name == null ) {
    alert( "name 不能为空" );
  } else {
    alert( "name is " + name );
  }
} );
```

alloy会自动绑定'submit'按钮到'$'对象上。我们在'submit'上绑定点击事件。

## 接下来把name加入listview中
需要注意的是id在本xml文件中不能重复。但如果是不同的xml就没关系。
```
// $.submit对应的是<ListView id="namelist" ...> 由alloy自动完成
$.submit.addEventListener( "click", function() {
  var name = $.textfield.value; //获得输入的内容
  if ( name == '' || name == null ) {
    alert( "name 不能为空" );
  } else {
    $.namelist.sections[ 0 ].appendItems( [
      {
        name: { //这个name 对应的是bindId="name"
          text: name //这个text 对应的是bindId="name"的Label属性
        }
      }
    ] );
  }
} );

```

## ti build 试一下效果

在输入框中输入点文字，然后点击"提交"

![ep4-1](https://cloud.githubusercontent.com/assets/2350193/6650440/2c4842aa-ca4d-11e4-90ba-de60f708a9fa.png)

![ep4-2](https://cloud.githubusercontent.com/assets/2350193/6650529/23b53756-ca52-11e4-9578-adb1ca7a5c0b.png)

## 删除
```
//点击时删除当前item
$.namelist.addEventListener( "itemclick", function( e ) {
  e.section.deleteItemsAt( e.itemIndex, 1 );
} );
```

## 我们已经使用了：调用方法，属性赋值，事件监听。接下来使用第三方库。
titanium的js的引用是何nodejs一样的。我们现在想用moment.js来format时间。

### 创建lib/moment.js目录
```
app
 |-controllers
 \-lib
    \-moment.js
```

### 修改moment.js内容
```
var moment;

moment = require('alloy/moment');//可以看出alloy里其实自带moment

moment.lang('zh-cn');//使用中文

module.exports = moment;

```
### 命令行：ti build。你将会在Resources文件中发现"alloy/moment.js"

## 在EP2的时候教过如何引入lib下的js文件。
所以在index.js的顶部加入
```
var moment = require("moment");
```

##修改HelloWord/app/views/index.xml为:
```
<Alloy>
  <Window class="container" layout="vertical" >
    <View height="200" backgroundColor="red">
      <View top="50" height="100" width="Ti.UI.FILL" backgroundColor="green" layout="horizontal">
        <View width="Ti.UI.SIZE">
          <Label id="label" textid="user" color="red"></Label>
        </View>
        <TextField id="textfield" borderStyle="Ti.UI.INPUT_BORDERSTYLE_ROUNDED" backgroundColor="white" color="#336699" width="200" height="40" left="20">
        </TextField>
      </View>
      <Button id="submit" title="提交" bottom="0" left="25" width="44" height="25" backgroundColor="white" color="black"></Button>
    </View>
    <View backgroundColor="blue">
      <ListView id="namelist" top="7" right="7" left="7" bottom="0" separatorColor="transparent" backgroundColor="white" separatorStyle="-1" defaultItemTemplate="name">
        <Templates>
          <ItemTemplate name="name" height="30" >
            <View bindId="container" height="100%" width="100%" backgroundColor="gray">
              <View layout="horizontal" left="10" width="Ti.UI.SIZE">
                <Label text="Name is "></Label>
                <Label bindId="name"></Label>
              </View>
              <View layout="horizontal" right="10" width="Ti.UI.SIZE">
                <Label text="create at "></Label>
                <Label bindId="time"></Label>
              </View>
            </View>
          </ItemTemplate>
        </Templates>
        <ListSection></ListSection>
      </ListView>
    </View>
  </Window>
</Alloy>
```
注意bindId="time"

##修改index.js
```
$.submit.addEventListener( "click", function() {
  var name = $.textfield.value; //获得输入的内容
  if ( name == '' || name == null ) {
    alert( "name 不能为空" );
  } else {
    $.namelist.sections[ 0 ].appendItems( [
      {
        name: {
          text: name //这个text 对应的是bindId="name"的Label属性
        },
        time: {
          text: moment().format("HH:mm:ss") //这个text 对应的是bindId="time"的Label属性
        }
      }
    ] );
  }
} );
```

![ep4-3](https://cloud.githubusercontent.com/assets/2350193/6733256/f732d92a-ce8b-11e4-98b0-9383ba6963cc.png)

![ep4-4](https://cloud.githubusercontent.com/assets/2350193/6733257/f84e9e2a-ce8b-11e4-96a1-5776130e344a.png)

## 截图中看到android的模拟器，附上[Genymotin安装](http://docs.appcelerator.com/titanium/3.0/#!/guide/Installing_Genymotion)链接。这个模拟器非常好用。
使用命令行时，可以类似这样:
```
ti build -p android -C 'Google Nexus 4 - 4.3 - API 18 - 768x1280'
```
