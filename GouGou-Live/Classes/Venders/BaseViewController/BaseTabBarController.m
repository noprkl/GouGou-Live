//
//  BaseTabBarController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseTabBarController.h"
#import "LiveViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"

#import "BaseNavigationController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewController];
}
- (void)addChildViewController {
 
    LiveViewController *liveVC = [[LiveViewController alloc] init];
    //    UINavigationController *liveNav = [[UINavigationController alloc] initWithRootViewController:liveVC];
    [self createVC:liveVC title:@"直播"];
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    //    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageVC];
    [self createVC:messageVC title:@"消息"];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    //    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:myVC];
    [self createVC:myVC title:@"我的"];

}
- (void)createVC:(UIViewController *)vc title:(NSString *)title {
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    NSDictionary *normalDict = @{
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20]
                                 };
    
    [vc.tabBarItem setTitleTextAttributes:normalDict forState:(UIControlStateNormal)];
    vc.title = title;
    
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
