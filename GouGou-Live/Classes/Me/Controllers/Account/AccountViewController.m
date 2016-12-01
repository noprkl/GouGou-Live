//
//  AccountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AccountViewController.h"
#import "DetailCountViewController.h"

#import "PresentApplicationViewController.h"

@interface AccountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */
/** 帮助与咨询按钮 */
@property (strong,nonatomic) UIButton *helpBtn;
/** 控制器Names */
@property (strong,nonatomic) NSArray *controllerNames;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickRightBtnAction)];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.helpBtn];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    self.edgesForExtendedLayout = 64;
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.dataArr.count * 44);
    }];
}
#pragma mark
#pragma mark - 懒加载
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
        _dataArr = [NSArray array];
        if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]) { // 实名认证
            
            if([UserInfos sharedUser].userpaycode.length == 0) { // 未设置支付密码 需要设置支付密码
                _dataArr = @[@"余额", @"结算", @"提现支付宝"];
            }else{ // 已经设置了支付密码 不能点击
                _dataArr = @[@"余额", @"结算", @"提现支付宝"];
            }

        }else { // 未实名
            _dataArr = @[@"余额",@"提示"];
        }
  
    }
    return _dataArr;
}

- (NSArray *)controllerNames {

    if (!_controllerNames) {
        _controllerNames = [NSArray array];
        if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]) { // 实名认证
            
            if([UserInfos sharedUser].userpaycode.length == 0) { // 未设置支付密码 需要设置支付密码
                _controllerNames = @[@"", @"PresentApplicationViewController",@"PayingViewController"];
            }else{ // 已经设置了支付密码 不能点击

                _controllerNames = @[@"", @"PresentApplicationViewController",@""];
            }
            
        }else { // 未实名
            _controllerNames = @[@"",@"CertificateViewController"];
        }
       
    }
    return _controllerNames;
}

- (UIButton *)helpBtn {

    if (!_helpBtn) {
        _helpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _helpBtn.frame = CGRectMake(0, 546, SCREEN_WIDTH, 64);
        [_helpBtn setTitle:@"帮助与咨询" forState:UIControlStateNormal];
        [_helpBtn setTintColor:[UIColor whiteColor]];
        [_helpBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        _helpBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_helpBtn addTarget:self action:@selector(clickHelpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _helpBtn;
}

#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]) { // 实名认证
        
        if([UserInfos sharedUser].userpaycode.length == 0) { // 未设置支付密码 需要设置支付密码
            cell.textLabel.text = self.dataArr[indexPath.row];
            
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = @"余额";
            }
            if (indexPath.row == 1) {
                cell.detailTextLabel.text = @"";
            }
            if (indexPath.row == 2){
                cell.detailTextLabel.text = [UserInfos sharedUser].usertel;
            }
        }else{ // 已经设置了支付密码 不能点击
            cell.textLabel.text = self.dataArr[indexPath.row];
            
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = @"余额";
            }
            if (indexPath.row == 1) {
                cell.detailTextLabel.text = @"";
            }
            if (indexPath.row == 2){
                cell.detailTextLabel.text = [UserInfos sharedUser].usertel;
            }
        }
        
    }else { // 未实名
        if (indexPath.row == 0) {
            cell.textLabel.text = self.dataArr[indexPath.row];
            
            cell.detailTextLabel.text = @"余额";
        }
        if (indexPath.row == 1){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            label.text = @"余额提现功能只针对实名认证用户开发,立即认证";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
            [cell.contentView addSubview:label];
        }

    }
    
    if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]) { // 未实名认证
        
        
    }else {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.dataArr[indexPath.row];
            
            cell.detailTextLabel.text = @"余额";
        }
        if (indexPath.row == 1){
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            label.text = @"余额提现功能只针对实名认证用户开发,立即认证";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
            [cell.contentView addSubview:label];
        }
    }
        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = self.dataArr[indexPath.row ];
    NSString *controllerName = self.controllerNames[indexPath.row];
    
    UIViewController *VC = [[NSClassFromString(controllerName) alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.title = cellText;
    
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark
#pragma mark - Action
- (void)clickRightBtnAction {
    DetailCountViewController *detailVC = [[DetailCountViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)clickHelpBtnAction {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
