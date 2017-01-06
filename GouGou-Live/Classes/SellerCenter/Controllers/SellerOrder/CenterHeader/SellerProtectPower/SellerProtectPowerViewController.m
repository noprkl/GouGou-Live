//
//  SellerProtectPowerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerProtectPowerViewController.h"
#import "SellerProtectPowerCell.h"
#import "SellerProtectModel.h"

@interface SellerProtectPowerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SellerProtectPowerCell";

@implementation SellerProtectPowerViewController
#pragma mark
#pragma mark - 网络请求
// 请求维权的订单
- (void)getRequestProtectPowerOrder {
    NSDictionary *dict = @{//[[UserInfos sharedUser].ID integerValue]
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"page":@(1),
                           @"pageSize":@(10),
                           };
    [self getRequestWithPath:API_My_activist params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [SellerProtectModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestProtectPowerOrder];
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getRequestProtectPowerOrder];
        
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 62) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];

        [_tableView registerClass:[SellerProtectPowerCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerProtectPowerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SellerProtectModel *model = self.dataArr[indexPath.row];
    cell.model = model;

//    cell.orderState = @"待评价";
    cell.btnTitles = @[@"在线客服", @"查看详情"];
    NSString *realFinalMoney = [NSString stringWithFormat:@"已付尾款：￥%@", model.productRealBalance];
    NSString *realDepositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productRealDeposit];
    cell.costMessage = @[realFinalMoney, realDepositMoney];

    __weak typeof(self) weakSelf = self;
    cell.clickBtnBlock = ^(NSString *btnText){
        [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
    };
    cell.editBlock = ^(){
        DLog(@"编辑");
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 330;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
}
- (void)clickBtnActionWithBtnTitle:(NSString *)title orderModel:(SellerProtectModel *)orderModel {

    if ([title isEqualToString:@"在线客服"]) {
        [self clickServiceBtnAction];
        
    }else if ([title isEqualToString:@"查看详情"]){
        SellerOrderDetailProtectPowerViewController *orderPPVC = [[SellerOrderDetailProtectPowerViewController alloc] init];
        orderPPVC.orderID = orderModel.ID;
        orderPPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderPPVC animated:YES];
    }
}
@end
