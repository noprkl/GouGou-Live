//
//  AppDelegate.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"

@interface AppDelegate ()

/** tabbar */
@property (strong, nonatomic) UITabBarController *tabBC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    BaseTabBarController *tabBC = [[BaseTabBarController alloc] init];
    [tabBC.tabBar setBackgroundColor:[UIColor whiteColor]];
    self.tabBC = tabBC;
    self.window.rootViewController = tabBC;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end
