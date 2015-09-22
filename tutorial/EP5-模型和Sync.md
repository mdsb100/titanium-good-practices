model模型和sync
================

## sync
In Alloy, a sync adapter allows you to store and load your models to a persistent storage device, such as an on-device database or remote server. Alloy relies on the Backbone API to sync model data to persistent storage.

简而言之sync是一个adapter帮助你加载远程或本地数据。

### 创建sync。强烈建议使用restapi.js和sqlrest.js
[参考文档](http://docs.appcelerator.com/platform/latest/#!/guide/Alloy_Sync_Adapters_and_Migrations)。
创建目录app/lib/alloy/sync, 创建文件[restapi.js](https://github.com/viezel/napp.alloy.adapter.restapi)和[sqlrest.js](https://github.com/viezel/napp.alloy.adapter.restsql)

## models
In Alloy, models inherit from the Backbone.Model class. They contain the interactive data and logic used to control and access it. Models are specified with JavaScript files, which provide a table schema, adapter configuration and logic to extend the Backbone.Model class. Models are automatically defined and available in the controller scope as the name of the JavaScript file.

## Collections
Collections are ordered sets of models and inherit from the Backbone.Collection class. Alloy Collections are automatically defined and available in the controller scope as the name of the model. To access a collection in the controller locally, use the Alloy.createCollection method with the name of the JavaScript file minus the '.js' extension as the required parameter. The second optional parameter can be an array of model objects for initialization. For example, the code below creates a collection using the previously defined model and reads data from persistent storage:

```
var library = Alloy.createCollection('books');
library.fetch(); // Grab data from persistent storage
```

注意titanium使用[backbone](http://docs.appcelerator.com/backbone/0.9.2/)的版本

## 创建第一个model。在app/models/下创建book.js
```
exports.definition = {
  config: { //配置
    columns: { //定义字段
      id: "int",
      title: "string",
      author: "string",
      checkout: 'bool'
    },
    defaults: { // 默认值
      author: "匿名"
    },
    adapter: {
      type: "restapi", //sync问价中的文件名
      // collection的名字。所以model是文件名book。books是collection名字。
      // Alloy.createCollection('books');
      collection_name: "books"
    }
  },
  extendModel: function(Model) {
    _.extend(Model.prototype, {
      //继承Alloy的Model，你可以重写很多方法
    });
    return Model;
  },
  extendCollection: function(Collection) {
    return Collection.extend({
      url: function() { // 定义远程获取数据的url
        return require('service').getCurrentUrls().books.path
      }
    });
  }
};

```

### 还有很多细节，请大家查看官方文档并且直接查看restapi.js的源码和项目中alloy/backbone.js的源码(搜索一下) 只有读懂了才能够灵活使用。

## Event Handling
参考[Backbone.Events API](http://docs.appcelerator.com/backbone/0.9.2/#Events)
```
var library = Alloy.createCollection('books');
function event_callback (collections) {

};
// Bind the callback to the change event of the collection.
library.on('change', event_callback);
// Trigger the change event and pass context to the handler.
library.trigger('change', 'change is good.');
// Passing no parameters to the off method unbinds all event callbacks to the object.
library.off();
// This trigger does not have a response.
library.trigger('change');

library.fetch({
  store: "豆瓣" //请求参数
});

```

### 高级用法
```
library.on("fetch change destory", event_callback);
library.off("fetch change destory", event_callback);
var book = library.at(0);
//当此属性变化时
book.on("change:title", function(book, title){

});
```

### 方法对照

```
(Backbone Method) (Sync CRUD Method) (Equivalent HTTP Method) (Equivalent SQL Method)
Collection.fetch read GET SELECT

Collection.create (id == null) create POST INSERT

Collection.create (id != null) update PUT UPDATE

Model.fetch read GET SELECT

Model.save (id == null) create POST INSERT

Model.save (id != null) update PUT UPDATE

Model.destroy delete DELETE DELETE
```

```
var book = Alloy.createModel('book', {
  checkout: false
});

// Performs a POST on /library with the arguments as a payload and the server returns the id as 1
book.save({title:'Bossypants',author:'Tina Fey'})

// Performs a GET on /library/1
book.fetch({id:1});

// Performs a PUT on /library/1 with the entire modified object as a payload.
book.save({checkout:true});

// Performs a DELETE on /library/1
book.destroy();
```

### 参考sql sync
```
exports.definition = {
  config: {
    "columns": {
      "id": "TEXT PRIMARY KEY",
      "content": "TEXT",
      "fromId": "TEXT",
      "toId": "TEXT",
      "timestamp": "INTEGER",
      "type": "INTEGER",
      "avatar": "TEXT",
      "length": "INTEGER",
      "status": "TEXT"
    },
    "adapter": {
      "type": "sqlrest",
      "collection_name": "csrChatMessages",
      "idAttribute": "id"
    },
    "defaults": {
      "status": "sending"
    }
  }
};
```
