//
//  LoginViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisteViewController.h"
#import "ForgetPsdViewController.h"

#import "CodeLoginViewController.h"

#import "NSString+MD5Code.h"

// 第三方登录
#import "LoginViewController+ThirdLogin.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTestField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor orangeColor];
    
    [self initUI];
}

- (void)initUI {
    
    UIColor *textcolor = [UIColor colorWithHexString:@"fefefe"];
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    // 设置textField的placeHolder
    self.phoneTestField.placeholder = @"账号  请输入手机号";
    [self.phoneTestField setValue:textcolor forKeyPath:@"_placeholderLabel.textColor"];
    [self.phoneTestField setValue:textFont forKeyPath:@"_placeholderLabel.font"];
    
    self.psdTextField.placeholder = @"密码  请输入6-20位数字或字母";
    [self.psdTextField setValue:textcolor forKeyPath:@"_placeholderLabel.textColor"];
    [self.psdTextField setValue:textFont forKeyPath:@"_placeholderLabel.font"];
    
    self.phoneTestField.delegate = self;
    self.psdTextField.delegate = self;
    
    [self.phoneTestField addTarget:self action:@selector(phoneTextFieldChanged:) forControlEvents:(UIControlEventEditingDidEnd)];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // navBar隐藏
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - Action
- (IBAction)clickEyeBtnAction:(UIButton *)sender {

    self.psdTextField.secureTextEntry = !self.psdTextField.secureTextEntry;
    
    sender.selected = !sender.selected;
}

- (IBAction)clickLoginBtnAction:(UIButton *)sender {
    [self.phoneTestField resignFirstResponder];
    [self.psdTextField resignFirstResponder];
    NSString *phoneNumber = self.phoneTestField.text;
    NSString *psdNumber = self.psdTextField.text;
    
    BOOL flag =  [NSString valiMobile:phoneNumber];
    
    if (phoneNumber.length == 0) {
        
        [self showAlert:@"手机号不能为空"];
        
    }else if(!flag){

        [self showAlert:@"所输入的不是手机号"];

    }else{
        if (psdNumber.length < 6) {
        
            [self showAlert:@"密码最少6位"];

        }else if (psdNumber.length > 20) {
            
            [self showAlert:@"密码最多20位"];
        }else{
            NSString *pwd = [NSString md5WithString:self.psdTextField.text];

            NSDictionary *dict = @{
                                   @"user_tel":@([self.phoneTestField.text integerValue]),
                                   @"user_pwd":pwd
                                   };
            // 请求之前删掉上一次的信息

            [self getRequestWithPath:API_Login params:dict success:^(id successJson) {
               
                [self showAlert:successJson[@"message"]];
                
                if ([successJson[@"message"] isEqualToString:@"成功"]) {
                    DLog(@"%@", successJson);
                    
                    [self saveUserWithID:successJson[@"data"][@"id"]
                                user_pwd:successJson[@"data"][@"user_pwd"]
                            user_img_url:successJson[@"data"][@"user_img_url"]
                               user_name:successJson[@"data"][@"user_name"]
                          user_nick_name:successJson[@"data"][@"user_nick_name"]
                                user_tel:successJson[@"data"][@"user_tel"]
                             is_merchant:successJson[@"data"][@"is_merchant"]
                                 is_real:successJson[@"data"][@"is_real"]
                                 user_motto:successJson[@"data"][@"user_motto"]
                           user_pay_code:successJson[@"data"][@"user_pay_code"]
                           user_ali_code:successJson[@"data"][@"user_ali_code"]
                              qq_open_id:successJson[@"data"][@"qq_open_id"]
                              wx_open_id:successJson[@"data"][@"wx_open_id"]
                             user_status:successJson[@"data"][@"user_status"]
                     ];
                   
                    EMError *error2 = [[EMClient sharedClient] loginWithUsername:successJson[@"data"][@"id"] password:successJson[@"data"][@"user_pwd"]];
                    if (!error2) {
                        DLog(@"登录成功");
                    }
                    // 通知给所有人 已经登录
                    NSNotification* notification = [NSNotification notificationWithName:@"LoginSuccess" object:successJson[@"data"]];

                    [[NSNotificationCenter defaultCenter] postNotification:notification];

                    [self.navigationController popViewControllerAnimated:YES];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
    }
}
- (void)saveUserWithID:(NSString *)ID
              user_pwd:(NSString *)user_pwd
          user_img_url:(NSString *)user_img_url
             user_name:(NSString *)user_name
        user_nick_name:(NSString *)user_nick_name
              user_tel:(NSString *)user_tel
           is_merchant:(NSString *)is_merchant
               is_real:(NSString *)is_real
            user_motto:(NSString *)user_motto
         user_pay_code:(NSString *)user_pay_code
         user_ali_code:(NSString *)user_ali_code
            qq_open_id:(NSString *)qq_open_id
            wx_open_id:(NSString *)wx_open_id
            user_status:(NSString *)user_status

{
    [UserInfos sharedUser].userimgurl = ![user_img_url isEqual:[NSNull null]] ?user_img_url:@"";
    [UserInfos sharedUser].username = ![user_name isEqual:[NSNull null]] ?user_name:@"";
    [UserInfos sharedUser].usernickname = ![user_nick_name isEqual:[NSNull null]] ?user_nick_name:@"";
    [UserInfos sharedUser].usermotto = ![user_motto isEqual:[NSNull null]] ? user_motto:@"";
    [UserInfos sharedUser].useralicode = ![user_ali_code isEqual:[NSNull null]] ? user_ali_code:@"";
    [UserInfos sharedUser].userpaycode = ![user_pay_code isEqual:[NSNull null]] ? user_pay_code:@"";

    [UserInfos sharedUser].isreal = is_real;
    [UserInfos sharedUser].ismerchant = is_merchant;
    [UserInfos sharedUser].ID = ID;
    [UserInfos sharedUser].userPsd = user_pwd;
    [UserInfos sharedUser].usertel = user_tel;
    
    [UserInfos setUser];
}

- (IBAction)clickRegisteBtnAction:(UIButton *)sender {
    
    RegisteViewController *registeVC = [[RegisteViewController alloc] init];
    [self.navigationController pushViewController:registeVC animated:YES];
}
- (IBAction)clickCodeBtnAction:(UIButton *)sender {
    
    CodeLoginViewController *codeVC = [[CodeLoginViewController alloc] init];
    
    [self.navigationController pushViewController:codeVC animated:YES];

}
- (IBAction)clickForgrtPsdBtnAction:(UIButton *)sender {
    
    ForgetPsdViewController *forgetVC = [[ForgetPsdViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - 第三方登录
- (IBAction)clickQQLogin:(UIButton *)sender {
    [LoginViewController QQLogin];
}
- (IBAction)clickWXLogin:(UIButton *)sender {
    [LoginViewController WChatLogin];
}
- (IBAction)clickSinaLogin:(UIButton *)sender {
    [LoginViewController SinaLogin];
}


#pragma mark - 文本框监听

- (void)phoneTextFieldChanged:(UITextField *)textField {
    
    // 判断正则
    BOOL flag =  [NSString valiMobile:textField.text];
    if (!flag) {
        [self showAlert:@"请输入手机号"];
//        DLog(@"输入不符合");
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phoneTestField) {
        // 判断是否是数字
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 11 && flag) {
            return YES;
        }
        return NO;
        
    }else if (textField == self.psdTextField){
        
        if (range.location < 20) {
            return YES;
        }
        return NO;
    }else{
        
        return NO;
    }
}



@end
