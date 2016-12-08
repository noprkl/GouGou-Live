//
//  WatchHistoryViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WatchHistoryViewController.h"
#import "WatchHistoryCell.h"
#import "LivingViewController.h"

static NSString * watchCell = @"watchCellID";
@interface WatchHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableview */
@property (strong,nonatomic) UITableView *tableview;

@end

@implementation WatchHistoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)initUI {

    [self.view addSubview:self.tableview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    self.title = @"观看历史";

}

- (UITableView *)tableview {

    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview registerClass:[WatchHistoryCell class] forCellReuseIdentifier:watchCell];
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 273;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WatchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:watchCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LivingViewController * livingVC = [[LivingViewController alloc] init];
    
    [self.navigationController pushViewController:livingVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
