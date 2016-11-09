//
//  MyFansViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyFansViewController.h"

@interface MyFansViewController ()<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

@implementation MyFansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)initUI {
    [self setNavBarItem];
    self.title = @"我的粉丝";

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
