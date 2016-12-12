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

@interface MyFocusViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@end

static NSString *cellid = @"MyFocusCell";

@implementation MyFocusViewController
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
    
}

- (void)initUI {
    
    [self setNavBarItem];
    self.title = @"关注的人";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStyleDone) target:self action:@selector(clickAddBtnAction)];
    [self.view addSubview:self.tableView];
}
- (void)clickAddBtnAction {
    SearchFocusViewController *seachFocusVC = [[SearchFocusViewController alloc] init];
    [self.navigationController pushViewController:seachFocusVC animated:YES];
}

- (void)setFocusArr:(NSArray *)focusArr {
    _focusArr = focusArr;
    [self.dataArr addObjectsFromArray:focusArr];
}
#pragma mark
#pragma mark - TableView
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"MyFocusTableCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
//    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFocusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FocusAndFansModel *model = self.focusArr[indexPath.row];
    cell.model = model;
    
    cell.selectBlock = ^(BOOL isSelect){
        if (isSelect) {
            
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID intValue]),
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
                                   @"user_id":@([[UserInfos sharedUser].ID intValue]),
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
