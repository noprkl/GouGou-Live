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

#import "AccountViewController.h" // 账户
#import "ShopAddressViewController.h" // 收货地址
#import "OrderGoodsViewController.h" // 商品订单

#import "FavoriteViewController.h" // 我的喜欢
#import "WatchHistoryViewController.h" // 观看历史

#import "CertificateViewController.h" // 实名认证
#import "MerchantViewController.h" // 商家认证

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray  *dataSource;

/** 控制器名字 */
@property (strong, nonatomic) NSArray *controllerNames;

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
        _dataSource = @[@"登录", @"账号", @"我的订单", @"收货地址", @"我的喜欢", @"观看历史", @"实名认证", @"商家认证",  @"意见反馈", @"关于我们",@"设置"];
    }
    return _dataSource;
}
- (NSArray *)controllerNames {

    if (!_controllerNames) {
        _controllerNames = @[@"LoginViewController",@"AccountViewController", @"OrderGoodsViewController", @"ShopAddressViewController", @"FavoriteViewController", @"WatchHistoryViewController", @"CertificateViewController", @"MerchantViewController", @"SuggestViewController", @"AboutUsViewController", @"SettingViewController"];
    }
    return _controllerNames;
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
    
    NSLog(@"%@", cellText);
    
    NSString *controllerName = self.controllerNames[indexPath.row];
    
    UIViewController *VC = [[NSClassFromString(controllerName) alloc] init];
    
    VC.title = cellText;
    [self.navigationController pushViewController:VC animated:YES];
    
//    if ([cellText isEqualToString:@"登录"]) {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        
//        loginVC.hidesBottomBarWhenPushed = YES;
//
//        [self.navigationController pushViewController:loginVC animated:YES];
//        
//    }else if ([cellText isEqualToString:@"设置"]) {
//        
//        SettingViewController *setVC = [[SettingViewController alloc] init];
//        [self.navigationController pushViewController:setVC animated:YES];
//    }else if ([cellText isEqualToString:@"实名认证"]) {
//        CertificateViewController *certificateVC = [[CertificateViewController alloc] init];
//        
//        [self.navigationController pushViewController:certificateVC animated:YES];
//        
//    }else if ([cellText isEqualToString:@"商家认证"]){
//        
//        MerchantViewController *merchantVC = [[MerchantViewController alloc] init];
//        [self.navigationController pushViewController:merchantVC animated:YES];
//        
//    }else if ([cellText isEqualToString:@"账号"]) {
//        
//        AccountViewController *accountVC = [[AccountViewController alloc] init];
//        [self.navigationController pushViewController:accountVC animated:YES];
//    }else if ([cellText isEqualToString:@"我的订单"]) {
//        
//        OrderGoodsViewController *VC = [[OrderGoodsViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }else if ([cellText isEqualToString:@"收货地址"]) {
//        
//        ShopAddressViewController *VC = [[ShopAddressViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }else if ([cellText isEqualToString:@"我的喜欢"]) {
//        
//        FavoriteViewController *VC = [[FavoriteViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }else if ([cellText isEqualToString:@"我的喜欢"]) {
//        
//        FavoriteViewController *VC = [[FavoriteViewController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
