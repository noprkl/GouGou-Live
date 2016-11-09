//
//  SecurityAccountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SecurityAccountViewController.h"
#import "SurePsdViewController.h"

@interface SecurityAccountViewController ()<UITableViewDataSource, UITableViewDelegate>

/** tableView */
@property (strong, nonatomic) UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation SecurityAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self setNavBarItem];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"重置登录密码", @"重置支付密码"];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500) style:(UITableViewStylePlain)];
        
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.text = @"detailTextLabel";
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SurePsdViewController *surePsdVC = [[SurePsdViewController alloc] init];
    surePsdVC.title = @"密码确认";
    
    [self.navigationController pushViewController:surePsdVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
