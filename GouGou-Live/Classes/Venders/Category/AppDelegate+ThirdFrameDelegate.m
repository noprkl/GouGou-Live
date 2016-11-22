//
//  AppDelegate+ThirdFrameDelegate.m
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate+ThirdFrameDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
//#import <HyphenateLite_CN/EMSDK.h>

@implementation AppDelegate (ThirdFrameDelegate)

// 环信
//+ (void)setEaseMobSDK {
//    EMOptions *options = [EMOptions optionsWithAppkey:@"1161161023178138#gougoulive"];
//    options.apnsCertName = @"zhuaxingLive";
//    [[EMClient sharedClient] initializeSDKWithOptions:options];
//    
//}
///** 进入后台 */
//+ (void)setEaseMobEnterBackground:(UIApplication *)application{
//
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
//}
///** 从后台返回 */
//+ (void)setEaseMobEnterForeground:(UIApplication *)application{
//    [[EMClient sharedClient] applicationWillEnterForeground:application];
//}



/** 友盟 */
+ (void)setUMengSDK {
    /**
     WXAPPID wxbef5a0656069e8e2
     QQ    APP ID 1105774632
     APP KEY osQW5HPgOna7eHKy
     新浪
     */
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58330b17717c194faf00069c"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxbef5a0656069e8e2" appSecret:@"ac07f6f1f055271566e664b5e8927147" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"xbzoAbVrckWipE6W"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
}
+ (BOOL)setUMengBackResult:(NSURL *)url {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
