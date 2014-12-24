这是一个快速帮助你利用Titanium建立一个HelloWorld应用的中文教程。不使用Titanium Studio。纯基于CLI。
=======================================================

这个教程是基于Mac的，Windows下大致相同，若有问题请提issuse。参考[Titanium Command-Line Interface Reference](http://docs.appcelerator.com/titanium/3.0/#!/guide/Titanium_Command-Line_Interface_Reference)。

- 安装[nodejs](http://nodejs.org/#)，请选择自己对应的平台

- Mac下打开terminal输入：`sudo npm install -g titanium`。 Windows下打开cmd输入：`npm install -g titanium`。完成后继续输入`ti -v`,会输出版本号如`3.4.1`。输入`ti help`查看帮助
- 登录你的账号。如果没有账号请到官网注册。如图![Login Image](https://cloud.githubusercontent.com/assets/2350193/5546314/0d30863c-8b7a-11e4-9104-4c0ada7d693c.png)
- 下载Titanium SDK。输入`ti sdk install`。它会自动下载最新的Titanium SDK。等待下载完毕后输出`Titanium SDK 3.4.1.GA successfully installed!`表示你下载完成。然后再输入`ti sdk`检查你自己安装的版本。
- 设置android.ndk。输入`ti config android.ndk "<yourhome>/android-ndk-r8d"`
- 设置android.sdk。输入`ti config android.sdk "<yourhome>/android-sdk/"`
- 设置android.sdkPath。输入`ti config android.sdkPath "<yourhome>/android-sdk/"`
- 要是只跑ios可以略过上面android的几步，要是你只搞ios还用什么Titanium啊。
- 创建你的Hello World项目。输入`ti create -n HelloWorld -d HelloWorld -t app --id com.test.HelloWorld -u www.HelloWorld.com -p iphone,android`。检查是否创建"HelloWorld"文件夹。参考[Titanium Command-Line Interface Reference Create](http://docs.appcelerator.com/titanium/3.0/#!/guide/Titanium_Command-Line_Interface_Reference-section-35619828_TitaniumCommand-LineInterfaceReference-Create)。
- 安装alloy。Mac下打开terminal输入：`sudo npm install -g alloy`。 Windows下打开cmd输入：`npm install -g alloy`。完成后输入`alloy -v`检查是否安装成功。
- 初始化alloy。输入`cd HelloWorld/HelloWorld`进入刚才创建的app目录。输入`alloy new`[参考alloy](http://docs.appcelerator.com/titanium/3.0/#!/guide/Alloy_Quick_Start)
- 启动app。如果是ios的话输入`ti build -p ios`。如果是android的话输入`ti build -p android -T device`，注意插上android真机。![Build](https://cloud.githubusercontent.com/assets/2350193/5546679/b81aba82-8b83-11e4-9971-90413afec3d1.png)