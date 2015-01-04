这是一个快速利用ShareSDK制作Titanium Module作为第三方分享的教程
========================================================

### 第一步建立一个ShareSDKTestApp。参考(快速helloworld)[https://github.com/mdsb100/titanium-good-practices/blob/master/%E5%BF%AB%E9%80%9FHelloWord.md]
- 创建目录 "ShareSDKModuleDemo"。
- 创建你的项目。输入`ti create -n ShareSDKTestApp -d ShareSDKModuleDemo -t app --id com.test.ShareSDKTestApp -u www.ShareSDKTestApp.com -p iphone,android`。检查是否创建"ShareSDKTestApp"文件夹。参考[Titanium Command-Line Interface Reference Create](http://docs.appcelerator.com/titanium/3.0/#!/guide/Titanium_Command-Line_Interface_Reference-section-35619828_TitaniumCommand-LineInterfaceReference-Create)。
- 安装alloy。Mac下打开terminal输入：`sudo npm install -g alloy`。 Windows下打开cmd输入：`npm install -g alloy`。完成后输入`alloy -v`检查是否安装成功。
- 初始化alloy。输入`cd ShareSDKTestApp/ShareSDKTestApp`进入刚才创建的app目录。输入`alloy new`[参考alloy](http://docs.appcelerator.com/titanium/3.0/#!/guide/Alloy_Quick_Start)
- 启动app。如果是ios的话输入`ti build -p ios`。如果是android的话输入`ti build -p android -T device`，注意插上android真机。

### iOS 教程
