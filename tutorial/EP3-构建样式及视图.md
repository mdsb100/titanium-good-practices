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

###  layout="horizontal"
横向的定位。和垂直的不太相同。具体内容参考官网。目前先简单使用。

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
        <View backgroundColor="yellow">
          <TextField borderStyle="Ti.UI.INPUT_BORDERSTYLE_ROUNDED" color="#336699" width="200" height="30" >
          </TextField>
        </View>
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