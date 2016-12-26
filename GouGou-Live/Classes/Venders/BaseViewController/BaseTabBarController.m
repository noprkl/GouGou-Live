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
    
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    
}
- (void)addChildViewController {
 
    
    LiveViewController *liveVC = [[LiveViewController alloc] init];
    [self createVC:liveVC title:@"首页" unSelectIcon:[UIImage imageNamed:@"首页（未点击）"] selectIcon:[UIImage imageNamed:@"首页"]];
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    [self createVC:messageVC title:@"消息" unSelectIcon:[UIImage imageNamed:@"消息（未点击）"] selectIcon:[UIImage imageNamed:@"消息"]];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    [self createVC:myVC title:@"我的" unSelectIcon:[UIImage imageNamed:@"我的（未点击）"] selectIcon:[UIImage imageNamed:@"我的"]];

}
- (void)createVC:(UIViewController *)vc title:(NSString *)title unSelectIcon:(UIImage *)unSelectIcon selectIcon:(UIImage *)selectIcon {
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];

    // 文字偏移
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(3, 0);
    
    vc.title = title;
    // 文字富文本
    NSDictionary *normalDict = @{
                                   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"],
                                   NSFontAttributeName:[UIFont systemFontOfSize:13]
                                   };
    
    [vc.tabBarItem setTitleTextAttributes:normalDict forState:(UIControlStateNormal)];
    NSDictionary *selectDict = @{
                                   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffa11a"],
                                   NSFontAttributeName:[UIFont systemFontOfSize:13]
                                   };
    
    [vc.tabBarItem setTitleTextAttributes:selectDict forState:(UIControlStateSelected)];
    // 图片偏移
//    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(2, 0, -2, 0)];
    [vc.tabBarItem setImage:unSelectIcon];
    [vc.tabBarItem setSelectedImage:selectIcon];
    
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
