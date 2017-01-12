//
//  UserProtocolVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UserProtocolVc.h"
#import "NormalModel.h"

@interface UserProtocolVc ()

@property (nonatomic, strong) UIWebView *webView; /**< webView */

@end

@implementation UserProtocolVc

- (void)getRequestProtocol {
    NSDictionary *dict = @{@"id":@(1)};
    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSString *url = successJson[@"data"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];

    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestProtocol];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    [self setNavBarItem];
    [self.view addSubview:self.webView];
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

@end
