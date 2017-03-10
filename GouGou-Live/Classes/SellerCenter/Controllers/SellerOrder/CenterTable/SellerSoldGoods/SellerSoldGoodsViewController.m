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
#import "SellerProtectModel.h"
#import "SellerSendAlertView.h"

@interface SellerSoldGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int page;
}
@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */
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
                           @"user_id":[UserInfos sharedUser].ID,
                           @"status":@(0),
                           @"page":@(page),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self showHudInView:self.tableView hint:@"加载中"];
    [self getRequestWithPath:API_My_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        if (successJson) {
//            self.dataArr = [SellerOrderModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
//            [self.tableView reloadData];
//        }
//        [self hideHud];
        if (page == 1) {
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

    [self getRequestAllOrder];

    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getRequestAllOrder];
        
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getRequestAllOrder];
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
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
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
        _tableView.tableFooterView = [[UIView alloc] init];

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
    
    if ([model.status integerValue] == 1){ // 1：待付款
        
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        cell.model = model;
        cell.orderState = @"待付款";
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];

        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];

        __weak typeof(self) weakSelf = self;
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };

        return cell;
    }else if ([model.status integerValue] == 2){ // 2：待付定金
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        cell.model = model;
        cell.orderState = @"待付定金";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.btnTitles = @[@"联系买家", @"修改运费"];

        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];

        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };

        return cell;
    }else if ([model.status integerValue] == 3){ //3：已付定金，待付尾款
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        cell.model = model;
        cell.orderState = @"待付尾款";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.btnTitles = @[@"联系买家", @"修改运费"];
        NSString *depositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productDeposit];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        cell.costMessage = @[depositMoney, finalMoney];
        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };
        return cell;
    }else if ([model.status integerValue] == 4){ // 4：放弃订金，交易结束
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.orderState = @"交易关闭";
        cell.model = model;
        
        return cell;
    }else if ([model.status integerValue] == 5){ // 5：待付全款
        
        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
        cell.model = model;

        cell.orderState = @"待付全款";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.btnTitles = @[@"联系买家", @"修改运费"];
        NSString *allMoney = [NSString stringWithFormat:@"全款：￥%@", model.productPrice];
        cell.costMessage = @[allMoney];

        [self.btnTitles addObject:cell.btnTitles];
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };
        
        return cell;
    }else if ([model.status integerValue] == 6){ // 
        
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.model = model;
        cell.orderState = @"交易关闭";
        return cell;
    }else if ([model.status integerValue] == 7){ // 7：已付清款，待发货
        SellerWaitSendCell *cell = [tableView dequeueReusableCellWithIdentifier:waitSendCell];
        cell.model = model;
        cell.orderState = @"待发货";
        
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
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };
        return cell;
    }else if ([model.status integerValue] == 8){ // 8：已发货，待收货
        
        SellerWaitAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:waitAcceptCell];
        cell.model = model;
        
        cell.orderState = @"待发货";
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
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };
        cell.editBlock = ^(){
            DLog(@"编辑");
        };
        
        return cell;
    }else if ([model.status integerValue] == 9){ // 9: 已收货，待评价
        SellerWaitRateCell *cell = [tableView dequeueReusableCellWithIdentifier:waitRateCell];
        
        cell.model = model;
        
        cell.orderState = @"待评价";
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
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };
        
        return cell;

    }else if ([model.status integerValue] == 10){ // 10：已评价
        SellerWaitRateCell *cell = [tableView dequeueReusableCellWithIdentifier:waitRateCell];
        
        cell.model = model;
        
        cell.orderState = @"已评价";
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
        [self.states addObject:cell.orderState];
        
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
        };
        
        cell.editBlock = ^(){
            DLog(@"编辑");
            // 
        };
        return cell;

    }else if ([model.status integerValue] == 20){ //   20：订单取消
        
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.model = model;
        cell.deleBlock = ^(){
//            self 
        };
        cell.orderState = @"交易关闭";
        return cell;
    }else if ([model.status integerValue] == 21){ // 21：交易关闭
        
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cell.model = model;
        cell.orderState = @"交易关闭";
        return cell;
    }

    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    SellerOrderModel *model = self.dataArr[indexPath.row];
    CGFloat height = 230;
    if ([model.status integerValue] == 0) { //
        height = 330;
    }else if ([model.status integerValue] == 1){ // 1：待付款
        height = 245;
    }else if ([model.status integerValue] == 2){ // 2：待付定金
        height = 245;
    }else if ([model.status integerValue] == 3){ //3：已付定金，待付尾款
        height = 245;
    }else if ([model.status integerValue] == 4){ // 4：放弃订金，交易结束
        height = 245;
    }else if ([model.status integerValue] == 5){ // 5：待付全款
        height = 245;
    }else if ([model.status integerValue] == 6){ //
        height = 245;
    }else if ([model.status integerValue] == 7){ // 7：已付清款，待发货
        height = 245;
    }else if ([model.status integerValue] == 8){ // 8：已发货，待收货
        height = 330;
    }else if ([model.status integerValue] == 9){ // 9: 已收货，待评价
        height = 330;
    }else if ([model.status integerValue] == 10){ // 10：已评价
        height = 330;
    }else if ([model.status integerValue] == 20){ //   20：订单取消
        height = 220;
    }else if ([model.status integerValue] == 21){ // 21：交易关闭
        height = 220;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SellerOrderModel *model = self.dataArr[indexPath.row];

    if ([model.status integerValue] == 0) { //

    }else if ([model.status integerValue] == 1){ // 1：待付款

        SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
        adressVC.hidesBottomBarWhenPushed = YES;
        adressVC.bottomBtns = self.btnTitles[indexPath.row];
        adressVC.orderState = self.states[indexPath.row];
        adressVC.orderID = model.ID;
        [self.navigationController pushViewController:adressVC animated:YES];

    }else if ([model.status integerValue] == 2){ // 2：待付定金

        SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
        adressVC.hidesBottomBarWhenPushed = YES;
        adressVC.bottomBtns = self.btnTitles[indexPath.row];
        adressVC.orderState = self.states[indexPath.row];
        adressVC.orderID = model.ID;
        [self.navigationController pushViewController:adressVC animated:YES];

    }else if ([model.status integerValue] == 3){ //3：已付定金，待付尾款

        SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
        adressVC.hidesBottomBarWhenPushed = YES;
        adressVC.bottomBtns = self.btnTitles[indexPath.row];
        adressVC.orderState = self.states[indexPath.row];
        adressVC.orderID = model.ID;
        [self.navigationController pushViewController:adressVC animated:YES];

    }else if ([model.status integerValue] == 4){ // 4：放弃订金，交易结束

    }else if ([model.status integerValue] == 5){ // 5：待付全款
        SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
        adressVC.hidesBottomBarWhenPushed = YES;
        adressVC.bottomBtns = self.btnTitles[indexPath.row];
        adressVC.orderState = self.states[indexPath.row];
        adressVC.orderID = model.ID;
        [self.navigationController pushViewController:adressVC animated:YES];

    }else if ([model.status integerValue] == 6){ //

    }else if ([model.status integerValue] == 7){ // 7：已付清款，待发货
        SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
        adressVC.hidesBottomBarWhenPushed = YES;
        adressVC.bottomBtns = self.btnTitles[indexPath.row];
        adressVC.orderState = @"待发货";
        adressVC.orderID = model.ID;
        [self.navigationController pushViewController:adressVC animated:YES];
    }else if ([model.status integerValue] == 8){ // 8：已发货，待收货
        SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
        logisticsInfoVC.orderState = @"待收货";
        SellerOrderModel *model = self.dataArr[indexPath.row];
        logisticsInfoVC.orderID = model.ID;
        logisticsInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:logisticsInfoVC animated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    }else if ([model.status integerValue] == 9){ // 9: 已收货，待评价
        SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        logisticsInfoVC.orderState = @"待评价";
        SellerOrderModel *model = self.dataArr[indexPath.row];
        logisticsInfoVC.orderID = model.ID;
        
        logisticsInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:logisticsInfoVC animated:YES];
        

    }else if ([model.status integerValue] == 10){ // 10：已评价
        SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
        logisticsInfoVC.orderState = @"已完成";
        SellerOrderModel *model = self.dataArr[indexPath.row];
        logisticsInfoVC.orderID = model.ID;
        logisticsInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:logisticsInfoVC animated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if ([model.status integerValue] == 20){ //   20：订单取消

    }else if ([model.status integerValue] == 21){ // 21：交易关闭

    }
    
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
//        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
//        changeVC.title = title;
//        changeVC.orderID = orderModel.ID;
//        changeVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:changeVC animated:YES];
        [self showAlert:@"暂无运费，无法修改"];
    }else if ([title isEqualToString:@"修改价格"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.orderID = orderModel.ID;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"发货"]){
        
        SellerSendAlertView *sendView = [[SellerSendAlertView alloc] init];
        sendView.orderID = orderModel.ID;
        
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
                    [self getRequestAllOrder];
                }else{
                    weakSend.successNote.text = @"订单发货失败";
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        [sendView show];

    }else if ([title isEqualToString:@"查看评价"]){
        
        SellerAcceptedRateViewController *rateVC = [[SellerAcceptedRateViewController alloc] init];
        rateVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rateVC animated:YES];
    }else if ([title isEqualToString:@"查看详情"]){
        SellerOrderDetailProtectPowerViewController *orderPPVC = [[SellerOrderDetailProtectPowerViewController alloc] init];
        orderPPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderPPVC animated:YES];

    }else if ([title isEqualToString:@"在线客服"]){
        
        [self clickServiceBtnAction];
    }
}
@end
