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
#import "DogImageView.h"
@interface SellerAcceptedRateViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int page;
}
@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

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
                           @"page":@(page),
                           @"pageSize":@(5)
                           };
    [self showHudInView:self.view hint:@"加载中"];
    
    [self getRequestWithPath:API_My_order_comment params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        self.dataArr = [SellerAccepeRateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
//        [UserInfos sharedUser].commentCount = self.dataArr.count;
//        [self.tableView reloadData];
//        [self hideHud];
        if (page == 1) {
            [self.tableView.mj_footer resetNoMoreData];
            self.dataArr = [SellerAccepeRateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            [self hideHud];
            [self.tableView reloadData];
            
        }else{
            NSArray *array = [SellerAccepeRateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            [self.dataArr addObjectsFromArray:array];
            [self hideHud];
            [self.tableView reloadData];
            if (array.count < 5) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                page -= 1;
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
        [UserInfos sharedUser].commentCount = self.dataArr.count;

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
    page = 1;
    [self getRequestComment];
    [self getUserPleasure];
    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getRequestComment];
        [self getUserPleasure];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getRequestComment];
    }];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
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
    SellerAccepeRateModel *model = self.dataArr[indexPath.row];
    NSArray * arr = [model.photoPath componentsSeparatedByString:@","];
    DogImageView *dogImageView = [[DogImageView alloc] init];
    CGFloat height = [dogImageView getCellHeightWithImages:arr];

    return 190 + height;
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
