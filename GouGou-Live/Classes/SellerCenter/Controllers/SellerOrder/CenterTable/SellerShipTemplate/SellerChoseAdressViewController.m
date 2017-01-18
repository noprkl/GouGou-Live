//
//  SellerChoseAdressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerChoseAdressViewController.h"
#import "ChoseShopAdressCell.h"
#import "ChosedAdressView.h" // 地址选择
#import "SellerAdressModel.h"

#import "SellerAddNewAdressVc.h"

@interface SellerChoseAdressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView; /**< tableView */


@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */


@property(nonatomic, strong) SellerAdressModel *adressModel; /**< 收货地址 */

@property(nonatomic, assign) BOOL isAdress; /**< 是否选择了地址 */

@end

static NSString *cellid = @"ChoseShopAdressCell";

@implementation SellerChoseAdressViewController
#pragma mark
#pragma mark - 网络请求
// 所有发货地址
- (void)postGetAdressRequest {
    
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue])
                           };
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_Seller_address params:dict success:^(id successJson) {
        DLog(@"1%@", successJson);
        // 数据解析
        self.dataArr = [[SellerAdressModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]] mutableCopy];
        // 刷新
        [self.tableView reloadData];
        [self hideHud];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self postGetAdressRequest];
    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self postGetAdressRequest];
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItemAction];
    [self initUI];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    self.hidesBottomBarWhenPushed = YES;
    // 注册
    NSNotification* notification = [NSNotification notificationWithName:@"SellerShopAderss" object:@"test"userInfo:@{@"ISAdress":@(_isAdress)}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
- (void)setNavBarItemAction {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
}
- (void)leftBackBtnAction {
    _isAdress = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addRightBarButtonitem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickRightBarItemAction)];
}
- (void)clickRightBarItemAction {
    // 跳转添加地址界面
    SellerAddNewAdressVc *editAdressVC = [[SellerAddNewAdressVc alloc] init];
    editAdressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editAdressVC animated:YES];
}
- (void)initUI {
    [self addRightBarButtonitem];
    self.title = @"选择发货地址";
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"ChoseShopAdressCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}

#pragma mark
#pragma mark - 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChoseShopAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    SellerAdressModel *model = self.dataArr[indexPath.row];
    cell.sendAdress = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerAdressModel *model = self.dataArr[indexPath.row];

    // 通知
    NSDictionary *dict = @{
                           @"ChoseSendAdress":model
                           };
    
    NSNotification *notification = [NSNotification notificationWithName:@"ChoseSendAdress" object:nil userInfo:dict];
    
    
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];
    _isAdress = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}@end
