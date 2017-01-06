//
//  SurePsdViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SurePsdViewController.h"
#import "LoginViewController.h"
#import "SurePsdSuccessViewController.h"
#import "NSString+MD5Code.h"

@interface SurePsdViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePsdTextField;

@end

@implementation SurePsdViewController
- (void)surePsdRequest {
    
    NSString *pwd = [NSString md5WithString:self.psdTextField.text];
    DLog(@"%@", pwd);
    NSDictionary *dict = [NSDictionary dictionary];
    
    if (_type && _name.length != 0 && _nickName.length != 0) {// 第三方注册
        dict = @{
                 @"user_tel":self.telNumber,
                 @"user_pwd":pwd,
                 @"code":self.codeNumber,
                 @"type":@(_type),
                 @"name":_name,
                 @"nickname":_nickName
                 };
    }else{// 正常注册
        dict = @{
                 @"user_tel":self.telNumber,
                 @"user_pwd":pwd,
                 @"code":self.codeNumber
                 };
    }
    
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Register params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        if ([successJson[@"message"] isEqualToString:@"注册成功"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SurePsdSuccessViewController *sureSuccVC = [[SurePsdSuccessViewController alloc] init];
                
                [self.navigationController pushViewController:sureSuccVC animated:YES];
            });
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
 
    // 设置textField的placeHolder

    UIColor *textcolor1 = [UIColor colorWithHexString:@"666666"];
    UIColor *textcolor2 = [UIColor colorWithHexString:@"cccccc"];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"密码  请输入6-20位数字或者密码"];
    
    [placeholder setAttributes:@{NSForegroundColorAttributeName :textcolor1,
                                 NSFontAttributeName : textFont
                                 
                                 } range:NSMakeRange(0, 4)];
    
    [placeholder setAttributes:@{NSForegroundColorAttributeName : textcolor2} range:NSMakeRange(4, 13)];
    
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
        
    if (psdNumber.length < 6 || surePsd.length < 6 || psdNumber.length > 20 || surePsd.length > 20) {
        
        [self showAlert:@"限制密码6-20位"];
    }else if (![psdNumber isEqualToString:surePsd]) {

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
    // Dispose of any resources that can be recreated.
}



@end
