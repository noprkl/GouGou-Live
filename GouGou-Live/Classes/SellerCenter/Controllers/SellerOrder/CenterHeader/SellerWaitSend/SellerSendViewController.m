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
  __block  SellerSendAlertView *sendView = [[SellerSendAlertView alloc] init];
    __weak typeof(self) weakSelf = self;
    sendView.orderID = _orderID;
    
    sendView.commitBlock = ^(NSString *shipStyle, NSString *shipOrder){
        // 送货请求，如果成功返回YES 失败返回NO
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID intValue]),
                               @"status":@(8),
                               @"id":@([_orderID intValue])
                               };
        [self getRequestWithPath:API_Up_status params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                sendView = nil;
                [sendView dismiss];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    };
    sendView.dismissBlock = ^(){
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [sendView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
