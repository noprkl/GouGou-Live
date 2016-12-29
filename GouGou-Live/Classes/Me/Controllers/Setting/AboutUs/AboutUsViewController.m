//
//  AboutUsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AboutUsViewController.h"
#import "HTTPTool.h"
#import "UserProtocolVc.h"

@interface AboutUsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray *dataArr;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation AboutUsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}

- (void)initUI {
    
    self.phoneLabel.text = @"服务热线 010-82929292";

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"版本号 %@", currentVersion];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"用户使用协议", @"检查更新"];
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
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = self.dataArr[indexPath.row];
    
    if ([cellText isEqualToString:@"用户使用协议"]) {
        
        UserProtocolVc * userVC = [[UserProtocolVc alloc] init];
        
        [self.navigationController pushViewController:userVC animated:YES];
        
        DLog(@"%@", cellText);
    }else if ([cellText isEqualToString:@"检查更新"]) {

        NSDictionary *dict = @{
                               @"id":@""
                               };
        [HTTPTool getRequestWithPath:@"http://itunes.apple.com/cn/lookup" params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
