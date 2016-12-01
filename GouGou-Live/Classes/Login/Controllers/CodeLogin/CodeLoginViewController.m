//
//  CodeLoginViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CodeLoginViewController.h"
#import "LoginViewController.h"

@interface CodeLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *psdNumber;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendCode;


@end

@implementation CodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}
- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
    self.title = @"验证码登录";
    
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)initUI {
    
    self.phoneNumber.delegate = self;
    self.psdNumber.delegate = self;
}

#pragma mark
#pragma mark - Action

- (IBAction)phoneTextfieldEditing:(UITextField *)sender {
    UIButton *button = [sender valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
    
    sender.clearButtonMode = UITextFieldViewModeWhileEditing;
}
- (IBAction)codeTextFieldEditing:(UITextField *)sender {
    UIButton *button = [sender valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
    
    sender.clearButtonMode = UITextFieldViewModeWhileEditing;
}


- (IBAction)clickGetCodeBtnAction:(UIButton *)sender {
    
#pragma mark 请求验证码
    [self freetimeout];
    
    NSDictionary *dict = @{
                           @"tel" : @([self.phoneNumber.text integerValue]),
                           @"type" : @2
                           };
    
    [self getRequestWithPath:API_Code params:dict success:^(id successJson) {
        DLog(@"%@", successJson[@"message"]);
        [self showAlert:successJson[@"message"]];
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (IBAction)chickSureBtnAction:(UIButton *)sender {
    NSString *phoneNumber = self.phoneNumber.text;
    
    BOOL flag =  [NSString valiMobile:phoneNumber];
    
    if (phoneNumber.length == 0) {
        
        [self showAlert:@"手机号不能为空"];
        
    }else if(!flag){
        
        [self showAlert:@"所输入的不是手机号"];
        
    }else{
        
            NSDictionary *dict = @{
                                   @"user_tel":@([phoneNumber integerValue]),
                                   @"code":self.psdNumber.text
                                   };
        // 请求之前删掉上一次的信息
        
        [self getRequestWithPath:API_LoginQuick params:dict success:^(id successJson) {
            
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"成功"]) {
                
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
                

                
                // 通知给所有人 已经登录
//                NSNotification* notification = [NSNotification notificationWithName:@"CodeLoginSuccess" object:successJson[@"data"]];
//                
//                [[NSNotificationCenter defaultCenter] postNotification:notification];
                
                // 环信登录
                EMError *error2 = [[EMClient sharedClient] loginWithUsername:successJson[@"data"][@"id"] password:successJson[@"data"][@"user_pwd"]];
                if (!error2) {
                    DLog(@"登录成功");
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }

}

- (IBAction)clickReadBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 已阅读 可以确定
    self.sureBtn.enabled = sender.selected;
}
- (IBAction)clickProtocolBtnAction:(UIButton *)sender {
    
    
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

#pragma mark
#pragma mark - 文本框监听
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phoneNumber) {
        // 判断是否是数字
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 11 && flag) {
           
            return YES;
        }
        return NO;
        
    }else if (textField == self.psdNumber){
        
        BOOL flag = [NSString validateNumber:string];
        if (range.location <= 5 && flag) {
           
            return YES;
        }

        return NO;
    }else{
        
        return NO;
    }
}
- (void)freetimeout {
    __block NSInteger time = LASTTIME;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time <= 1) {
            //取消计时
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.sendCode.userInteractionEnabled = YES;
                self.sendCode.tintColor = [UIColor colorWithHexString:@"99cc33"];
                
                [self.sendCode setTitle:@"重获验证码" forState:(UIControlStateNormal)];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendCode.userInteractionEnabled = NO;
                
                self.sendCode.tintColor = [UIColor colorWithHexString:@"#99cc33"];
                NSString *string = [NSString stringWithFormat:@"%ldS",time];
                
                [self.sendCode setTitle:string forState:(UIControlStateNormal)];
            });
            time --;
        }
        
    });
    dispatch_resume(timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
