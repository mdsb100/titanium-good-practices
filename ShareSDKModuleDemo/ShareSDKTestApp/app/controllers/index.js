var testsharesdk = require("com.test.testsharesdk");

function doClick(e) {
  testsharesdk.share({
    title: "测试",
    content: "Hello World!!!",
    url: "www.test.com"
  });
}

$.index.open();
