//
//  SellerWaitPayViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitPayViewController.h"
#import "SellerWaitPayCell.h"

@interface SellerWaitPayViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSMutableArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSMutableArray *states; /**< 状态数组 */

@end

static NSString *cellid = @"SellerWaitPayCell";

@implementation SellerWaitPayViewController
#pragma mark
#pragma mark - 网络请求
// 请求待支付的订单
- (void)getRequestWaitPayOrder {
    NSDictionary *dict = @{//[[UserInfos sharedUser].ID integerValue]
                           @"user_id":@(11),
                           @"status":@(1),
                           @"page":@(1),
                           @"pageSize":@(10),
                           @"is_right":@(1)
                           };
    [self getRequestWithPath:API_My_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [SellerOrderModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestWaitPayOrder];
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getRequestWaitPayOrder];
        
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
}
#pragma mark
#pragma mark - 懒加载
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 62) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[SellerWaitPayCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    SellerOrderModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    if ([model.status isEqualToString:@"1"]) {
        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
    }else if ([model.status isEqualToString:@"2"]) {
        cell.orderState = @"待付全款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        NSString *allMoney = [NSString stringWithFormat:@"全款：￥%@", model.price];
        cell.costMessage = @[allMoney];
    }else if ([model.status isEqualToString:@"3"]) {
        cell.orderState = @"待付尾款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        cell.costMessage = @[finalMoney];
    }else if ([model.status isEqualToString:@"5"]) {
        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
    }
    
    [self.btnTitles addObject:cell.btnTitles];
    [self.states addObject:cell.orderState];
    __weak typeof(self) weakSelf = self;

    cell.clickBtnBlock = ^(NSString *btnText){
        [weakSelf clickBtnActionWithBtnTitle:btnText orderModel:model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 245;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
    adressVC.hidesBottomBarWhenPushed = YES;
    adressVC.bottomBtns = self.btnTitles[indexPath.row];
    adressVC.orderState = self.states[indexPath.row];
    [self.navigationController pushViewController:adressVC animated:YES];
}
#pragma mark
#pragma mark - 点击按钮Action
- (void)clickBtnActionWithBtnTitle:(NSString *)title orderModel:(SellerOrderModel *)orderModel {
    
    if ([title isEqualToString:@"联系买家"]) {
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat2;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }else if ([title isEqualToString:@"修改运费"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.orderID = orderModel.ID;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"修改价格"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.orderID = orderModel.ID;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }
    
}
@end
