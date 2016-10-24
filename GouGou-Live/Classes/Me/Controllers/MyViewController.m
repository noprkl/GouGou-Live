//
//  MyViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"


@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray  *dataSource;

@end

static NSString *cellid = @"myCellId";

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
   
}
- (void)initUI {
    self.view.backgroundColor = [UIColor greenColor];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

#pragma mark
#pragma mark - 代理
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@"登录", @"设置"];
    }
    return _dataSource;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSString *cellText = self.dataSource[indexPath.row];
    
    if ([cellText isEqualToString:@"登录"]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        loginVC.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:loginVC animated:YES];
        
    }else if ([cellText isEqualToString:@"设置"]) {
        
        SettingViewController *setVC = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
