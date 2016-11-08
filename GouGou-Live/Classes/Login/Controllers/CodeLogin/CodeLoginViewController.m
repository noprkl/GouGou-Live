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
    
//    [[AFHTTPSessionManager manager] GET:@"http://gougou.itnuc.com/api/UserService/sms" parameters:@{@"tel":@18401703756, @"type":@2} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        DLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"%@", error);
//    }];

    
    NSDictionary *dict = @{
                           @"tel" : @([self.phoneNumber.text intValue]),
                           @"type" : @2
                           };
    [self getRequestWithPath:API_Code params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (IBAction)chickSureBtnAction:(UIButton *)sender {
    
    NSDictionary *dict = @{
                           @"user_tel":@([self.phoneNumber.text intValue]),
                           @"code":self.psdNumber.text
                           };
    
    [self getRequestWithPath:API_LoginQuick params:dict success:^(id successJson) {
        [self showAlert:successJson[@"message"]];
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];

}

- (IBAction)clickReadBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 已阅读 可以确定
    self.sureBtn.enabled = sender.selected;
}
- (IBAction)clickProtocolBtnAction:(UIButton *)sender {
    
    
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
        if (range.location < 6 && flag) {
            self.sureBtn.enabled = NO;
            return YES;
        }
        self.sureBtn.enabled = YES;
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
