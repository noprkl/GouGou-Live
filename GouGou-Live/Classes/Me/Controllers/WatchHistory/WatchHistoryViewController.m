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

    LivingViewController * livingVC = [[LivingViewController alloc] init];
    
    [self.navigationController pushViewController:livingVC animated:YES];
    
}

- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
    
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
