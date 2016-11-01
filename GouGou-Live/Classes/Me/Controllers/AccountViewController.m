//
//  AccountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AccountViewController.h"
#import "DetailCountViewController.h"

@interface AccountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */
@end

@implementation AccountViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"余额", @"申请体现", @"体现支付宝"];
    }
    return _dataArr;
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
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.detailTextLabel.text = @"111";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    self.edgesForExtendedLayout = 64;
   
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.dataArr.count * 44);
    }];
}

- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickRightBtnAction)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];

}
- (void)clickRightBtnAction {
    DetailCountViewController *detailVC = [[DetailCountViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
