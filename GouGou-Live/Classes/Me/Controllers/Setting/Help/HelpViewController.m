//
//  HelpViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@property (nonatomic, strong) UIButton *perfromBtn; /**< 未解决按钮 */
@property (nonatomic, strong) UIButton *serviceBtn; /**< 客服按钮 */

@property (nonatomic, strong) UITableView *tableView; /**< 表格 */

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self.view addSubview:self.perfromBtn];
    [self.view addSubview:self.serviceBtn];
    [self.perfromBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH / 2);
        make.height.equalTo(50);
    }];
    [self.serviceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH / 2);
        make.height.equalTo(50);
    }];
    
}
- (UIButton *)perfromBtn {
    if (!_perfromBtn) {
        _perfromBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_perfromBtn setTitle:@"还没解决问题？" forState:(UIControlStateNormal)];
        _perfromBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _perfromBtn.backgroundColor = [UIColor colorWithHexString:@"#ff1aa1"];
        _perfromBtn.titleLabel.tintColor = [UIColor colorWithHexString:@"#ffffff"];
        [_perfromBtn addTarget:self action:@selector(ClickPerformBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _perfromBtn;
}
- (void)ClickPerformBtnAction {

}
- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_serviceBtn setTitle:@"还没解决问题？" forState:(UIControlStateNormal)];
        _serviceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _serviceBtn.backgroundColor = [UIColor colorWithHexString:@"#ff1aa1"];
        _serviceBtn.titleLabel.tintColor = [UIColor colorWithHexString:@"#ffffff"];
        [_serviceBtn addTarget:self action:@selector(ClickServiceBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _serviceBtn;
}
- (void)ClickServiceBtnAction {
    
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
