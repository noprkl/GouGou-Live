//
//  SellerBaseViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerBaseViewController.h"
#import <MessageUI/MessageUI.h>
@interface SellerBaseViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation SellerBaseViewController
/** 在线客服 */
- (void)clickServiceBtnAction {
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://18401703756"]];
    
    if ([MFMessageComposeViewController canSendText]) {// 判断是否支持发送短信
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:SMSPhone];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        //修改短信界面标题
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"短信发送"];
    }else{
        [self showAlert:@"不支持发送短信"];
    }
}
#pragma mark
#pragma mark - 短信发送协议
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:NO completion:^{
        
    }];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self showAlert:@"取消发送"];
            break;
        case MessageComposeResultFailed:// send failed
            [self showAlert:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self showAlert:@"发送成功"];
            break;
        default:
            break;
    }
}
@end
