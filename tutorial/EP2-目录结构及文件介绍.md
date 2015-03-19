请务必参考官网教程[alloy](http://docs.appcelerator.com/titanium/latest/#!/guide/Alloy_Framework)
======================

```
root
  |-app
  |-build
  |-i18n
  |-platform
  |-plugins
  |-Resources
  \-tiapp.xml
```

- app:应用的代码资源等在里面
- build:构建出地不同平台的项目
- i18n:internationalization and localization.国际化与本地化
- platform:不同平台的资源放在里面。如platform/iphone/xxx.m4a
- plugins:各种插件。比如我们可以在构建时加入hooks去拦截做一些自己的事情
- Resources:编译完成之后的源码资源等
- tiapp.xml:Titanium application的配置

```
app
  |-assets
  |  |-iphone
  |  |  \-images
  |  |-android
  |  |  \-images
  |  |    |-res-mdpi
  |  |    |-res-hdpi
  |  |    \-...
  |  \-images
  |
  |-controllers
  |-lib
  |  \-util.js
  |-models
  |-views
  |-styles
  |-migrations
  |-widgets
  |-alloy.js
  \-config.json
```
- assets:放图片字体等。如果图片路径是"/images/logo.png"在ios平台下运行，它会先去找"ios/images/logo.png"，如果没找到再找"images/logo.png"。是根据平台来找的。
- controllers: 控制器。js文件。
- lib: 第三方js文件，util之类js都可以放这里面。js文件。
- models: 模型（数据）。js文件。backbone model。
- views: 视图。xml文件。
- styles: 样式。tss文件。
- migrations: 本地数据迁移。如果model的adapter使用了sql。js文件。参考[migrations](http://docs.appcelerator.com/titanium/latest/#!/guide/Alloy_Backbone_Migration)
- widgets: 组件。你可以去市场下载别人的组件使用。注意要在config.json中配置。参考[widgets](http://docs.appcelerator.com/titanium/latest/#!/guide/Alloy_Widgets)
- alloy.js: 最先运行的。你可以定义一些："Alloy.Globals.someGlobalFunction = function(){};"
- config.json: 配置文件。配置环境变量，样式风格等。

### lib/util.js如何使用呢。
```
var util = require('util');
```
lib对应的是js运行时的根目录。所以如果有个文件是lib/config/log.js。应当怎么使用:
```
var log = rquire('config/log')
```


### [config.json](http://docs.appcelerator.com/titanium/latest/#!/guide/Project_Configuration_File_(config.json))。具体参考官网。
如：
```
{
  "global": {},
  "env:development": {"dosome": true},
  "env:test": {"dosome": true},
  "env:production": {"test": false},
  "os:ios": {},
  "os:android": {},
  "os:mobileweb":{},
  "dependencies": {
    "guideIndicator": "1.0" //widget的依赖配置在这里
  }
}

```

```
if (require('alloy').CFG.dosome){
  dosome();
}
```

[下一章](https://github.com/mdsb100/titanium-good-practices/blob/master/tutorial/EP3-%E6%9E%84%E5%BB%BA%E6%A0%B7%E5%BC%8F%E5%8F%8A%E8%A7%86%E5%9B%BE.md)