//
//  AccountHelpCenterVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AccountHelpCenterVc.h"
#import "NormalModel.h"

@interface AccountHelpCenterVc ()
@property (nonatomic, strong) UIButton *perfromBtn; /**< 未解决按钮 */
@property (nonatomic, strong) UIButton *serviceBtn; /**< 客服按钮 */

@property (nonatomic, strong) UITableView *tableView; /**< 表格 */

@property (nonatomic, strong) NormalModel *array; /**< 数据源 */
@property (nonatomic, strong) UILabel *label; /**< 文字 */
@end

@implementation AccountHelpCenterVc
- (void)getRequestHelp {
    NSDictionary *dict = @{@"id":@(5)};

    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [NormalModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        NormalModel *model = arr[0];
        self.label.text = model.conent;
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self.view addSubview:self.label];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(20, 20, 50, 20));
    }];
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
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"用户协议";
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
