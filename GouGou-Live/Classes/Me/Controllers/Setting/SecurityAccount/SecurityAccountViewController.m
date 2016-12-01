//
//  SecurityAccountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SecurityAccountViewController.h"
#import "ResetPsdViewController.h"
#import "ResetPsdAlertView.h"
#import "SetPayingPsdViewController.h"
#import "NSString+MD5Code.h"

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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
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

   if (indexPath.row == 0) {
       __block ResetPsdAlertView *resetLoginAlert = [[ResetPsdAlertView alloc] init];
        [resetLoginAlert show];
        resetLoginAlert.title = @"登录密码重置";
        resetLoginAlert.placeHolder = @"请输入原登录密码";
        resetLoginAlert.noteString = @"原密码不能为空";
        __weak typeof(resetLoginAlert) weakReset = resetLoginAlert;
        resetLoginAlert.sureBlock = ^(NSString *text){
            
            // 验证密码
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"user_pwd":[NSString md5WithString:text]
                                   };
            [self postRequestWithPath:API_Validation_l_pwd params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                weakReset.noteString = successJson[@"message"];
                if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                    
                    [weakReset dismiss];
                    [self pushResetPsdVC:@"登录密码重置" oldPsd:text];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
    }else if (indexPath.row == 1){
        if ([UserInfos sharedUser].userpaycode.length == 0) { // 未设置支付密码
            SetPayingPsdViewController *payPsdVC = [[SetPayingPsdViewController alloc] init];
            [self.navigationController pushViewController:payPsdVC animated:YES];
        }else{
       
            __block ResetPsdAlertView *resetPayAlert = [[ResetPsdAlertView alloc] init];
            [resetPayAlert show];
            resetPayAlert.title = @"支付密码重置";
            resetPayAlert.placeHolder = @"请输入原支付密码";
            resetPayAlert.noteString = @"原密码不能为空";
            
            __weak typeof(resetPayAlert) weakReset = resetPayAlert;
            resetPayAlert.sureBlock = ^(NSString *text){
                // 验证密码
                NSDictionary *dict = @{
                                       @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                       @"pay_password":[NSString md5WithString:text]
                                       };
                [self postRequestWithPath:API_Validation_pwd params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    weakReset.noteString = successJson[@"message"];
                    if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                        [weakReset dismiss];
                        [self pushResetPsdVC:@"支付密码重置" oldPsd:text];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            };
        }
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)pushResetPsdVC:(NSString *)title oldPsd:(NSString *)oldPsd {
        ResetPsdViewController *surePsdVC = [[ResetPsdViewController alloc] init];
        surePsdVC.title = title;
        surePsdVC.oldPsd = oldPsd;
        [self.navigationController pushViewController:surePsdVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
