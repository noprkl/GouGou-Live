//
//  SellerCenterViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerCenterViewController.h"
#import "TopButonView.h"

@interface SellerCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) TopButonView *topView; /**< 顶部按钮 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */


@property(nonatomic, strong) NSArray *headerArr; /**< 头部数据 */

@property(nonatomic, strong) NSArray *tableArr; /**< TableView数据 */
@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@end


@implementation SellerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    [self setNavBarItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)headerArr {
    if (!_headerArr) {
        _headerArr = @[@"SellerWaitPayViewController", @"SellerWaitSendViewController", @"SellerWaitAcceptViewController", @"SellerWaitRateViewController", @"SellerProtectPowerViewController"];
    }
    return _headerArr;
}
- (NSArray *)tableArr {
    if (!_tableArr) {
        _tableArr = @[@[@"SellerSoldGoodsViewController", @"SellerAcceptedRateViewController"], @[@"SellerShipTemplateViewController", @"ShopAddressViewController"], @[@"SellerMyGoodsViewController", @"SellerMyLiveViewController"]];
    }
    return _tableArr;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"卖出的宝贝", @"收到的评价"], @[@"运费模板", @"商家地址"], @[@"我的宝贝", @"我的直播"]];
    }
    return _dataArr;
}
- (TopButonView *)topView {
    
    if (!_topView) {
        _topView  = [[TopButonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];

        NSArray *titles = @[@"待支付",@"待发货",@"待收货",@"待评价",@"维权"];
        
        _topView.titleArray = titles;

        _topView.unSelectedArray = @[@"待付款",@"待发货",@"收货",@"待评价",@"维权"];

        _topView.selecedtArray = @[@"待付款（点击）",@"待发货（点击）",@"收货（点击）",@"待评价（点击）",@"维权（点击）"];
        
        __weak typeof(self) weakself = self;
        
        _topView.difStateBlock = ^(UIButton *btn) {
            
            NSInteger flag = btn.tag - 80;
            NSString *vcName = weakself.headerArr[flag];
            NSString *title = titles[flag];
            [weakself pushVCWithString:vcName title:title];
        };
    }
    return _topView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT - 88 - 64)) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
// 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
// 每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"查看全部卖出";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcName = self.tableArr[indexPath.section][indexPath.row];
    NSString *title = self.dataArr[indexPath.section][indexPath.row];
    [self pushVCWithString:vcName title:title];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark
#pragma mark - 跳转Action
- (void)pushVCWithString:(NSString *)vcName title:(NSString *)title{
    
    BaseViewController *vc = [[NSClassFromString(vcName) alloc] init];
    vc.title = title;
    vc.hidesBottomBarWhenPushed = YES;
    [vc setNavBarItem];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
