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


@interface RegisteViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;

@end

@implementation RegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self setNavBarItem];
}
- (void)setNavBarItem {
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
        
    self.title = @"账号注册";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightLoginBtnAction)];

    
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)initUI {
    
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldChanged:) forControlEvents:(UIControlEventEditingDidEnd)];
    
}

#pragma mark
#pragma mark - Action
- (void)rightLoginBtnAction {
    
    [self leftBackBtnAction];
}

- (IBAction)clickGetCodeAction:(UIButton *)sender {
    
    [self freetimeout];
    
#warning 需要请求验证码
    DLog(@"验证码已发送");

}
- (IBAction)clickSureBtnAction:(UIButton *)sender {
    
    NSString *phoneNumber = self.phoneTextField.text;
    NSString *codeNumber = self.codeTextField.text;
    
    BOOL flag =  [NSString valiMobile:phoneNumber];
    
    if (phoneNumber.length == 0) {
        
        DLog(@"手机号不能为空");
        
    }else if(!flag){
        
        DLog(@"所输入的不是手机号");
        
    }else{
        if (codeNumber.length != 6) {
            
            
            DLog(@"验证码只能是6位");
            
        }else{
            
            
#warning 需要验证验证码
            
            SurePsdViewController *sureVC = [[SurePsdViewController alloc] init];
            
            sureVC.title = @"密码确认";
            [self.navigationController pushViewController:sureVC animated:YES];
            DLog(@"登录成功");

        }
    }
    
}
- (IBAction)clickReadBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 已阅读 可以确定
    self.sureBtn.enabled = sender.selected;
    
}
- (IBAction)clickProtocolAction:(UIButton *)sender {

    #warning - 协议链接
    
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
        
        DLog(@"输入不符合");
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
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 6 && flag) {
            
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
