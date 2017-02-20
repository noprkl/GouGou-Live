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
{
    int page;
}
@property(nonatomic, strong) DetailCountTopView *centerView; /**< headerView */

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 总数据源 */
//@property(nonatomic, strong) NSArray *allcomeArr; /**< 全部 */
@property(nonatomic, strong) NSString *allCount; /**< 总收入 */
@property(nonatomic, strong) UILabel *headerLabel; /**< 头部内容 */

@property (nonatomic, assign) NSInteger lastIndex; /**< 点击按钮 */

@property (nonatomic, strong) NSString *income; /**< 收支 */

@end

static NSString *cellid = @"cellid";

@implementation DetailCountViewController
- (void)getReauestAssetDetail {
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"page":@(page),
                           @"pageSize":@(10),
                           @"type":@(0)
                           };
    [self getRequestWithPath:API_GetUserAssertDetai params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        
        self.dataArr = [UserAssetModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        if (page > 1) {
            if (self.dataArr.count < 10) {
                [self showAlert:@"没有更多数据"];
            }
            page = page - 1;
        }
        if (successJson[@"data"][@"income"]==nil) {
            self.income = @"0.00";
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
    page = 1;
    self.lastIndex = 0;
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
        page = 1;
        if (self.lastIndex == 0) {
            [self getReauestAssetDetail];
        }else if (self.lastIndex == 1) {
            
            [self postGetAccountDetail:1];
        }else if (self.lastIndex == 2) {
            
            [self postGetAccountDetail:2];
        }else if (self.lastIndex == 3) {
            
            [self postGetAccountDetail:3];
        }
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page ++;
        if (self.lastIndex == 0) {
            [self getReauestAssetDetail];
        }else if (self.lastIndex == 1) {
            [self postGetAccountDetail:1];
        }else if (self.lastIndex == 2) {
            [self postGetAccountDetail:2];
        }else if (self.lastIndex == 3) {
            [self postGetAccountDetail:3];
        }
        [self.tableView.mj_footer endRefreshing];
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
    UserAssetModel *model = self.dataArr[indexPath.row];
    PaymentDetailsController * paymentVC = [[PaymentDetailsController alloc] init];
    paymentVC.title = @"收支详情";
    paymentVC.paymentId = model.ID;
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
            page = 1;
            weakSelf.lastIndex = 0;
            [weakSelf getReauestAssetDetail];
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            page = 1;
            weakSelf.lastIndex = 1;
            [weakSelf postGetAccountDetail:1];
            
            return YES;
        };
        _centerView.serviceBlock = ^(UIButton *btn){
            page = 1;
            weakSelf.lastIndex = 2;
            [weakSelf postGetAccountDetail:2];
            return YES;
        };
        _centerView.sellerBlock = ^(UIButton *btn){
            page = 1;
            weakSelf.lastIndex = 3;
            [weakSelf postGetAccountDetail:3];
            return YES;
        };
    }
    return _centerView;
}
- (void)postGetAccountDetail:(NSInteger)type {
    
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"page":@(page),
                           @"pageSize":@(10),
                           @"type":@(type)
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_GetUserAssertDetai params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
            self.dataArr = [UserAssetModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];

        if (page > 1) {
            if (self.dataArr.count < 10) {
                [self showAlert:@"没有更多数据"];
            }
            page = page - 1;
        }
        if (successJson[@"data"][@"income"]==nil) {
            self.income=@"暂无收入";
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
