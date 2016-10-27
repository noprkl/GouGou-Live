//
//  MyViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray  *dataSource;

/** 控制器名字 */
@property (strong, nonatomic) NSArray *controllerNames;

/** headBtn */
@property (strong, nonatomic) UIButton *myButton;

@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
}
- (void)initUI {

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
}

#pragma mark
#pragma mark - 代理
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@[@"登录"], @[@"账号", @"我的订单", @"收货地址"], @[@"我的喜欢", @"观看历史"], @[@"实名认证", @"商家认证"], @[@"设置"]];
    }
    return _dataSource;
}
- (NSArray *)controllerNames {

    if (!_controllerNames) {
        _controllerNames = @[@[@"LoginViewController"],@[@"AccountViewController", @"OrderGoodsViewController", @"ShopAddressViewController"], @[@"FavoriteViewController", @"WatchHistoryViewController"], @[@"CertificateViewController", @"MerchantViewController"],@[@"SettingViewController"]];
    }
    return _controllerNames;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"myCellId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    
    cell.detailTextLabel.text = @"detailTextLabel";
   
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = self.dataSource[indexPath.section][indexPath.row];
    
    NSString *controllerName = self.controllerNames[indexPath.section][indexPath.row];
    
    UIViewController *VC = [[NSClassFromString(controllerName) alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.title = cellText;
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)clickMyButtonAction {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
