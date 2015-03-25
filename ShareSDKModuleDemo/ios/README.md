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
- ti version 3.5.0
- ti sdk version 3.5.0
- alloy version 1.5.1
ShareSdk version: 2.10.4 ios

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
ti create --platforms=ios --type=module --name=TestShareSDK --id=com.test.testsharesdk --url=www.test.testsharesdk --workspace-dir=ios
```
![create_module](https://cloud.githubusercontent.com/assets/2350193/5605111/24a34b44-9424-11e4-8863-ae35eb13cb97.png)

### 复制ShareSDK到module
![copy_sdk](https://cloud.githubusercontent.com/assets/2350193/5605230/97d9cbf0-942a-11e4-99bf-653a110a1e05.png)


### 打开 "iphone/TestShareSDK.xcodeproj"

### 把assets文件夹拖入到项目中，不要"copy items if needed"。

### 把platform文件夹拖入到项目中，需要"copy items if needed"。
![drag_into_product](https://cloud.githubusercontent.com/assets/2350193/5605268/de3062ec-942c-11e4-89ee-d20b7500e2a8.png)

### 把所有bundle文件和string文件放入到platform/iphone文件夹下。很重要。
若有不明白可以查看titanium官网了解 platform/iphone的意义
![ios_bundle](https://cloud.githubusercontent.com/assets/2350193/5606431/91c49124-946a-11e4-80ea-659204d9fcbc.png)

### 修改[module.xcconfig](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/ios/TestShareSDK/iphone/module.xcconfig)。这一步非常重要，请仔细看xcconfig。用到了系统的framework，也用到了第三方的framework。还有search path！
需要注意的是，如果你用什么平台就要加什么Framework。参考[官网](http://wiki.mob.com/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E6%8C%87%E5%8D%97/)

### 仔细阅读官网，如果你需要用到的平台需要特殊设置，请照着官网做！

### 修改代码[ComBaidaoTestsharesdkModule.h](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/ios/TestShareSDK/iphone/Classes/ComTestTestsharesdkModule.h)

### 修改代码[ComBaidaoTestsharesdkModule.m](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/ios/TestShareSDK/iphone/Classes/ComTestTestsharesdkModule.m)
修改的代码中会去读取下一步中的ShareSDK.plist。

#### 仔细阅读代码！注意！这个方法"-(void)resumed:(id)sender"是处理handleOpenURL的回调。

#### 如果你想在分享成功后发个时间给JS端知道，那么一定更要使用"dispatch_async(dispatch_get_main_queue(), ^ {});"。在代码中能找到相关示例代码。
感谢@Shallong的反馈

#### 根据ShareSDK官网文档自己去修改"share"这个方法，这不一定能完全满足你的需求。

### 在assets中增加[appicon.jpg](https://github.com/mdsb100/titanium-good-practices/tree/master/ShareSDKModuleDemo/ios/TestShareSDK/assets/appicon.jpg)和[ShareSDK.plist](https://github.com/mdsb100/titanium-good-practices/tree/master/ShareSDKModuleDemo/ios/TestShareSDK/assets/ShareSDK.plist)
注意这一步很重要，配置了appkey

### 预备发布。在iphone文件夹下增加文件[build.sh](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/ios/TestShareSDK/iphone/build.sh)
目的是把module解压到ShareSDKTestApp下

### 执行 `./build.sh`

### 修改 ShareSDKTestApp文件夹下的[tiapp.xml](https://github.com/mdsb100/titanium-good-practices/blob/master/ShareSDKModuleDemo/ShareSDKTestApp/tiapp.xml)
非常重要，否则微信不能跳转回来。还有不要忘记在modules中加入配置module。
```
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>wx</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>wx4868b35061f87885</string>
        </array>
    </dict>
</array>
```
新浪微博也需要加。这里没加给出个示例。
```
<dict>
    <key>CFBundleURLName</key>
    <string>wb</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>wb00000000</string>
    </array>
</dict>
```
string里的值就是各个平台申请的appkey。

### 跳转回主[README.md](https://github.com/mdsb100/titanium-good-practices/tree/master/ShareSDKModuleDemo)
