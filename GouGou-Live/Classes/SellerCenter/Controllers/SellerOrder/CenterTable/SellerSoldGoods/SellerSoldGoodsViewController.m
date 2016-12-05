//
//  SellerSoldGoodsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerSoldGoodsViewController.h"

#import "SellerWaitAcceptCell.h"
#import "SellerWaitPayCell.h"
#import "SellerWaitRateCell.h"
#import "SellerWaitSendCell.h"
#import "SellerProtectPowerCell.h"
#import "SellerCloseCell.h"
#import "SellerOrderModel.h"

@interface SellerSoldGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */
@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) NSMutableArray *cellStates; /**< cell数组 */

@property(nonatomic, strong) NSMutableArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSMutableArray *states; /**< 状态 */

@end

static NSString *waitAcceptCell = @"SellerWaitAcceptCell";
static NSString *waitPayCell = @"SellerWaitPayCell";
static NSString *waitRateCell = @"SellerWaitRateCell";
static NSString *waitSendCell = @"SellerWaitSendCell";
static NSString *protectPowerCell = @"SellerProtectPowerCell";
static NSString *closeCell = @"SellerCloseCell";

@implementation SellerSoldGoodsViewController

// 请求所有的订单
- (void)getRequestAllOrder {
    NSDictionary *dict = @{
                           @"user_id":@(11),
                           @"status":@(1),
                           @"page":@(1),
                           @"pageSize":@(10),
                           @"is_right":@(1)
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_My_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestAllOrder];

    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getRequestAllOrder];
        
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
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)cellStates {
    if (!_cellStates) {
        _cellStates = [NSMutableArray array];
    }
    return _cellStates;
}
- (NSMutableArray *)states {
    if (!_states) {
        _states = [NSMutableArray array];
    }
    return _states;
}
- (NSMutableArray *)btnTitles {
    if (!_btnTitles) {
        _btnTitles = [NSMutableArray array];
    }
    return _btnTitles;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerWaitAcceptCell class] forCellReuseIdentifier:waitAcceptCell];
        [_tableView registerClass:[SellerWaitPayCell class] forCellReuseIdentifier:waitPayCell];
        [_tableView registerClass:[SellerWaitRateCell class] forCellReuseIdentifier:waitRateCell];
        [_tableView registerClass:[SellerWaitSendCell class] forCellReuseIdentifier:waitSendCell];
        [_tableView registerClass:[SellerProtectPowerCell class] forCellReuseIdentifier:protectPowerCell];
        [_tableView registerClass:[SellerCloseCell class] forCellReuseIdentifier:closeCell];
        
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    SellerOrderModel *model = self.dataArr[indexPath.row];
    
    if ([model.status integerValue] == 0) { //
        
        SellerWaitAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:waitAcceptCell];

        cell.orderState = @"待发货";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.costMessage = @[@"全款：¥ 950"];
        
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };

        return cell;
    }else if ([model.status integerValue] == 1){ // 1：待付款
        
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];

        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        __weak typeof(self) weakSelf = self;
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };

        return cell;
    }else if ([model.status integerValue] == 2){ // 2：待付定金
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        
        cell.orderState = @"待付全款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        NSString *allMoney = [NSString stringWithFormat:@"全款：￥%@", model.price];
        cell.costMessage = @[allMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };

        return cell;
    }else if ([model.status integerValue] == 3){ //3：已付定金，待付尾款
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        
        cell.orderState = @"待付尾款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        cell.costMessage = @[finalMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        return cell;
    }else if ([model.status integerValue] == 4){ // 4：放弃订金，交易结束
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.orderState = @"交易关闭";

        return cell;
    }else if ([model.status integerValue] == 5){ // 5：待付全款
        
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        
        return cell;
    }else if ([model.status integerValue] == 6){ // 
        
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];

        cell.orderState = @"交易关闭";
        return cell;
    }else if ([model.status integerValue] == 7){ // 7：已付清款，待发货
        SellerWaitSendCell *cell = [tableView dequeueReusableCellWithIdentifier:waitSendCell];
        SellerOrderModel *model = self.dataArr[indexPath.row];
        cell.model = model;cell.orderState = @"待发货";
        
        cell.btnTitles = @[@"联系买家", @"发货"];
        NSString *finalMoney = [NSString stringWithFormat:@"已付尾款：￥%@", model.productRealBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productRealDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        return cell;
    }else if ([model.status integerValue] == 8){ // 8：已发货，待收货
        
        SellerWaitAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:waitAcceptCell];
        SellerOrderModel *model = self.dataArr[indexPath.row];
        cell.model = model;
        
        cell.orderState = @"待发货";
        cell.btnTitles = @[@"联系买家"];
        NSString *allMoney = [NSString stringWithFormat:@"已付全款：￥%@", model.price];
        
        cell.costMessage = @[allMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.editBlock = ^(){
            DLog(@"编辑");
        };
        
        return cell;
    }else if ([model.status integerValue] == 9){ // 9: 已收货，待评价
        SellerWaitRateCell *cell = [tableView dequeueReusableCellWithIdentifier:waitRateCell];
        
        SellerOrderModel *model = self.dataArr[indexPath.row];
        cell.model = model;
        
        cell.orderState = @"待评价";
        cell.btnTitles = @[@"联系买家"];
        NSString *realFinalMoney = [NSString stringWithFormat:@"已付尾款：￥%@", model.productRealBalance];
        NSString *realDepositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productRealDeposit];
        cell.costMessage = @[realFinalMoney, realDepositMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        
        return cell;

    }else if ([model.status integerValue] == 10){ // 10：已评价
        SellerWaitRateCell *cell = [tableView dequeueReusableCellWithIdentifier:waitRateCell];
        
        SellerOrderModel *model = self.dataArr[indexPath.row];
        cell.model = model;
        
        cell.orderState = @"待评价";
        cell.btnTitles = @[@"联系买家"];
        NSString *realFinalMoney = [NSString stringWithFormat:@"已付尾款：￥%@", model.productRealBalance];
        NSString *realDepositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productRealDeposit];
        cell.costMessage = @[realFinalMoney, realDepositMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        
        cell.editBlock = ^(){
            DLog(@"编辑");
            // 
        };
        return cell;

    }else if ([model.status integerValue] == 20){ //   20：订单取消
        
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.orderState = @"交易关闭";
        return cell;
    }else if ([model.status integerValue] == 21){ // 21：交易关闭
        
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.orderState = @"交易关闭";
        return cell;
    }
//    if ([model.status integerValue] == 5){
//        
//        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
//        cellid = closeCell;
//        cell.orderState = @"交易关闭";
//        return cell;
//    }else if ([model.status integerValue] == 5){
//        
//        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
//        cellid = closeCell;
//        cell.orderState = @"交易关闭";
//        return cell;
//    }else if ([model.status integerValue] == 5){
//        
//        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
//        cellid = closeCell;
//        cell.orderState = @"交易关闭";
//        return cell;
//    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    SellerOrderModel *model = self.dataArr[indexPath.row];
    CGFloat height = 230;
    if ([model.status integerValue] == 0) { //
        height = 330;
    }else if ([model.status integerValue] == 1){ // 1：待付款
        height = 230;
    }else if ([model.status integerValue] == 2){ // 2：待付定金
        height = 230;
    }else if ([model.status integerValue] == 3){ //3：已付定金，待付尾款
        height = 230;
    }else if ([model.status integerValue] == 4){ // 4：放弃订金，交易结束
        height = 230;
    }else if ([model.status integerValue] == 5){ // 5：待付全款
        height = 230;
    }else if ([model.status integerValue] == 6){ //
        height = 230;
    }else if ([model.status integerValue] == 7){ // 7：已付清款，待发货
        height = 230;
    }else if ([model.status integerValue] == 8){ // 8：已发货，待收货
        height = 330;
    }else if ([model.status integerValue] == 9){ // 9: 已收货，待评价
        height = 330;
    }else if ([model.status integerValue] == 10){ // 10：已评价
        height = 330;
    }else if ([model.status integerValue] == 20){ //   20：订单取消
        height = 230;
    }else if ([model.status integerValue] == 21){ // 21：交易关闭
        height = 230;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark
#pragma mark - 点击按钮Action

- (void)clickBtnActionWithBtnTitle:(NSString *)title {
    
    
    if ([title isEqualToString:@"联系买家"]) {
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat2;
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
        
        SellerSendViewController *sendVC = [[SellerSendViewController alloc] init];
        sendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sendVC animated:YES];
        
    }else if ([title isEqualToString:@"查看评价"]){
        
        SellerAcceptedRateViewController *rateVC = [[SellerAcceptedRateViewController alloc] init];
        rateVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rateVC animated:YES];
    }else if ([title isEqualToString:@"查看详情"]){
        SellerOrderDetailProtectPowerViewController *orderPPVC = [[SellerOrderDetailProtectPowerViewController alloc] init];
        orderPPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderPPVC animated:YES];

    }else if ([title isEqualToString:@"在线客服"]){
        
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat2;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
@end
