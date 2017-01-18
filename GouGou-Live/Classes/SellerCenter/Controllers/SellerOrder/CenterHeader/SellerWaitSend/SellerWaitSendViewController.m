//
//  SellerWaitSendViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitSendViewController.h"
#import "SellerWaitSendCell.h"
#import "SellerSendAlertView.h"

@interface SellerWaitSendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSMutableArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSMutableArray *states; /**< 状态数组 */

@end

static NSString *cellid = @"SellerWaitSendCell";

@implementation SellerWaitSendViewController
#pragma mark
#pragma mark - 网络请求
// 请求待发货的订单
- (void)getRequestWaitSendOrder {
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"status":@(2),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_My_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [SellerOrderModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
        [self hideHud];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestWaitSendOrder];
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getRequestWaitSendOrder];
        
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

        [_tableView registerClass:[SellerWaitSendCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerWaitSendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    SellerOrderModel *model = self.dataArr[indexPath.row];
    cell.model = model;cell.orderState = @"待发货";
    
    cell.btnTitles = @[@"联系买家", @"发货"];
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
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 255;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SellerOrderModel *model = self.dataArr[indexPath.row];
    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
    adressVC.hidesBottomBarWhenPushed = YES;
    adressVC.bottomBtns = self.btnTitles[indexPath.row];
    adressVC.orderState = @"待发货";
    adressVC.orderID = model.ID;
    [self.navigationController pushViewController:adressVC animated:YES];
}
#pragma mark
#pragma mark - 点击按钮Action
- (void)clickBtnActionWithBtnTitle:(NSString *)title orderModel:(SellerOrderModel *)orderModel {
    if ([title isEqualToString:@"联系买家"]) {
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:orderModel.buyUserId conversationType:(EMConversationTypeChat)];
        viewController.title = orderModel.buyUserId;
         viewController.chatID = orderModel.buyUserId;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }else if ([title isEqualToString:@"发货"]){
        
            SellerSendAlertView *sendView = [[SellerSendAlertView alloc] init];

            sendView.orderID = orderModel.orderId;
            __weak typeof(sendView) weakSend = sendView;

            sendView.commitBlock = ^(NSString *shipStyle, NSString *shipOrder){
                NSDictionary *dict = @{
                                       @"user_id":[UserInfos sharedUser].ID,
                                       @"id":orderModel.ID,
                                       @"waybill_number":shipOrder, // 运单号
                                       @"transportation":shipStyle
                                       };
                DLog(@"%@", dict);
                [self getRequestWithPath:API_Delivery params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    [self showAlert:successJson[@"message"]];
                    weakSend.successNote.hidden = NO;
                    if ([successJson[@"message"] isEqualToString:@"成功"]) {
                        weakSend.successNote.text = @"订单发货成功";
                        [weakSend dismiss];
                    }else{
                        weakSend.successNote.text = @"订单发货失败";
                    }
                    [self getRequestWaitSendOrder];
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            };
            [sendView show];
    }
}
@end
