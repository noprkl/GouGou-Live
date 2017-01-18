//
//  SystemNotificationViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SystemNotificationViewController.h"
#import "SystemNotificationCell.h"
#import "SystemPushMessageModel.h"
#import "FavoriteDogDetailVc.h"
#import "PushOrderMesageModel.h"
// 跳转
#import "OrderWaitAssessViewController.h" // 待评价
#import "PayBackMoneyViewController.h"// 代付尾款
#import "PayFontMoneyViewController.h"// 代付定金
#import "PayingAllMoneyViewController.h"// 待付全款
#import "SureConsigneedViewController.h" // 待收货
#import "WaitSellConsigmentViewContorller.h" // 待发货
#import "OrderCompleteAssess.h"

//
#import "SellerOrderDetailAdressViewController.h"
#import "SellerOrderDetailLogisticsInfoViewController.h"

@interface SystemNotificationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SystemNotificationCell";

@implementation SystemNotificationViewController
// 获得系统通知消息
- (void)postRequestGetSystemPush {
    // ([[UserInfos sharedUser].ID integerValue])
    if ([UserInfos getUser]) {
        NSDictionary *dict = @{@"user_id":[UserInfos sharedUser].ID};
        [self showHudInView:self.view hint:@"加载中"];
        [self getRequestWithPath:API_System_msg params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            if ([successJson[@"code"] isEqualToString:@"1"]) {
                self.dataArr = [SystemPushMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                [self.tableView reloadData];
            }
            [self hideHud];
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}

#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
    self.title = @"系统通知";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self postRequestGetSystemPush];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postRequestGetSystemPush];
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"SystemNotificationCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemPushMessageModel *model = self.dataArr[indexPath.row];
    CGSize size = [model.conent boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingTruncatesLastVisibleLine attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"], NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return 50 + size.height + 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
// cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SystemPushMessageModel *messageModel = self.dataArr[indexPath.row];
    // 未读消息标记
    if ([messageModel.status integerValue] == 0) {
        NSDictionary *dict = @{
                               @"user_id":[UserInfos sharedUser].ID,
                               @"lid":@(messageModel.ID)
                               };
        [self getRequestWithPath:API_System_msg_status params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
    
    if ([messageModel.type integerValue] == 1) { // 商品类消息
     
        FavoriteDogDetailVc *dogDetailVc = [[FavoriteDogDetailVc alloc] init];
        dogDetailVc.dogID = messageModel.productId;
        [self.navigationController pushViewController:dogDetailVc animated:YES];
  
    }else if ([messageModel.type integerValue] == 2){ // 订单类消息
        // 判断当前用户是卖家还是买家
        NSDictionary * dict = @{@"id":messageModel.productId};
        // 请求订单
        [self showHudInView:self.view hint:@"加载中.."];
        [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
            
            DLog(@"%@", successJson);
            // 订单状态
            PushOrderMesageModel *orderInfo = [PushOrderMesageModel mj_objectWithKeyValues:successJson[@"data"]];
            if ([messageModel.state integerValue] == 0) {// 当前用户是买家
                if ([orderInfo.status isEqualToString:@"1"]) {
                    
                }else if ([orderInfo.status isEqualToString:@"2"]) {
                    
                    //        state = @"待付定金";
                    PayFontMoneyViewController *Vc = [[PayFontMoneyViewController alloc] init];
                    Vc.orderID = orderInfo.ID;
                    Vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vc animated:YES];
                    
                }else if ([orderInfo.status isEqualToString:@"3"]) {
                    
                    //        state = @"待付尾款";
                    PayBackMoneyViewController *Vc = [[PayBackMoneyViewController alloc] init];
                    Vc.hidesBottomBarWhenPushed = YES;
                    Vc.orderID = orderInfo.ID;
                    [self.navigationController pushViewController:Vc animated:YES];
                    
                }else if ([orderInfo.status isEqualToString:@"4"]) {
                    
                    //        state = @"";
                    [self showAlert:@"交易已经关闭"];
                }else if ([orderInfo.status isEqualToString:@"5"]) {
                    
                    //        state = @"待付全款";
                    PayingAllMoneyViewController *Vc = [[PayingAllMoneyViewController alloc] init];
                    Vc.orderID = orderInfo.ID;
                    Vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vc animated:YES];
                    
                }else if ([orderInfo.status isEqualToString:@"6"]) {
                    
                    //        state = @"";
                    
                }else if ([orderInfo.status isEqualToString:@"7"]) {
                    
                    //        state = @"待发货";
                    WaitSellConsigmentViewContorller *Vc = [[WaitSellConsigmentViewContorller alloc] init];
                    Vc.orderID = orderInfo.ID;
                    Vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vc animated:YES];
                    
                }else if ([orderInfo.status isEqualToString:@"8"]) {
                    
                    //        state = @"待收货";
                    SureConsigneedViewController *Vc = [[SureConsigneedViewController alloc] init];
                    Vc.orderID = orderInfo.ID;
                    Vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vc animated:YES];
                }else if ([orderInfo.status isEqualToString:@"9"]) {
                    
                    //        state = @"未评价";
                    
                    OrderWaitAssessViewController *Vc = [[OrderWaitAssessViewController alloc] init];
                    Vc.orderID = orderInfo.ID;
                    Vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vc animated:YES];
                    
                }else if ([orderInfo.status isEqualToString:@"10"]) {
                    
                    //        state = @"已评价";
                    OrderCompleteAssess *Vc = [[OrderCompleteAssess alloc] init];
                    Vc.orderID = orderInfo.ID;
                    Vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Vc animated:YES];
                }else if ([orderInfo.status isEqualToString:@"20"]) {
                    [self showAlert:@"交易已经关闭"];
                }
            
            }else if ([messageModel.state integerValue] == 1){// 当前用户是卖家
                if ([orderInfo.status integerValue] == 0) { //
                    
                }else if ([orderInfo.status integerValue] == 1){ // 1：待付款
                    
                    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
                    adressVC.hidesBottomBarWhenPushed = YES;
                    adressVC.bottomBtns = @[@"联系买家", @"修改运费", @"修改价格"];
                    adressVC.orderState = @"待付款";
                    adressVC.orderID = orderInfo.ID;
                    [self.navigationController pushViewController:adressVC animated:YES];
                    
                }else if ([orderInfo.status integerValue] == 2){ // 2：待付定金
                    
                    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
                    adressVC.hidesBottomBarWhenPushed = YES;
                    adressVC.bottomBtns = @[@"联系买家", @"修改运费", @"修改价格"];
                    adressVC.orderState = @"待付定金";
                    adressVC.orderID = orderInfo.ID;
                    [self.navigationController pushViewController:adressVC animated:YES];
                    
                }else if ([orderInfo.status integerValue] == 3){ //3：已付定金，待付尾款
                    
                    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
                    adressVC.hidesBottomBarWhenPushed = YES;
                    adressVC.bottomBtns = @[@"联系买家", @"修改运费", @"修改价格"];
                    adressVC.orderState = @"待付尾款";
                    adressVC.orderID = orderInfo.ID;
                    [self.navigationController pushViewController:adressVC animated:YES];
                    
                }else if ([orderInfo.status integerValue] == 4){ // 4：放弃订金，交易结束
                    [self showAlert:@"交易已经关闭"];
                }else if ([orderInfo.status integerValue] == 5){ // 5：待付全款
                    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
                    adressVC.hidesBottomBarWhenPushed = YES;
                    adressVC.bottomBtns = @[@"联系买家"];
                    adressVC.orderState = @"待付全款";
                    adressVC.orderID = orderInfo.ID;
                    [self.navigationController pushViewController:adressVC animated:YES];
                    
                }else if ([orderInfo.status integerValue] == 6){ //
                    
                }else if ([orderInfo.status integerValue] == 7){ // 7：已付清款，待发货
                    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
                    adressVC.hidesBottomBarWhenPushed = YES;
                    adressVC.bottomBtns = @[@"联系买家", @"发货"];
                    adressVC.orderState = @"待发货";
                    adressVC.orderID = orderInfo.ID;
                    [self.navigationController pushViewController:adressVC animated:YES];
                }else if ([orderInfo.status integerValue] == 8){ // 8：已发货，待收货
                    SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
                    logisticsInfoVC.orderState = @"待收货";
                    logisticsInfoVC.orderID = orderInfo.ID;
                    logisticsInfoVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
                    
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    
                }else if ([orderInfo.status integerValue] == 9){ // 9: 已收货，待评价
                    SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                    
                    logisticsInfoVC.orderState = @"待评价";
                    logisticsInfoVC.orderID = orderInfo.ID;
                    
                    logisticsInfoVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
                    
                    
                }else if ([orderInfo.status integerValue] == 10){ // 10：已评价
                    SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
                    logisticsInfoVC.orderState = @"已完成";
                    logisticsInfoVC.orderID = orderInfo.ID;
                    logisticsInfoVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
                    
                    [tableView deselectRowAtIndexPath:indexPath animated:YES];
                }else if ([orderInfo.status integerValue] == 20){ //   20：订单取消
                    [self showAlert:@"订单已经取消"];
                }else if ([orderInfo.status integerValue] == 21){ // 21：交易关闭
                    [self showAlert:@"交易已经关闭"];
                }
            }
            [self hideHud];
        } error:^(NSError *error) {
            DLog(@"%@",error);
        }];
    }
}
// 侧滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete) {
        SystemPushMessageModel *model = self.dataArr[indexPath.row];
        NSDictionary *dict = @{
                               @"user_id":[UserInfos sharedUser].ID,
                               @"lid":@(model.ID)
                               };
        [self getRequestWithPath:API_System_msg_del params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self postRequestGetSystemPush];
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除此消息";
}

@end
