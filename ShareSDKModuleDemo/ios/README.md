这是一个快速利用ShareSDK制作ios平台的Titanium Module作为第三方分享的教程
================================================================

### 前提条件
- 开发过titanium module，对titanium 及 module 有一定了解。参考官方文档[iOS_Module_Development](http://docs.appcelerator.com/titanium/3.0/#!/guide/iOS_Module_Development_Guide)。
- 对iphone开发具备基础的了解。
- 有一台ios设备，如itouch,iphone。若您没有设备，也可以使用模拟器。(但是模拟器不能够真正切到微信app去分享)
- 对alloy有一定了解。

接下来所有的内容都默认你具备了基础知识。

### 环境
- 系统:OSX
- export PATH=${PATH}:~/android-sdk/platform-tools:~/android-sdk/tools:~/apache-ant-1.9.2/bin
- export ANT_HOME=/Users/apple/apache-ant-1.9.2
- export ANDROID_SDK=/Users/apple/android-sdk
- export ANDROID_NDK=/Users/apple/android-ndk-r8d
- ti version 3.4.1
- ti sdk version 3.4.1
- alloy version 1.5.1
ShareSdk version: 2.10.4 ios

### 下载[ShareSDK](http://sharesdk.mob.com/Download)
选择的是自定义下载，不包括所有的平台。

### 创建module
创建ios目录，目录结构为
```
ShareSDKModuleDemo
  |--ShareSDKTestApp
  |--ios
  \--android
```
终端输入：
```
ti create --platforms=ios --type=module --name=TestShareSDK --id=com.test.testsharesdk --url=www.test.testsharesdk -d ios
```
![create_module](https://cloud.githubusercontent.com/assets/2350193/5605111/24a34b44-9424-11e4-8863-ae35eb13cb97.png)