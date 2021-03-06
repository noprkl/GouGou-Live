//
//  MyFocusViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyFocusViewController.h"
#import "MyFocusTableCell.h"
#import "SearchFocusViewController.h"
#import "FocusAndFansModel.h"
#import "PersonalPageController.h" // 个人主页
#import "NoneDateView.h"

@interface MyFocusViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property (nonatomic, strong) NoneDateView *noneDateView; /**< 没有数据 */

@end

static NSString *cellid = @"MyFocusCell";

@implementation MyFocusViewController
- (void)postRequestGetFocus {
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{@"user_id":[UserInfos sharedUser].ID
                           };
    [self getRequestWithPath:API_Fan_Information params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneDateView.hidden = NO;
            self.tableView.hidden = YES;
        }else if ([successJson[@"code"] isEqualToString:@"1"]) {
            self.noneDateView.hidden = YES;
            self.tableView.hidden = NO;
            // 得到关注人的人
            self.dataArr = [FocusAndFansModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            
            NSString *filePath = [NSString cachePathWithfileName:Focus];
            NSMutableArray *arr = [NSMutableArray array];
            for (FocusAndFansModel *model in self.dataArr) {
                [arr addObject:@(model.userFanId)];
            }
            [arr writeToFile:filePath atomically:YES];
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
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];
    [self postRequestGetFocus];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postRequestGetFocus];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)initUI {
    
    [self setNavBarItem];
    self.title = @"关注的人";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickAddBtnAction)];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noneDateView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
}
- (void)clickAddBtnAction {
    SearchFocusViewController *seachFocusVC = [[SearchFocusViewController alloc] init];
    [self.navigationController pushViewController:seachFocusVC animated:YES];
}

#pragma mark
#pragma mark - TableView
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"MyFocusTableCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NoneDateView *)noneDateView {
    if (!_noneDateView) {
        _noneDateView = [[NoneDateView alloc] initWithFrame:self.view.bounds];
        _noneDateView.noteStr = @"没有关注的人";
        _noneDateView.hidden = YES;
        _noneDateView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _noneDateView;
}
#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFocusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FocusAndFansModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    cell.selectBlock = ^(BOOL isSelect){
        if (isSelect) {
            
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"id":@(model.userFanId),
                                   @"type":@(0)
                                   };
            [self getRequestWithPath:API_Add_fan params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
        }else {
            
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"id":@(model.userFanId),
                                   @"type":@(1)
                                   };
            [self getRequestWithPath:API_Add_fan params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FocusAndFansModel *model = self.dataArr[indexPath.row];
    
    PersonalPageController *personalVc = [[PersonalPageController alloc] init];
    personalVc.personalID = model.userFanId;
    [self.navigationController pushViewController:personalVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
