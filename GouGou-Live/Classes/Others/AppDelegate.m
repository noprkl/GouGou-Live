//
//  AppDelegate.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate.h"
#import "LiveViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"


@interface AppDelegate ()

/** tabbar */
@property (strong, nonatomic) UITabBarController *tabBC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBC = [[UITabBarController alloc] init];
    self.tabBC = tabBC;
    self.window.rootViewController = tabBC;
    
    
    LiveViewController *liveVC = [[LiveViewController alloc] init];
    //    UINavigationController *liveNav = [[UINavigationController alloc] initWithRootViewController:liveVC];
    [self createVC:liveVC title:@"直播"];
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    //    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageVC];
    [self createVC:messageVC title:@"消息"];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    //    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
    [self createVC:myVC title:@"我的"];
    
    
    //    tabBC.viewControllers = @[liveNav, messageNav, myNav];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)createVC:(UIViewController *)vc title:(NSString *)title {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    //    nav.title = title;
    
    NSDictionary *normalDict = @{
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                 };
    
    
    [vc.tabBarItem setTitleTextAttributes:normalDict forState:(UIControlStateNormal)];
    vc.title = title;
    
    [self.tabBC addChildViewController:nav];
    
}



@end
