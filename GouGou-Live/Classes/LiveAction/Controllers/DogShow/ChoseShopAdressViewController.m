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
#import "ShopAdressModel.h"

@interface ChoseShopAdressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView; /**< tableView */


@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */


@property(nonatomic, strong) ShopAdressModel *adressModel; /**< 收货地址 */

@end

static NSString *cellid = @"ChoseShopAdressCell";

@implementation ChoseShopAdressViewController
#pragma mark
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
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
}
- (void)initUI {
    [self addRightBarButtonitem];
    self.title = @"选择收货地址";
    
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

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    NSNotification* notification = [NSNotification notificationWithName:@"ShopAdress" object:self.dataArr[indexPath.row]];
    NSNotification* notification = [NSNotification notificationWithName:@"ShopAdress" object:@"test"];

    [[NSNotificationCenter defaultCenter] postNotification:notification];
    DLog(@"test");
    [self.navigationController popViewControllerAnimated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArr.count;
    return 5;
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
