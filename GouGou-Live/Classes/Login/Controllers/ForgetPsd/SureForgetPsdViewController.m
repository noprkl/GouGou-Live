//
//  SureForgetPsdViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SureForgetPsdViewController.h"
#import "LoginViewController.h"
#import "SurePsdSuccessViewController.h"
#import "NSString+MD5Code.h"

@interface SureForgetPsdViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePsdTextField;

@end

@implementation SureForgetPsdViewController
- (void)surePsdRequest {
    NSString *psdNumber = self.psdTextField.text;
    if (psdNumber.length < 6) {
        
        [self showAlert:@"密码最少6位"];
        
    }else if (psdNumber.length > 20) {
        
        [self showAlert:@"密码最多20位"];
        
    }else{
        
        NSString *pwd = [NSString md5WithString:self.psdTextField.text];
        DLog(@"%@", pwd);
        NSDictionary *dict = @{
                               @"user_tel":self.telNumber,
                               @"code":self.codeNumber,
                               @"user_pwd":pwd
                               };
        
        [self getRequestWithPath:API_RetrivePwd params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    
    // 设置textField的placeHolder
    
    UIColor *textcolor1 = [UIColor colorWithHexString:@"666666"];
    UIColor *textcolor2 = [UIColor colorWithHexString:@"cccccc"];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"新密码  请输入6-20位数字或者密码"];
    
    [placeholder setAttributes:@{NSForegroundColorAttributeName :textcolor1,
                                 NSFontAttributeName : textFont
                                 
                                 } range:NSMakeRange(0, 5)];
    
    [placeholder setAttributes:@{NSForegroundColorAttributeName : textcolor2} range:NSMakeRange(5, 13)];
    
    self.psdTextField.attributedPlaceholder = placeholder;
    
    self.surePsdTextField.placeholder = @"确认密码";
    [self.surePsdTextField setValue:textcolor1 forKeyPath:@"_placeholderLabel.textColor"];
    [self.surePsdTextField setValue:textFont forKeyPath:@"_placeholderLabel.font"];
    
    self.psdTextField.delegate = self;
    self.surePsdTextField.delegate = self;
    
}

#pragma mark
#pragma mark - Action

- (IBAction)clickSureBtnAction:(UIButton *)sender {
    
    NSString *psdNumber = self.psdTextField.text;
    NSString *surePsd = self.surePsdTextField.text;
    
    if (![psdNumber isEqualToString:surePsd]) {
        
        [self showAlert:@"两次密码输入不一样"];
        
    }else{
        
        [self surePsdRequest];
    }
}

#pragma mark
#pragma mark - 文本监听

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.psdTextField) {
        
        if (range.location <= 20 ) {
            
            return YES;
        }
        return NO;
        
    }else if (textField == self.surePsdTextField){
        
        if (range.location <= 20) {
            return YES;
        }
        return NO;
    }else{
        
        return NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
