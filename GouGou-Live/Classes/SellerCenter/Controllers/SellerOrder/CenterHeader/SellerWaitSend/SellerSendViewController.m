//
//  SellerSendViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerSendViewController.h"
#import "SellerSendAlertView.h" 

@interface SellerSendViewController ()

@end

@implementation SellerSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self showSendAlert];
    
    
}
- (void)showSendAlert {
    SellerSendAlertView *sendView = [[SellerSendAlertView alloc] init];

    sendView.commitBlock = ^(NSString *shipStyle, NSString *shipOrder){
        // 送货请求，如果成功返回YES 失败返回NO

        return YES;
    };
//    [sendView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
