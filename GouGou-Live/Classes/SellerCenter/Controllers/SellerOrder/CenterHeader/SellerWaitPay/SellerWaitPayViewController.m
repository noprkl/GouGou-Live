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
{
    int page;
}
@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

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
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"status":@(1),
                           @"page":@(page),
                           @"pageSize":@(10)
                           };
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_My_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
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
    [self getRequestWaitPayOrder];
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getRequestWaitPayOrder];
        
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getRequestWaitPayOrder];
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
        cell.orderState = @"待付款";
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];

    }else if ([model.status isEqualToString:@"2"]) {
        cell.orderState = @"待付定金";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.btnTitles = @[@"联系买家", @"修改运费"];// 修改价格功能暂时注掉
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", model.productDeposit];
        cell.costMessage = @[finalMoney, depositMoney];
    }else if ([model.status isEqualToString:@"3"]) {
        cell.orderState = @"待付尾款";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.btnTitles = @[@"联系买家", @"修改运费"];// 修改价格功能暂时注掉
        NSString *depositMoney = [NSString stringWithFormat:@"已付定金：￥%@", model.productDeposit];
        NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", model.productBalance];
        cell.costMessage = @[depositMoney, finalMoney];
    }else if ([model.status isEqualToString:@"5"]) {
        cell.orderState = @"待付全款";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.btnTitles = @[@"联系买家", @"修改运费"];// 修改价格功能暂时注掉
        NSString *allMoney = [NSString stringWithFormat:@"全款：￥%@", model.productPrice];
        cell.costMessage = @[allMoney];
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
    
    return 255;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SellerOrderModel *model = self.dataArr[indexPath.row];
    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
    adressVC.hidesBottomBarWhenPushed = YES;
    adressVC.bottomBtns = self.btnTitles[indexPath.row];
    adressVC.orderState = self.states[indexPath.row];
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
    }
}
@end
