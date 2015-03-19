学习Layout、标签、样式等
=========================

##参考[layout](http://docs.appcelerator.com/titanium/latest/#!/api/Titanium.UI.View-property-layout)

- - -

##修改HelloWord/app/views/index.xml项目为:
```
<Alloy>
  <Window class="container" layout="vertical" >
    <View height="200" backgroundColor="red">
    </View>
    <View backgroundColor="blue">
    </View>
  </Window>
</Alloy>
```

"ti build"查看效果。

## layout="vertical"
官网解释:Children are laid out vertically from top to bottom.The first child is laid out top units from its parent's bounding box. Each subsequent child is laid out below the previous child.The space between children is equal to the upper child's bottom value plus the lower child's top value.
子元素都是自上而下垂直布局。第一个贴着父容器上边界布局。其他每一个子元素紧接着前一个。

如果在此view上增加top="5"那么意味着我离前一个元素5个单位
```
<View backgroundColor="blue" top="5">
```

如果在此view上增加bottom="5"那么意味着我离我身后的元素5个单位
```
<View height="200" backgroundColor="red" bottom="5">
</View>
```

- - -

##修改HelloWord/app/views/index.xml项目为:
```
<Alloy>
  <Window class="container" layout="vertical" >
    <View height="200" backgroundColor="red">
      <View top="50" height="100" width="Ti.UI.FILL" backgroundColor="green" layout="horizontal">
      </View>
    </View>
    <View backgroundColor="blue">
    </View>
  </Window>
</Alloy>
```

"ti build"查看效果。

### layout="composite"
官网解释:composite (or absolute). Default layout. A child view is positioned based on its positioning properties or "pins" (top, bottom, left, right and center). If no positioning properties are specified, the child is centered.
默认值为绝对定位.定位依赖top,bottom,left,right这些属性，如果没有设置，那就是上下左右居中的。

### layout="horizontal"
横向的定位。和垂直的大致相同。具体内容参考官网。目前先简单使用。

### Ti.UI.FILL
官网解释:The view should size itself to fill its parent.
视图的大小应该填充到父容器中。相当于"100%"，但不是完全等价。一般不写Ti.UI.FILL,因为隐含的就是Ti.UI.FILL。

- - -

## 修改HelloWord/app/views/index.xml项目为:
```
<Alloy>
  <Window class="container" layout="vertical" >
    <View height="200" backgroundColor="red">
      <View top="50" height="100" width="Ti.UI.FILL" backgroundColor="green" layout="horizontal">
        <View width="Ti.UI.SIZE">
          <Label id="label" text="姓名"></Label>
        </View>
        <TextField borderStyle="Ti.UI.INPUT_BORDERSTYLE_ROUNDED" backgroundColor="white" color="#336699" width="200" height="40" left="20">
        </TextField>
      </View>
    </View>
    <View backgroundColor="blue">
    </View>
  </Window>
</Alloy>
```

### Ti.UI.SIZE
官网解释:The view should size itself to fit its contents.
视图的大小应该由它的内容决定

## 样式优先级。结合查看HelloWord/app/styles/index.tss
修改index.tss:
```
".container": {
  backgroundColor:"white"
}

"Label": {
  width: Ti.UI.SIZE,
  height: Ti.UI.SIZE,
  color: "#000"
}

"#label": {
  font: {
    fontSize: 12
  },
  color: "blue"
}

".color": {
  color: "green"
}

```

给Lable标签加上color
```
<Label id="label" text="姓名" color="red"></Label>
```
## 样式优先级。修改HelloWord/app/controllers/index.js
```
$.label.applyProperties( {
  color: "orange",
  font: {
    fontSize: 20
  }
} );
```

优先级和css是一样的
index.js赋值>标签中color="red">index.tss中的对象"#label">index.tss中的类".color">index.tss中的标签"Label"

```
$.index.open();

$.label.applyProperties( { //$.label 对应着 index.xml中 id="label"
  color: "orange",
  font: {
    fontSize: 20
  }
} );
```

"ti build"查看效果。

最后应该是orange色。

>特别注意编译后的代码：HelloWord/Resources/iphone/alloy/controllers/index.js
```
$.__views.label = Ti.UI.createLabel({
  width: Ti.UI.SIZE,
  height: Ti.UI.SIZE,
  color: "red",
  font: {
    fontSize: 12
  },
  id: "label",
  text: "姓名"
});
```
>先设置color: "red"。再在随后的代码中变为color: "orange"
```
$.label.applyProperties({
  color: "orange",
  font: {
    fontSize: 20
  }
});
```

## 使用i18n
创建目录Hellow/i18n/zh/string.xml。内容为:
```
<?xml version="1.0" encoding="UTF-8"?>
<resources>
  <string name="user">姓名</string>
</resources>

```
简体中文

创建目录Hellow/i18n/en/string.xml。内容为:

```
<?xml version="1.0" encoding="UTF-8"?>
<resources>
  <string name="user">name</string>
</resources>

```
英语

把index.xml中的label修改为textid="user"
```
<Label id="label" textid="user" color="red"></Label>

```

为了保证起作用。我们可以先在命令行中运行"ti clean"，在执行"ti build"

##查看最后结果。因为我的模拟器语言是英语，所以显示的是"name"
![ep3](https://cloud.githubusercontent.com/assets/2350193/6650399/c9b232e2-ca4a-11e4-90c5-5ef8217d486f.png)

[下一章](https://github.com/mdsb100/titanium-good-practices/blob/master/tutorial/EP4-%E6%8E%A7%E5%88%B6%E5%99%A8.md)