//
//  PresentApplicationViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PresentApplicationViewController.h"
#import "PromptView.h"
#import "PresentWaitingViewController.h"

@interface PresentApplicationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
/** 蒙版 */
@property (strong,nonatomic) UIView *hud;
/** 提示框View */
@property (strong,nonatomic) PromptView *promptView;

/** 文本框 */
@property (strong,nonatomic) UITextField *textField;


@end

@implementation PresentApplicationViewController
#pragma mark
#pragma mark - 网络请求
- (void)codePayPsdRequest {
#pragma mark 验证支付密码
    
//    NSString * payPsdCode = self.textField.text;
    // 判断payPsdCode = 正确密码
    
    // 如果密码正确 跳转
    PresentWaitingViewController * presentWatiVC = [[PresentWaitingViewController alloc] init];
    
    [self.navigationController pushViewController:presentWatiVC animated:YES];
    

}


- (IBAction)cilckPresentApplicationBtn:(UIButton *)sender {
    
    NSString * moneyNumString = self.moneyTextfiled.text;
    NSInteger moneyNum = [moneyNumString integerValue];
    if (moneyNum == 0) {
        DLog(@"输入金钱不能为0");
    } else if (moneyNum > 7262) {
        
        DLog(@"最高输入金钱数为7262");
    } else {
    
        // 封装蒙版的View
        PromptView * prompt = [[PromptView alloc] initWithFrame:self.view.bounds];
        prompt.backgroundColor = [UIColor whiteColor];
        prompt.layer.cornerRadius = 5;
        prompt.layer.masksToBounds = YES;
        
        __weak typeof(self) weakself = self;
        // 提示框textfiled设置代理
        prompt.playpsdBlock = ^(UITextField *textfiled) {

            weakself.textField = textfiled;
            
            textfiled.delegate = self;
            
        };
        // 点击提示框确认按钮请求支付密码
        prompt.clickSureBtnBlock = ^(){
            
            [weakself codePayPsdRequest];
            
        };
        // 显示蒙版
        [prompt show];
    }
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"提现申请";
    
    self.sureBtn.layer.cornerRadius = 7.5;
    self.sureBtn.layer.masksToBounds = YES;
    
    self.moneyTextfiled.delegate = self;
    self.moneyTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.moneyTextfiled addTarget:self action:@selector(inputSomthing:) forControlEvents:UIControlEventEditingDidEnd];
    
}

- (void)inputSomthing:(UITextField *)textFiled {
 
    UIButton *button = [textFiled valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    
    if (textField == self.moneyTextfiled) {
        // 判断是否是数字
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 4 && flag) {
            return YES;
        }else{
            return NO;
        }
        
    
    }else if(textField == self.textField){
        
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 11 && flag) {
            
            return YES;
        
        } else if (range.location > 20) {
            
            return YES;
        }
        return YES;
    }
    
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
