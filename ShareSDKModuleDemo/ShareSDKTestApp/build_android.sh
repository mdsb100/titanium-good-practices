rm -r build/
alloy compile app -c platform=android
ti build -p android -T device

# 可以用Genymotion跑个android模拟器
# ti build -p android -C 'Google Nexus 4 - 4.3 - API 18 - 768x1280'