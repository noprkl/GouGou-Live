//
//  AppDelegate+ThirdFrameDelegate.m
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate+ThirdFrameDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "EMSDK.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@implementation AppDelegate (ThirdFrameDelegate)

// 环信
+ (void)setEaseMobSDK:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    EMOptions *options = [EMOptions optionsWithAppkey:@"1161161023178138#gougoulive"];
    options.apnsCertName = @"zhuaxingLive";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    // 环信登录
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:[UserInfos sharedUser].ID password:[UserInfos sharedUser].userPsd];
        if (!error) {
            NSLog(@"登陆成功");
        } else {
            NSLog(@"登陆失败");
        }
    }
    // 环信UI调用
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:@"1161161023178138#gougoulive"
                                         apnsCertName:@"zhuaxingLive"
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}
/** 进入后台 */
+ (void)setEaseMobEnterBackground:(UIApplication *)application{

    [[EMClient sharedClient] applicationDidEnterBackground:application];
}
/** 从后台返回 */
+ (void)setEaseMobEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


/** 友盟 */
+ (void)setUMengSDK {
    /**
     WXAPPID wxbef5a0656069e8e2
     QQ    APP ID 1105774632
     
     新浪
     */
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58330b17717c194faf00069c"];
    
    // 获取友盟social版本号
    //DLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxbef5a0656069e8e2" appSecret:@"ac07f6f1f055271566e664b5e8927147" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"xbzoAbVrckWipE6W"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2247552123"  appSecret:@"b8dbc8631b270432bade30f503ebf4c1" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 微信支付
    [WXApi registerApp:@"wxbef5a0656069e8e2" withDescription:@"demo 2.0"];
}

@end
