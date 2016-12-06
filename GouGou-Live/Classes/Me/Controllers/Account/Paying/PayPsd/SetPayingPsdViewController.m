//
//  SetPayingPsdViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SetPayingPsdViewController.h"
#import "SetPaypsdViewController.h"

@interface SetPayingPsdViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendCode;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SetPayingPsdViewController

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
    self.title = @"设置支付密码";
    
    self.phoneTextField.delegate = self;
    self.codeTextField.delegate = self;
}

#pragma mark
#pragma mark - Action


- (IBAction)clickGetCodeBtnAction:(UIButton *)sender {
    
    [self freetimeout];
    if (self.phoneTextField.text.length == 0){
        [self showAlert:@"手机号为空"];
    }else{
        NSDictionary *dict = @{
                               @"tel" :self.phoneTextField.text,
                               @"type" : @3
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
        if (self.codeTextField.text.length == 0) {
            [self showAlert:@"验证码不能为空"];
        }else{
            
            SetPaypsdViewController *payPsdVC = [[SetPaypsdViewController alloc] init];
            payPsdVC.codeNumber = self.codeTextField.text;
            payPsdVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:payPsdVC animated:YES];
        }
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
