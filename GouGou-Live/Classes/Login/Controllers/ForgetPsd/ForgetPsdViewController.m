//
//  ForgetPsdViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ForgetPsdViewController.h"
#import "SureForgetPsdViewController.h"


@interface ForgetPsdViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendCode;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation ForgetPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
    
    [self setNavBarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = 64;
    self.navigationController.navigationBarHidden = NO;
}

- (void)initUI {
    self.title = @"忘记密码";

    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    
    self.sendCode.layer.cornerRadius = 5;
    self.sendCode.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = 5;
    self.sureBtn.layer.masksToBounds = YES;
}

#pragma mark
#pragma mark - Action
- (void)phoneNumberChangeAction:(UITextField *)textFiled {
    // 判断正则
    BOOL flag =  [NSString valiMobile:textFiled.text];
    if (!flag) {
        
        [self showAlert:@"请输入正确的手机号"];
    }
}
- (IBAction)clickGetCodeBtnAction:(UIButton *)sender {
    BOOL flag =  [NSString valiMobile:self.phoneTextField.text];
    if (!flag) {
        [self showAlert:@"请输入正确的手机号"];
    }else{

        [self freetimeout];
        NSDictionary *dict = @{
                               @"tel" : self.phoneTextField.text,
                               @"type" : @1
                               };
        [self getRequestWithPath:API_Code params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}

- (IBAction)codeTextFieldExiding:(UITextField *)sender {
    UIButton *button = [sender valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
    
    sender.clearButtonMode = UITextFieldViewModeWhileEditing;

}
- (IBAction)clickSureBtnAction:(UIButton *)sender {
    NSString *phoneNumber = self.phoneTextField.text;
    
    BOOL flag =  [NSString valiMobile:phoneNumber];
    
    if (phoneNumber.length == 0) {
        
        [self showAlert:@"手机号不能为空"];
        
    }else if(!flag){
        
        [self showAlert:@"所输入的不是手机号"];
        
    }else{
        NSDictionary * dict = @{
                                @"user_tel":self.phoneTextField.text,
                                @"code":self.codeTextField.text,
                                @"type":@1
                                };
        
        [self getRequestWithPath:API_Register_sms params:dict success:^(id successJson) {
            
            DLog(@"%@",successJson);
            
            if ([successJson[@"code"] isEqual:@"0"]) {
                [self showAlert:@"短信不存在"];
            }
            if ([successJson[@"code"] isEqual:@"1"]) {
                
                SureForgetPsdViewController *sureVC = [[SureForgetPsdViewController alloc] init];
                sureVC.title = @"新密码设置";
                sureVC.telNumber = self.phoneTextField.text;
                sureVC.codeNumber = self.codeTextField.text;
                [self.navigationController pushViewController:sureVC animated:YES];
            }
        } error:^(NSError *error) {
            DLog(@"%@",error);
        }];
      
    }

}

#pragma mark
#pragma mark - 文本框监听

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phoneTextField) {

        BOOL flag = [NSString validateNumber:string];

        if (range.location < 11 && flag) {
            
            return YES;
        }
        return NO;
        
    }else if (textField == self.codeTextField){
        
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
