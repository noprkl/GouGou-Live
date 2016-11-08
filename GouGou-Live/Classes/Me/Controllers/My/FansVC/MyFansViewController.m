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
- (void)initUI {
    [self setNavBarItem];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
