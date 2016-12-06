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

@interface AppDelegate ()

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
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   return [AppDelegate setUMengBackResult:url];
}
// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [AppDelegate setEaseMobEnterBackground:application];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    // 支付宝
    [AppDelegate setAlipayResult:url];

    return YES;
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [AppDelegate setEaseMobEnterForeground:application];
}
@end
