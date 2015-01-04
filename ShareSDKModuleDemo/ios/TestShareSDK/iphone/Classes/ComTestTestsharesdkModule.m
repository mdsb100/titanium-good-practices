/**
 * TestShareSDK
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "ComTestTestsharesdkModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "ShareSDK/ShareSDK.h"
#import "ShareSDK/ShareSDKTypeDef.h"
#import "WXApi.h"
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@implementation ComTestTestsharesdkModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"df394c6f-fb4b-4cfb-a4bb-84cd4534b109";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.test.testsharesdk";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
    [super startup];
    
    //读取ShareSDK.plist
    NSString * configPath = [self getPathToModuleAsset:@"ShareSDK.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:configPath];
    
    BOOL hasAppKey = [ data objectForKey:@"AppKey"];
    NSString * AppKey = hasAppKey ? @"" : (NSString * )[data objectForKey:@"AppKey"];
    
    // HandleOpenURL可用之前，禁用sso。现在是可用状态。
    [ShareSDK ssoEnabled:YES];
    [ShareSDK registerApp:AppKey];
    //    [ShareSDK convertUrlEnabled:NO];
    
    //读取一系列的properties
    NSMutableDictionary * pSinaWebo = [ data objectForKey:@"SinaWeibo"];
    hasSinaWeibo = pSinaWebo && [[ pSinaWebo objectForKey:@"Enable" ] boolValue ];
    oneKeyShareSinaWeibo = pSinaWebo && [[ pSinaWebo objectForKey:@"OneKeyShare" ] boolValue ];
    
    NSMutableDictionary * pWechat = [ data objectForKey:@"Wechat"];
    hasWechat = pWechat && [[ pWechat objectForKey:@"Enable" ] boolValue];
    oneKeyShareWechat = pSinaWebo && [[ pWechat objectForKey:@"OneKeyShare" ] boolValue ];
    
    NSMutableDictionary * pWechatMoments = [ data objectForKey:@"WechatMoments"];
    hasWechatMoments = pWechatMoments && [[ pWechatMoments objectForKey:@"Enable" ] boolValue];
    oneKeyShareWechatMoments = pWechatMoments && [[ pWechatMoments objectForKey:@"OneKeyShare" ] boolValue];
    
    NSMutableDictionary * pWechatFavorite = [ data objectForKey:@"WechatFavorite"];
    hasWechatFavorite = pWechatFavorite && [ [ pWechatFavorite objectForKey:@"Enable" ] boolValue];
    oneKeyShareWechatFavorite = pWechatFavorite && [ [ pWechatFavorite objectForKey:@"OneKeyShare" ] boolValue];
    
    NSMutableDictionary * pTencentWeibo = [ data objectForKey:@"TencentWeibo"];
    hasTencentWeibo = pTencentWeibo && [ [ pTencentWeibo objectForKey:@"Enable" ] boolValue ];
    oneKeyShareTencentWeibo = pTencentWeibo && [ [ pTencentWeibo objectForKey:@"OneKeyShare" ] boolValue ];
    
    NSMutableDictionary * pQZone = [ data objectForKey:@"QZone"];
    hasQZone =  pQZone && [[ pQZone objectForKey:@"Enable" ] boolValue];
    oneKeyShareQZone =  pQZone && [[ pQZone objectForKey:@"OneKeyShare" ] boolValue];
    
    NSMutableDictionary * pQQ = [ data objectForKey:@"QQ"];
    hasQQ = pQQ && [[ pQQ objectForKey:@"Enable" ] boolValue];
    oneKeyShareQQ = pQQ && [[ pQQ objectForKey:@"OneKeyShare" ] boolValue];
    
    NSMutableDictionary * pEmail = [ data objectForKey:@"Email"];
    hasEmail =  pEmail && [[ pEmail objectForKey:@"Enable" ] boolValue];
    oneKeyShareEmail =  pEmail && [[ pEmail objectForKey:@"OneKeyShare" ] boolValue];
    
    NSMutableDictionary * pShortMessage = [ data objectForKey:@"ShortMessage"];
    hasShortMessage =  pShortMessage && [[ pShortMessage objectForKey:@"Enable" ] boolValue];
    oneKeyShareShortMessage =  pShortMessage && [[ pShortMessage objectForKey:@"OneKeyShare" ] boolValue];
    
    //初始化各个平台
    if(hasSinaWeibo){
        /**
         连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
         http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
         **/
        NSString * AppKey = [pSinaWebo objectForKey:@"AppKey"];
        NSString * AppSecret = [pSinaWebo objectForKey:@"AppSecret"];
        NSString * RedirectUrl = [pSinaWebo objectForKey:@"RedirectUrl"];
        
        [ShareSDK connectSinaWeiboWithAppKey:AppKey
                                   appSecret:AppSecret
                                 redirectUri:RedirectUrl];
        
        NSLog(@"ShareSDKModule hasSinaWeibo AppKey:%@", AppKey);
        
    }
    
    if (hasWechat || hasWechatMoments ||  hasWechatFavorite) {
        /**
         连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
         http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
         微信朋友圈，微信好友都是用得同一个key
         **/
        
        NSString * AppId = [pWechat objectForKey:@"AppId"];
        
        if(AppId == nil){
            AppId = [pWechatMoments objectForKey:@"AppId"];
        }
        
        if(AppId == nil){
            AppId = [pWechatFavorite objectForKey:@"AppId"];
        }
        
        [ShareSDK connectWeChatWithAppId:AppId wechatCls:[WXApi class]];
        
        NSLog(@"ShareSDKModule Wechat AppKey:%@", AppId);
    }
    
    if (hasTencentWeibo) {
        /**
         连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
         http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
         
         如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
         **/
        
        NSString * AppKey = [pTencentWeibo objectForKey:@"AppKey"];
        NSString * AppSecret = [pTencentWeibo objectForKey:@"AppSecret"];
        NSString * RedirectUrl = [pTencentWeibo objectForKey:@"RedirectUrl"];
        
        [ShareSDK connectTencentWeiboWithAppKey:AppKey
                                      appSecret:AppSecret
                                    redirectUri:RedirectUrl
                                       wbApiCls:[WeiboApi class]];
        
        NSLog(@"ShareSDKModule TencenWeibo AppKey:%@", AppKey);
    }
    
    /** QQ的字段和android的不一样 要注意 */
    
    if (hasQZone) {
        /**
         连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
         http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
         
         如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
         **/
        
        NSString * AppKey = [pQZone objectForKey:@"AppKey"];
        NSString * AppSecret = [pQZone objectForKey:@"AppSecret"];
        
        [ShareSDK connectQZoneWithAppKey:AppKey
                               appSecret:AppSecret
                       qqApiInterfaceCls:[QQApiInterface class]
                         tencentOAuthCls:[TencentOAuth class]];
        
        NSLog(@"ShareSDKModule QZone AppKey:%@", AppKey);
    }
    
    if (hasQQ) {
        /**
         连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
         http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
         **/
        //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
        //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
        
        NSString * AppKey = [pQQ objectForKey:@"AppKey"];
        
        [ShareSDK connectQQWithQZoneAppKey: AppKey
                         qqApiInterfaceCls:[QQApiInterface class]
                           tencentOAuthCls:[TencentOAuth class]];
        
        NSLog(@"ShareSDKModule QQ AppKey:%@", AppKey);
    }
    
    if (hasEmail) {
        [ShareSDK connectMail];
        
        NSLog(@"ShareSDKModule hasEmail");
    }
    
    if (hasShortMessage) {
        [ShareSDK connectSMS];
        
        NSLog(@"ShareSDKModule hasShortMessage");
    }
    
    NSLog(@"[INFO] %@ loaded",self);
}

- (id)init
{
    self = [super init];
    NSLog(@"ShareSDKModule init");
    if (self) {
        hasSinaWeibo = NO;
        hasWechat = NO;
        hasWechatMoments = NO;
        hasWechatFavorite = NO;
        hasTencentWeibo = NO;
        hasQZone = NO;
        hasQQ = NO;
        hasEmail = NO;
        hasShortMessage = NO;
        
        oneKeyShareSinaWeibo = NO;
        oneKeyShareWechat = NO;
        oneKeyShareWechatMoments = NO;
        oneKeyShareWechatFavorite = NO;
        oneKeyShareTencentWeibo = NO;
        oneKeyShareQZone = NO;
        oneKeyShareQQ = NO;
        oneKeyShareEmail = NO;
        oneKeyShareShortMessage = NO;
    }
    
    return self;
}

#pragma Public APIs
/*
 args:
 # title:
 #   分享内容的title，显示在微信分享卡片的上方，提示性文字，不包含正文内容
 # content:
 #   分享内容的正文
 # url:
 #   类型为news时使用
 # type:
 #   分享内容的类型 "news" 或 "text"，news类型必须包含对应的URL，包含一张logo图片，并在微信中显示为卡片
 */
-(void)share:(id)args
{
    //读取JS中传来的参数
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    
    //保证在UI线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *title = [args objectForKey:@"title"];
        NSString *content = [args objectForKey:@"content"];
        NSString *url = [args objectForKey:@"url"];
        NSString *type = [args objectForKey:@"type"];
        
        //使用在assets的appicon.png
        NSString *imagePath = [self getPathToModuleAsset:@"appicon.jpg"];
        NSData *imageData = [[NSData alloc] initWithContentsOfFile: imagePath];
        id<ISSCAttachment> logoImage = [ShareSDK attachmentWithData:imageData mimeType:@"multipart/form-data" fileName:@"rjhy.jpg"];
        
        //配置媒体的类型
        SSPublishContentMediaType mediaType = SSPublishContentMediaTypeText;
        if ([type isEqualToString:@"news"]) {
            mediaType = SSPublishContentMediaTypeNews;
        }
        
        /** content和unit是父子关系，如果Unit里面用INHERIT_VALUE就会找对应content中的字段来填充 */
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:content
                                           defaultContent:content
                                                    image:logoImage /** 本地图片 */
                                                    title:title
                                                      url:url
                                              description:@"银天下"
                                                mediaType:mediaType];
        /** QQ相关Content暂无定义 */
        /** 订制微信好友 */
        [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                             content:content
                                               title:title
                                                 url:url
                                          thumbImage:INHERIT_VALUE
                                               image:INHERIT_VALUE
                                        musicFileUrl:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:nil];
        
        /** 订制微信朋友圈 */
        [publishContent addWeixinTimelineUnitWithType:INHERIT_VALUE
                                              content:content
                                                title:title
                                                  url:url
                                           thumbImage:INHERIT_VALUE
                                                image:INHERIT_VALUE
                                         musicFileUrl:nil
                                              extInfo:nil
                                             fileData:nil
                                         emoticonData:nil];
        
        /** 订制微信收藏 */
        [publishContent addWeixinFavUnitWithType:INHERIT_VALUE
                                         content:content
                                           title:title
                                             url:url
                                      thumbImage:INHERIT_VALUE
                                           image:INHERIT_VALUE
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];
        
        /** 订制邮件 */
        [publishContent addMailUnitWithSubject:title
                                       content:content
                                        isHTML:[NSNumber numberWithBool:YES]
                                   attachments:nil
                                            to:nil
                                            cc:nil
                                           bcc:nil];
        
        /** 订制短信 */
        [publishContent addSMSUnitWithContent:content];
        
        //用此方法来配置list
        NSMutableArray * mutableShareList = [self getList];
        
        NSArray * shareList = [ShareSDK getShareListWithType:
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               [self getShareTypeFromMutableArray: mutableShareList],
                               nil
                               ];
        
        //细节需要参考官方文档
        id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:nil
                                                                  oneKeyShareList:nil
                                                                   qqButtonHidden:YES
                                                            wxSessionButtonHidden:YES
                                                           wxTimelineButtonHidden:YES
                                                             showKeyboardOnAppear:YES
                                                                shareViewDelegate:nil
                                                              friendsViewDelegate:nil
                                                            picViewerViewDelegate:nil];
        //打开分享
        [ShareSDK showShareActionSheet: nil
                             shareList: shareList
                               content: publishContent
                         statusBarTips: YES
                           authOptions: nil
                          shareOptions: shareOptions
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    if (state == SSPublishContentStateSuccess)
                                    {
                                        NSLog(@"分享成功");
                                    }
                                    else if (state == SSPublishContentStateFail)
                                    {
                                        NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    }
                                }];
        
    });
}


/* 在这里处理 handleOpenURL的回调 */
-(void)resumed:(id)sender
{
    // This method is called when the application has been resumed
    
    NSLog(@"[MODULE LIFECYCLE EVENT] resumed");
    NSString * url = [[[TiApp app] launchOptions] objectForKey:@"url"];
    NSLog(@"ShareSDK: resumed openURL %@", url);
    if (url != nil) {
        [ShareSDK handleOpenURL: [NSURL URLWithString:url]
                     wxDelegate: [TiApp app]];
    }
    [super resumed:sender];
}

-(NSString*)getPathToModuleAsset:(NSString*) fileName
{
    // The module assets are copied to the application bundle into the folder pattern
    // "module/<moduleid>". One way to access these assets is to build a path from the
    // mainBundle of the application.
    
    NSString *pathComponent = [NSString stringWithFormat:@"modules/%@/%@", [self moduleId], fileName];
    NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
    
    return result;
}

-(NSMutableArray *)getList{
    NSMutableArray * mutableShareList = [[NSMutableArray alloc] init];
    
    if (oneKeyShareSinaWeibo) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeSinaWeibo] ];
    }
    
    if (oneKeyShareWechat) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeWeixiSession ]];
    }
    
    if (oneKeyShareWechatMoments) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeWeixiTimeline ] ];
    }
    
    if (oneKeyShareWechatFavorite) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeWeixiFav ] ];
    }
    
    if (oneKeyShareTencentWeibo) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeTencentWeibo ] ];
    }
    
    if (oneKeyShareQQ) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeQQ ] ];
    }
    
    if (oneKeyShareQZone) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeQQSpace ] ];
    }
    
    if (oneKeyShareEmail) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeMail ] ];
    }
    
    if (oneKeyShareShortMessage) {
        [mutableShareList addObject:[NSNumber numberWithInt:ShareTypeSMS ] ];
    }
    return mutableShareList;
}

-(ShareType)getShareTypeFromMutableArray:(NSMutableArray *)array{
    if (array.count == 0) {
        return nil;
    }
    ShareType type = [[array objectAtIndex:0] intValue];
    [array removeObjectAtIndex:0];
    NSLog(@"type %i", type);
    return type;
}


-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end
