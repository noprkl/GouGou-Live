//
//  ChoseShopAdressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ChoseShopAdressViewController.h"
#import "ChoseShopAdressCell.h"
#import "ChosedAdressView.h" // 地址选择
#import "MyShopAdressModel.h"
#import "AddNewAdressVc.h"

@interface ChoseShopAdressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView; /**< tableView */


@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */


@property(nonatomic, strong) MyShopAdressModel *adressModel; /**< 收货地址 */

@end

static NSString *cellid = @"ChoseShopAdressCell";

@implementation ChoseShopAdressViewController
// 所有地址
- (void)postGetAdressRequest {
    
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID
                           };
    
    [self getRequestWithPath:API_Address params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        if (successJson[@"code"]) {
            // 数据解析
            self.dataArr = [[MyShopAdressModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]] mutableCopy];
          
            // 刷新
            [self.tableView reloadData];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}


#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self postGetAdressRequest];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)addRightBarButtonitem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickRightBarItemAction)];
}
- (void)clickRightBarItemAction {
    // 跳转添加地址界面
    AddNewAdressVc *editAdressVC = [[AddNewAdressVc alloc] init];
    editAdressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editAdressVC animated:YES];
    
}
- (void)initUI {
    [self addRightBarButtonitem];
    self.title = @"选择收货地址";

    self.edgesForExtendedLayout = 0;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
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
    cell.acceptAdress = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    NSNotification* notification = [NSNotification notificationWithName:@"ShopAdress" object:self.dataArr[indexPath.row]];
   
    // 注册
    NSDictionary *info = @{
                           @"ShopAdress":self.dataArr[indexPath.row]
                           };
    NSNotification* notification = [NSNotification notificationWithName:@"ShopAdress" object:nil userInfo:info];

    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];

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
}

@end
