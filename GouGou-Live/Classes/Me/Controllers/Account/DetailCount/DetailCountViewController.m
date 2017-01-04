//
//  DetailCountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DetailCountViewController.h"
#import "DetailCountTopView.h"
#import "DetailCountViewCell.h"
#import "UserAssetModel.h"
#import "PaymentDetailsController.h"

@interface DetailCountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) DetailCountTopView *centerView; /**< headerView */

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 总数据源 */
@property(nonatomic, strong) NSArray *allcomeArr; /**< 全部 */
@property(nonatomic, strong) NSMutableArray *incomeArr; /**< 收入 */
@property(nonatomic, strong) NSMutableArray *outComeArr; /**< 支出 */
@property(nonatomic, strong) NSMutableArray *payingArr; /**< 支付中 */
@property(nonatomic, strong) NSString *allCount; /**< 总收入 */
@property(nonatomic, strong) UILabel *headerLabel; /**< 头部内容 */

@property (nonatomic, strong) UIButton *lastBtn; /**< 点击按钮 */

@property (nonatomic, strong) NSString *income; /**< 收支 */

@end

static NSString *cellid = @"cellid";

@implementation DetailCountViewController
- (void)getReauestAssetDetail {
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"page":@(1),
                           @"pageSize":@(10),
                           @"type":@(0)
                           };
    [self getRequestWithPath:API_GetUserAssertDetai params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        
        self.dataArr = [UserAssetModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        self.allcomeArr = self.dataArr ;
//        NSString *income = successJson[@"data"][@"income"];
        if (successJson[@"data"][@"income"]==nil) {
            self.income=@"";
        }else {
            self.income = [NSString stringWithFormat:@"收支：%@", successJson[@"data"][@"income"]];
            }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getReauestAssetDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self setNavBarItem];
}
- (void)initUI {
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.title = @"收支明细";
    
    self.edgesForExtendedLayout = 0;
    
    [self.centerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo((SCREEN_HEIGHT - 44 - 64));
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([[self.lastBtn currentTitle] isEqualToString:@"全部"] || [[self.lastBtn currentTitle] isEqualToString:@"全部"]) {
            [self getReauestAssetDetail];
        }else if ([[self.lastBtn currentTitle] isEqualToString:@"收入"]){
            [self postGetAccountDetail:1];
        }else if ([[self.lastBtn currentTitle] isEqualToString:@"支出"]){
            [self postGetAccountDetail:2];
        }else if ([[self.lastBtn currentTitle] isEqualToString:@"交易中"]){
            [self postGetAccountDetail:3];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"DetailCountViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSArray *)allcomeArr {
    if (!_allcomeArr) {
        _allcomeArr = [NSArray array];
    }
    return _allcomeArr;
}
- (NSMutableArray *)payingArr {
    if (!_payingArr) {
        _payingArr = [NSMutableArray array];
    }
    return _payingArr;
}
- (NSMutableArray *)incomeArr {
    if (!_incomeArr) {
        _incomeArr = [NSMutableArray array];
    }
    return _incomeArr;
}
- (NSArray *)outComeArr {
    if (!_outComeArr) {
        _outComeArr = [NSMutableArray array];
    }
    return _outComeArr;
}
// 一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
//    return 10;
}
// 加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
// 头部添加内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        label.textColor = [UIColor colorWithHexString:@"#000000"];
        label.font = [UIFont systemFontOfSize:16];
        label.text = self.income;
        self.headerLabel = label;
        [view addSubview:label];
        
        return view;
    }
    return nil;
}
// 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 54;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PaymentDetailsController * paymentVC = [[PaymentDetailsController alloc] init];
    paymentVC.title = @"收支详情";
     
    [self.navigationController pushViewController:paymentVC animated:YES];
}
//每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 65;
}
- (DetailCountTopView *)centerView {
    
    if (!_centerView) {
        _centerView = [[DetailCountTopView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        _centerView.talkBlock = ^(UIButton *btn){
            weakSelf.lastBtn = btn;
            [weakSelf getReauestAssetDetail];
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            weakSelf.lastBtn = btn;
            [weakSelf postGetAccountDetail:1];
            
            return YES;
        };
        _centerView.serviceBlock = ^(UIButton *btn){
            weakSelf.lastBtn = btn;
            [weakSelf postGetAccountDetail:2];
            return YES;
        };
        _centerView.sellerBlock = ^(UIButton *btn){
            weakSelf.lastBtn = btn;
            [weakSelf postGetAccountDetail:3];
            return YES;
        };
    }
    return _centerView;
}
- (void)postGetAccountDetail:(NSInteger)type {
    
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"page":@(1),
                           @"pageSize":@(10),
                           @"type":@(type)
                           };
    [self getRequestWithPath:API_GetUserAssertDetai params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"code"] intValue] == 1) {
            self.dataArr = [UserAssetModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            self.allcomeArr = self.dataArr ;
        }
        if (successJson[@"data"][@"income"]==nil) {
            self.income=@"收支";
        }else {
            self.income = [NSString stringWithFormat:@"收支：%@", successJson[@"data"][@"income"]];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
