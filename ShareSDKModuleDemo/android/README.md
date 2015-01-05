这是一个快速利用ShareSDK制作android平台的Titanium Module作为第三方分享的教程
====================================================================

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
ShareSdk version: 2.5.7 android

### 下载[ShareSDK](http://sharesdk.mob.com/Download)
选择的是自定义下载，不包括所有的平台。

### 仔细阅读[官网](http://wiki.mob.com/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/)

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
ti create --platforms=android --type=module --name=TestShareSDK --id=com.test.testsharesdk --url=www.test.testsharesdk --workspace-dir=android
```

### 打开Eclipse。export "Existing Projects into Workspace"把刚创建android项目导入进来。这步可以不做，完全可以不需要Eclipse，为了看的更清楚。

### 配置[build.properties](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/android/TestShareSDK/android/build.properties)
```
titanium.platform=${env.HOME}/Library/Application Support/Titanium/mobilesdk/osx/3.2.0.GA/android
android.platform=${env.ANDROID_SDK}/platforms/android-10
google.apis=${env.ANDROID_SDK}/add-ons/addon-google_apis-google-10
android.ndk=${env.ANDROID_NDK}
```
windows如果不行就写绝对路径。

### 加入一行```<property environment="env"/>```到[build.xml](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/android/TestShareSDK/android/build.xml)

### Terminal中输入```and dist```。看看是否build成功。这里要装ant。

### 修改[timodule.xml](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/android/TestShareSDK/android/timodule.xml)。增加权限，参考[官网](http://wiki.mob.com/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/)
