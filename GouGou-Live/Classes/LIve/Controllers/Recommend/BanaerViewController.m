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
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        _webView
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
