/**
 * TestShareSDK
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "TiModule.h"

@interface ComTestTestsharesdkModule : TiModule
{
@private
    BOOL hasSinaWeibo, hasWechat, hasWechatMoments, hasWechatFavorite, hasTencentWeibo, hasQZone, hasQQ, hasEmail, hasShortMessage;
    BOOL oneKeyShareSinaWeibo, oneKeyShareWechat, oneKeyShareWechatMoments, oneKeyShareWechatFavorite, oneKeyShareTencentWeibo, oneKeyShareQZone, oneKeyShareQQ, oneKeyShareEmail, oneKeyShareShortMessage;
}

-(void)share:(id)args;

@end
