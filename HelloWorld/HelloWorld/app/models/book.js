exports.definition = {
  config: {
    columns: {
      id: "int",
      title: "string",
      author: "string"
    },
    defaults: {
      author: "匿名"
    },
    adapter: {
      type: "restapicache",
      collection_name: "books"
    }
  },
  extendModel: function(Model) {
    _.extend(Model.prototype, {

    });
    return Model;
  },
  extendCollection: function(Collection) {
    return Collection.extend({
      url: function() {
        return require('service').getCurrentUrls().books.path //最好有一个文件去管理所有的url
      }
    });
  }
};
