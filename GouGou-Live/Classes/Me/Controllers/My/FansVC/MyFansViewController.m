//
//  MyFansViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyFansViewController.h"
#import "MyFocusTableCell.h"
#import "FocusAndFansModel.h"
#import "PersonalPageController.h" // 个人主页
#import "FMDBUser.h"
@interface MyFansViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@end

static NSString *cellid = @"MyFocusCell";

@implementation MyFansViewController
// 请求粉丝数据
- (void)postRequestGetFans {
    //[[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID
                           };
    [self getRequestWithPath:API_Fans params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        
        if (successJson) {
            //            DLog(@"%@", successJson);
            self.dataArr = [FocusAndFansModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            [UserInfos sharedUser].fansCount = self.dataArr.count;
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];
    [self postRequestGetFans];
}

- (void)initUI {
    [self setNavBarItem];
    self.title = @"我的粉丝";
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"MyFocusTableCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.dataArr.count;
//    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFocusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FocusAndFansModel *model = self.dataArr[indexPath.row];
    cell.model = model;
//    FMDatabase *dataBase = [[FMDBUser tool] getDBWithDBName:Focus];
//    [[FMDBUser tool] DataBase:dataBase selectKeyTypes:@{} fromTable:Focus whereCondition:@{Focus:@(model.userFanId)}];
    //
    FMDatabase *dataBase = [FMDatabase databaseWithPath:[NSString cachePathWithfileName:Focus]];
    if ([dataBase open] ) {

        // 查询数据
        FMResultSet *reset = [dataBase executeQuery:[NSString stringWithFormat:@"select %@ from %@ where %@ = %ld", Focus, Focus, Focus, model.userFanId]];
        NSInteger focus = [reset intForColumn:[NSString stringWithFormat:@"%@", Focus]];
        if (focus) {
            cell.isSelect = YES;
        }else{
            cell.isSelect = NO;
        }
        [dataBase close];
        
    }else{
        DLog(@"打开失败");
    }

    
    
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
                                   @"user_id":@(11),
                                   @"id":[UserInfos sharedUser].ID,
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
