//
//  HelpViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AccountHelpCenterVc.h"
#import "NormalModel.h"
#import "SingleChatViewController.h"

@interface AccountHelpCenterVc ()
@property (nonatomic, strong) UIButton *perfromBtn; /**< 未解决按钮 */
@property (nonatomic, strong) UIButton *serviceBtn; /**< 客服按钮 */

@property (nonatomic, strong) UIWebView *webView; /**< webView */

@end

@implementation AccountHelpCenterVc
- (void)getRequestHelp {
    NSDictionary *dict = @{@"id":@(5)};
    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        NSString *url = successJson[@"data"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];
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
    [self.view addSubview:self.webView];
    self.title = @"账户帮助咨询";

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
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.view);
        make.bottom.equalTo(self.serviceBtn.top);
    }];
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}
- (UIButton *)perfromBtn {
    if (!_perfromBtn) {
        _perfromBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_perfromBtn setTitle:@"还没解决问题？" forState:(UIControlStateNormal)];
        _perfromBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _perfromBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [_perfromBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        
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
        [_serviceBtn addTarget:self action:@selector(clickServiceBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _serviceBtn;
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
