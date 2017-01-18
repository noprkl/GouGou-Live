//
//  AppDelegate.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "AppDelegate+ThirdFrameDelegate.h" //

#import "WXApi.h"
#import "WXApiManager.h"

#import <AlipaySDK/AlipaySDK.h>
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import <PLPlayerKit/PLPlayerEnv.h>

@interface AppDelegate ()<WXApiDelegate>

/** tabbar */
@property (strong, nonatomic) UITabBarController *tabBC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    BaseTabBarController *tabBC = [[BaseTabBarController alloc] init];
    [tabBC.tabBar setBackgroundColor:[UIColor whiteColor]];
    self.tabBC = tabBC;
    self.window.rootViewController = tabBC;
    
    [self.window makeKeyAndVisible];

    
    // 设置友盟SDk
    [AppDelegate setUMengSDK];

    // 设置环信
    [AppDelegate setEaseMobSDK:application launchOptions:launchOptions];
    
    // 七牛云
    [PLStreamingEnv initEnv];
    [PLPlayerEnv initEnv];

    // 休眠3秒
    [NSThread sleepForTimeInterval:3];

    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        // 支付宝
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                DLog(@"result = %@",resultDic);
            }];
        }
        return result;
    }else{
        return [WXApi handleOpenURL:url delegate:self];
    }

}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 支付宝
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                DLog(@"result = %@",resultDic);
            }];
            return YES;
        }
        return result;
    }else{
        return [WXApi handleOpenURL:url delegate:self];
    }
}
//被废弃的方法. 但是在低版本中会用到.建议写上
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [AppDelegate setEaseMobEnterBackground:application];
}
// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [AppDelegate setEaseMobEnterForeground:application];
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_isLandscape) {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            return UIInterfaceOrientationMaskLandscape;
        }else { // 横屏后旋转屏幕变为竖屏
            return UIInterfaceOrientationMaskPortrait;
        }
    }
    else {
        return UIInterfaceOrientationMaskPortrait;
    }
}
#pragma mark
#pragma mark - 微信支付结果回调
- (void)onResp:(BaseResp *)resp
{
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    DLog(@"strMsg: %@",strMsg);
    
    NSString * errStr = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    DLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
        {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
            {
                case WXSuccess:
                {
                strMsg = @"支付结果:";
                DLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
                break;
                }
                case WXErrCodeUserCancel:
                {
                strMsg = @"用户取消了支付";
                DLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                break;
                }
                default:
                {
                strMsg = [NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                DLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                break;
                }
            }
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        NSNotification * notification = [NSNotification notificationWithName:@"WXPay" object:wxPayResult];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
}
@end
