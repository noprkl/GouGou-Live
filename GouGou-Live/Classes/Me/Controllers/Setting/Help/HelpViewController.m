//
//  HelpViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HelpViewController.h"
#import "NormalModel.h"
#import "SingleChatViewController.h"

@interface HelpViewController ()
@property (nonatomic, strong) UIButton *perfromBtn; /**< 未解决按钮 */
@property (nonatomic, strong) UIButton *serviceBtn; /**< 客服按钮 */
@property (nonatomic, strong) UITableView *tableView; /**< 表格 */
/** 文字 */
@property (strong,nonatomic) UILabel *label;

@end

@implementation HelpViewController
- (void)getRequestHelp {
    NSDictionary *dict = @{@"id":@(6)};
    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [NormalModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        NormalModel *model = arr[0];
        self.label.text = model.conent;
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self getRequestHelp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self.view addSubview:self.perfromBtn];
    [self.view addSubview:self.serviceBtn];
    [self.view addSubview:self.label];
    
    self.title = @"帮助";
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 20, 0, 44));
    }];
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
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}
- (UIButton *)perfromBtn {
    if (!_perfromBtn) {
        _perfromBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_perfromBtn setTitle:@"还没解决问题？" forState:(UIControlStateNormal)];
        _perfromBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _perfromBtn.backgroundColor = [UIColor colorWithHexString:@"#ffa11a"];
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
        [_serviceBtn setTitle:@"联系客服" forState:(UIControlStateNormal)];
        _serviceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _serviceBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        _serviceBtn.titleLabel.tintColor = [UIColor colorWithHexString:@"#ffffff"];
        [_serviceBtn addTarget:self action:@selector(ClickServiceBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _serviceBtn;
}
- (void)ClickServiceBtnAction {
    
    SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
    viewController.title = EaseTest_Chat1;
    viewController.chatID = EaseTest_Chat1;
    [self.navigationController pushViewController:viewController animated:YES];
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
