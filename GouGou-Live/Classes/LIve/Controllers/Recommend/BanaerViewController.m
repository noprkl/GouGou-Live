//
//  BanaerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BanaerViewController.h"

@interface BanaerViewController ()

@property (nonatomic, strong) UIWebView *webView; /**< webView */

@end

@implementation BanaerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self.view addSubview:self.webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_banaerURL]];
    [self.webView loadRequest:request];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
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
