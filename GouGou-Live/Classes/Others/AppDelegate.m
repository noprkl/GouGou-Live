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

//    // 微信支付
//    [WXApi registerApp:@"wxbef5a0656069e8e2" withDescription:@"demo 2.0"];
   
    // 七牛云
    [PLStreamingEnv initEnv];
    [PLPlayerEnv initEnv];
    
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
        }else{ // 微信
            return [WXApi handleOpenURL:url delegate:self];
        }
        
    }
    return result;
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    // 支付宝
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            DLog(@"result = %@",resultDic);
        }];
        return YES;
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

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    
//    return [UMSocials]
//}
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
    else
        {
        return UIInterfaceOrientationMaskAllButUpsideDown;
        }
}
@end
