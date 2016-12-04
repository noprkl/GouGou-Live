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

@interface SellerSoldGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */
@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) NSMutableArray *cellStates; /**< cell数组 */

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
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"status":@(0),
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
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        NSString  *cellid = @"";
    __weak typeof(self) weakSelf = self;

    if (indexPath.row == 0) {
        
        SellerWaitAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:waitAcceptCell];
            cellid = waitAcceptCell;

        cell.orderState = @"待发货";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.costMessage = @[@"全款：¥ 950"];

        return cell;
       
    }else if (indexPath.row == 1){

        SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:waitPayCell];
            cellid = waitPayCell;
        cell.orderState = @"待支付";
        cell.btnTitles = @[@"联系买家", @"发货"];
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.costMessage = @[@"定金：¥ 500", @"尾款：¥ 950"];

        return cell;
    }else if (indexPath.row == 2){
       
        SellerWaitRateCell *cell = [tableView dequeueReusableCellWithIdentifier:waitRateCell];
        cellid = waitRateCell;

        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.costMessage = @[@"已付全款：¥ 950"];

        return cell;
    }else if (indexPath.row == 3){
        SellerWaitSendCell *cell = [tableView dequeueReusableCellWithIdentifier:waitSendCell];
        cellid = waitSendCell;

        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.costMessage = @[@"已付全款：¥ 1450"];
  
        return cell;
    }else if (indexPath.row == 4){
        SellerProtectPowerCell *cell = [tableView dequeueReusableCellWithIdentifier:protectPowerCell];
        cellid = protectPowerCell;

        cell.orderState = @"维权成功";
        cell.clickBtnBlock = ^(NSString *btnText){
            [weakSelf clickBtnActionWithBtnTitle:btnText];
        };
        cell.costMessage = @[@"已付全款：¥ 950"];
        return cell;
    }else if (indexPath.row == 5){
    
        SellerCloseCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
        cellid = closeCell;
        cell.orderState = @"交易关闭";
        return cell;
    }
    
    [self.cellStates addObject:cellid];
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString *cellid = self.cellStates[indexPath.row];
//    if ([cellid isEqualToString:waitAcceptCell]) {
//        return 330;
//    }else if ([cellid isEqualToString:waitPayCell]) {
//        return 230;
//    }else if ([cellid isEqualToString:waitRateCell]) {
//        return 330;
//    }else if ([cellid isEqualToString:waitSendCell]) {
//        return 230;
//    }else if ([cellid isEqualToString:protectPowerCell]) {
//        return 330;
//    }else if ([cellid isEqualToString:closeCell]) {
//        return 230;
//    }
    
    if (indexPath.row == 0) {
        return 330;
    }else if (indexPath.row == 1) {
        return 245;
    }else if (indexPath.row == 2) {
        return 330;
    }else if (indexPath.row == 3) {
        return 245;
    }else if (indexPath.row == 4) {
        return 330;
    }else if (indexPath.row == 5) {
        return 210;
    }

    return 230;
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
    }else if ([title isEqualToString:@"未评价"]){
        DLog(@"%@", title);
    }else if ([title isEqualToString:@"查看详情"]){
        
    }else if ([title isEqualToString:@"在线客服"]){
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat2;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}
@end
