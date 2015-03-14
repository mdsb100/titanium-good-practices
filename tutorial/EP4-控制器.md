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
```
$.submit.addEventListener( "click", function() {
  var name = $.textfield.value; //获得输入的内容
  if ( name == '' || name == null ) {
    alert( "name 不能为空" );
  } else {
    $.namelist.sections[ 0 ].appendItems( [
      {
        name: {
          text: name
        }
      }
    ] );
  }
} );

```

## ti build 试一下效果

在输入框中输入点文字，然后点击"提交"

![ep4-1](https://cloud.githubusercontent.com/assets/2350193/6650440/2c4842aa-ca4d-11e4-90ba-de60f708a9fa.png)

## 删除
```
//点击时删除当前item
$.namelist.addEventListener( "itemclick", function( e ) {
  e.section.deleteItemsAt( e.itemIndex, 1 );
} );
```