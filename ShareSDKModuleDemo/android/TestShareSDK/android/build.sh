ant clean
ant dist
if [ $? == 0 ]; then
  unzip -o dist/com.test.testsharesdk-android-1.0.0.zip -d ../../../ShareSDKTestApp
fi