//
//  SellerWaitAcceptViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitAcceptViewController.h"
#import "SellerWaitAcceptCell.h"
#import "SellerSendAlertView.h"

@interface SellerWaitAcceptViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int page;
}
@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) NSMutableArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSMutableArray *states; /**< 状态数组 */

@end

static NSString *cellid = @"SellerWaitAcceptCell";

@implementation SellerWaitAcceptViewController
#pragma mark
#pragma mark - 网络请求
// 请求待收货的订单
- (void)getRequestWaitAcceptOrder {
    NSDictionary *dict = @{// [[UserInfos sharedUser].ID integerValue]
                           @"user_id":[UserInfos sharedUser].ID,
                           @"status":@(3),
                           @"page":@(page),
                           @"pageSize":@(10)
                           };
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_My_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        self.dataArr = [SellerOrderModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
//        [self.tableView reloadData];
//        [self hideHud];
        if (page == 1) {
            [self.tableView.mj_footer resetNoMoreData];
            self.dataArr = [SellerOrderModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            [self hideHud];
            [self.tableView reloadData];
        }else{
            NSArray *array = [SellerOrderModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
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

    [self getRequestWaitAcceptOrder];
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getRequestWaitAcceptOrder];
        
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getRequestWaitAcceptOrder];
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
- (NSMutableArray *)btnTitles {
    if (!_btnTitles) {
        _btnTitles = [NSMutableArray array];
    }
    return _btnTitles;
}
- (NSMutableArray *)states {
    if (!_states) {
        _states = [NSMutableArray array];
    }
    return _states;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];

        [_tableView registerClass:[SellerWaitAcceptCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerWaitAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    SellerOrderModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    cell.orderState = @"待收货";
    cell.btnTitles = @[@"联系买家"];
    if (model.productRealPrice.length == 0) {
        NSString *finalMoney = [NSString stringWithFormat:@"已付尾款：￥%@", model.productRealBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productRealDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
    }else{
        NSString *allMoney = [NSString stringWithFormat:@"已付全款：￥%@", model.productRealPrice];
        cell.costMessage = @[allMoney];
    }
    [self.btnTitles addObject:cell.btnTitles];

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
    
    return 345;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
    logisticsInfoVC.orderState = @"待收货";
    SellerOrderModel *model = self.dataArr[indexPath.row];
    logisticsInfoVC.orderID = model.ID;
    logisticsInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark
#pragma mark - 点击按钮Action
- (void)clickBtnActionWithBtnTitle:(NSString *)title orderModel:(SellerOrderModel *)orderModel {
    
    if ([title isEqualToString:@"联系买家"]) {
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:orderModel.buyUserId conversationType:(EMConversationTypeChat)];
        viewController.title = orderModel.buyUserId;
        viewController.chatID = orderModel.buyUserId;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if ([title isEqualToString:@"修改运费"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"修改价格"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"发货"]){
        
               
    }else if ([title isEqualToString:@"查看评价"]){
        
        SellerAcceptedRateViewController *rateVC = [[SellerAcceptedRateViewController alloc] init];
        rateVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rateVC animated:YES];
    }else if ([title isEqualToString:@"未评价"]){
        DLog(@"%@", title);
    }else if ([title isEqualToString:@"查看详情"]){
        
    }else if ([title isEqualToString:@"在线客服"]){
               [self clickServiceBtnAction];
    }
}

@end
