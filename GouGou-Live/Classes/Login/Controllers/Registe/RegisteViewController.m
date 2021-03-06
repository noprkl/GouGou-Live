//
//  RegisteViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "RegisteViewController.h"
#import "LoginViewController.h"
#import "SurePsdViewController.h"
#import "UserProtocolVc.h"

@interface RegisteViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;

@end

@implementation RegisteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
    DLog(@"%ld--%@--%@", _type, _name, _nickName);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
}
- (void)initUI {
    self.title = @"账号注册";
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightLoginBtnAction)];
    
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldChanged:) forControlEvents:(UIControlEventEditingDidEnd)];
    
}

#pragma mark
#pragma mark - Action
- (void)rightLoginBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickGetCodeAction:(UIButton *)sender {
    BOOL flag =  [NSString valiMobile:self.phoneTextField.text];
    if (!flag) {
        
        [self showAlert:@"请输入正确的手机号"];
    }else{
        
        NSDictionary *dict = @{
                               @"tel" :self.phoneTextField.text ,
                               @"type" : @0
                               };

        [self getRequestWithPath:API_Code params:dict success:^(id successJson) {
            DLog(@"%@", successJson);

            [self showAlert:successJson[@"message"]];
            if ([successJson[@"code"] isEqualToString:@"1"]) {
                [self freetimeout];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
- (IBAction)clickSureBtnAction:(UIButton *)sender {
    NSString *phoneNumber = self.phoneTextField.text;
    NSString *codeNumber = self.codeTextField.text;
    BOOL flag =  [NSString valiMobile:phoneNumber];
    if (!self.readBtn.selected) {
        [self showAlert:@"请勾选用户协议"];
    }else if (phoneNumber.length == 0) {
        [self showAlert:@"手机号不能为空"];
    }else if(!flag){
        [self showAlert:@"所输入的不是手机号"];
    }else{
        if (codeNumber.length == 6 || codeNumber.length == 5) {
            NSDictionary * dict = @{
                                    @"user_tel":self.phoneTextField.text ,
                                    @"code":self.codeTextField.text,
                                    @"type":@0
                                    };
            
            [self getRequestWithPath:API_Register_sms params:dict success:^(id successJson) {
                
                DLog(@"%@",successJson);
                
                if ([successJson[@"code"] isEqual:@"0"]) {
                    [self showAlert:@"短信不存在"];
                }
                if ([successJson[@"code"] isEqual:@"1"]) {
                    
                    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                    NSString *phoneNumStr = [UserInfos sharedUser].usertel;
                    [defaults setObject:phoneNumStr forKey:@"phoneNum"];
                    
                    SurePsdViewController *sureVC = [[SurePsdViewController alloc] init];
                    sureVC.title = @"密码确认";
                    sureVC.telNumber = self.phoneTextField.text;
                    sureVC.codeNumber = self.codeTextField.text;
                    sureVC.type = _type;
                    sureVC.name = _name;
                    sureVC.nickName = _nickName;
                    [self.navigationController pushViewController:sureVC animated:YES];
                }
                if ([successJson[@"code"] isEqual:@"2"]) {
                    return ;
                }
                
                
            } error:^(NSError *error) {
                DLog(@"%@",error);
            }];
        }else{
            [self showAlert:@"验证码输入错误"];
        }
    }
}
- (IBAction)clickReadBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 已阅读 可以确定
//    self.sureBtn.enabled = sender.selected;
}
- (IBAction)clickProtocolAction:(UIButton *)sender {

    UserProtocolVc *protocolVc = [[UserProtocolVc alloc] init];
    protocolVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:protocolVc animated:YES];
    
}
#pragma mark - 文本框监听
- (IBAction)phoneTextFieldEditing:(UITextField *)sender {
    
    UIButton *button = [sender valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
    
    sender.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}
- (IBAction)psdTextFieldEditing:(UITextField *)sender {
    
    UIButton *button = [sender valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
    
    sender.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)phoneTextFieldChanged:(UITextField *)textField {
    // 判断正则
    BOOL flag =  [NSString valiMobile:textField.text];
    if (!flag) {
        
        [self showAlert:@"请输入正确的手机号"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    if (textField == self.phoneTextField) {
        // 判断是否是数字
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 11 && flag) {
            return YES;
        }
        return NO;
        
    }else if (textField == self.codeTextField){
        // 不用限制判断验证码
//        BOOL flag = [NSString validateNumber:string];
//        if (range.location <= 5 && flag) {
            return YES;
//        }
//        return NO;
    }else{
        
        return NO;
    }

}
#pragma mark
#pragma mark - 倒计时
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
                
                self.sendCodeBtn.userInteractionEnabled = YES;
                self.sendCodeBtn.tintColor = [UIColor colorWithHexString:@"99cc33"];
                
                [self.sendCodeBtn setTitle:@"重获验证码" forState:(UIControlStateNormal)];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendCodeBtn.userInteractionEnabled = NO;
                
                self.sendCodeBtn.tintColor = [UIColor colorWithHexString:@"#99cc33"];
               
                NSString *string = [NSString stringWithFormat:@"%ldS",time];
                
                [self.sendCodeBtn setTitle:string forState:(UIControlStateNormal)];
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
