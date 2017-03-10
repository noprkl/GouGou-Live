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
{
    int page;
}
@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SellerProtectPowerCell";

@implementation SellerProtectPowerViewController
#pragma mark
#pragma mark - 网络请求
// 请求维权的订单
- (void)getRequestProtectPowerOrder {
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"page":@(page),
                           @"pageSize":@(10),
                           };
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_My_activist params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        self.dataArr = [SellerProtectModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
//        [self.tableView reloadData];
//        [self hideHud];
        
        if (page == 1) {
            [self.tableView.mj_footer resetNoMoreData];
            self.dataArr = [SellerProtectModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            [self hideHud];
            [self.tableView reloadData];
        }else{
            NSArray *array = [SellerProtectModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            [self.dataArr addObjectsFromArray:array];
            [self hideHud];
            [self.tableView reloadData];
            if (array.count < 10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                page -= 1;
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }

    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    page = 1;

    [self getRequestProtectPowerOrder];
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getRequestProtectPowerOrder];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getRequestProtectPowerOrder];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
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
    if (model.productRealPrice.length == 0) {
        NSString *finalMoney = [NSString stringWithFormat:@"已付尾款：￥%@", model.productRealBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productRealDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
    }else{
        NSString *allMoney = [NSString stringWithFormat:@"已付全款：￥%@", model.productRealPrice];
        cell.costMessage = @[allMoney];
    }
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
