//
//  SellerAcceptedRateViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  卖家中心-收到的评价

#import "SellerAcceptedRateViewController.h"
#import "SellerAcceptRateCell.h"
#import "SellerAcceptRateHeaderView.h"
#import "SellerAccepeRateModel.h"

@interface SellerAcceptedRateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) SellerAcceptRateHeaderView *headerView; /**< 头部View */

@property (nonatomic, assign) NSInteger pleasureCount; /**< 满意度 */

@end

static NSString *cellid = @"SellerAcceptRateCell";

@implementation SellerAcceptedRateViewController

// 评价
- (void)getRequestComment {
    NSDictionary *dict = @{ // [[UserInfos sharedUser].ID integerValue]
                           @"user_id":[UserInfos sharedUser].ID,
                           @"page":@(1),
                           @"pageSize":@(5)
                           };
    [self getRequestWithPath:API_My_order_comment params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"message"] isEqualToString:@"请求成功"]) {
              self.dataArr = [SellerAccepeRateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            [UserInfos sharedUser].commentCount = self.dataArr.count;
            [self.tableView reloadData];

        }
            } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 满意度
- (void)getUserPleasure {
    NSDictionary *dict = @{ // [[UserInfos sharedUser].ID integerValue]
                           @"user_id":@([[UserInfos sharedUser].ID integerValue])
                           };
    [self getRequestWithPath:API_home params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"code"] isEqualToString:@"1"]) {
            // 分数四舍五入
            CGFloat source = [successJson[@"data"] floatValue];
            NSInteger count = source * 10;
            if (count % 10 > 5) {
                self.pleasureCount = count / 10 + 1;
            }else{
                self.pleasureCount = count / 10;
            }
            DLog(@"%ld", (long)self.pleasureCount);
        }else {
            self.pleasureCount = 5;
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestComment];
    [self getUserPleasure];
    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getRequestComment];
        [self getUserPleasure];
        [self.tableView.mj_header endRefreshing];
    }];
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
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;

        [_tableView registerClass:[SellerAcceptRateCell class] forCellReuseIdentifier:cellid];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerAcceptRateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SellerAccepeRateModel *model = self.dataArr[indexPath.row];
    cell.images = [model.photoPath componentsSeparatedByString:@","];
    cell.model = model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 330;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", (long)indexPath.row);
}
#pragma mark - 头部
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
       SellerAcceptRateHeaderView *headerView = [[SellerAcceptRateHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.pleasureCount = self.pleasureCount;
        self.headerView = headerView;
        return headerView;
    }
    return nil;
}

@end
