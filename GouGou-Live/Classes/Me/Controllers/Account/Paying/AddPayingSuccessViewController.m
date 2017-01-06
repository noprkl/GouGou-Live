//
//  AddPayingSuccessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddPayingSuccessViewController.h"
#import "PresentApplicationViewController.h"
#import "SingleChatViewController.h"
#import <MessageUI/MessageUI.h>

@interface AddPayingSuccessViewController ()<MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *relationServiceBtn;

@end

@implementation AddPayingSuccessViewController

- (IBAction)clickCancelBtn:(UIButton *)sender {
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

    [self clickButtonAction];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickRelationServiceBtn:(UIButton *)sender {
    
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
    [sender setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    
    [self clickButtonAction];
    // 短信发送
    [self clickServiceBtnAction];
}

- (void)clickButtonAction {
    if (self.cancelBtn.selected) {
        [self.cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        
        [self.relationServiceBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        
    }
    if (self.relationServiceBtn.selected) {
        
        [self.cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        
        [self.relationServiceBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    [self setNavBarItem];
    [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
    [self.relationServiceBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
    [self.relationServiceBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
    
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
    [self.cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancelBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
}

- (void)btnHighlightColor:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
}
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
