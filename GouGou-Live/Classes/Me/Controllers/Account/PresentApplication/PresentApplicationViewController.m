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
#import "NSString+MD5Code.h"
#import "SetPayingPsdViewController.h"
#import "ForgetPayPsdViewController.h"
#import "ResetPsdViewController.h"

@interface PresentApplicationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextfiled;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property(nonatomic, assign) BOOL isHaveDian; /**< 小数点 */

@property(nonatomic, assign) BOOL isFirstZero; /**< 首位为0 */

@end

@implementation PresentApplicationViewController
#pragma mark
#pragma mark - 网络请求

- (IBAction)cilckPresentApplicationBtn:(UIButton *)sender {
    
    NSString * moneyNumString = self.moneyTextfiled.text;
    if (moneyNumString.length == 0) {
        [self showAlert:@"提现金额不能为空"];
    }else if ([UserInfos sharedUser].userpaycode.length == 0){
        ResetPsdViewController *resetVC = [[ResetPsdViewController alloc] init];
        resetVC.hidesBottomBarWhenPushed = YES;
        resetVC.title = @"支付密码重置";
        
    } else {
    
        // 封装蒙版的View
        PromptView * prompt = [[PromptView alloc] initWithFrame:self.view.bounds];
        
//        __weak typeof(self) weakself = self;
        // 点击提示框确认按钮请求支付密码
        __weak typeof(prompt) weakPrompt = prompt;
        prompt.clickSureBtnBlock = ^(NSString *text){

            // 验证密码
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"pay_password":[NSString md5WithString:text]
                                   };
            [self postRequestWithPath:API_Validation_pwd params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                weakPrompt.noteStr = successJson[@"message"];
                if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                    // 提现请求
                    NSDictionary *dict = @{
                                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                           @"amount":@([moneyNumString integerValue])
                                           };
                    [self getRequestWithPath:API_RetriveMoney params:dict success:^(id successJson) {
                        DLog(@"%@", successJson);
                        // 如果请求正确 跳转
                        PresentWaitingViewController * presentWatiVC = [[PresentWaitingViewController alloc] init];
                        presentWatiVC.noteStr = successJson[@"message"];
                        [self.navigationController pushViewController:presentWatiVC animated:YES];
                        [weakPrompt dismiss];
                    } error:^(NSError *error) {
                        DLog(@"%@", error);
                    }];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];

        };
        prompt.forgetBlock = ^(){
            //忘记支付密码
            ForgetPayPsdViewController *forgetVC = [[ForgetPayPsdViewController alloc] init];
            forgetVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:forgetVC animated:YES];
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求用户资产
     self.moneyTextfiled.placeholder = [NSString stringWithFormat:@"请输入要提现的金额(最高￥%@)", [UserInfos sharedUser].userAsset];

}
- (void)initUI {

    self.title = @"提现申请";
    
    self.sureBtn.layer.cornerRadius = 9;
    self.sureBtn.layer.masksToBounds = YES;
    
    [self.moneyTextfiled addTarget:self action:@selector(editPresentMoneyAction:) forControlEvents:(UIControlEventEditingChanged)];
    self.moneyTextfiled.delegate = self;
    self.moneyTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [self.moneyTextfiled addTarget:self action:@selector(inputSomthing:) forControlEvents:UIControlEventEditingDidEnd];
    
}
- (void)editPresentMoneyAction:(UITextField *)textFiled {
    // 最高是当前账号的钱数
    if (textFiled.text > [UserInfos sharedUser].userAsset) {
        textFiled.text = [UserInfos sharedUser].userAsset;
    }
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
        
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian = NO;
        }
        if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
            _isFirstZero = NO;
        }
        
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                
                if([textField.text length]==0){
                    if(single == '.'){
                        //首字母不能为小数点
                        return NO;
                    }
                    if (single == '0') {
                        _isFirstZero = YES;
                        return YES;
                    }
                }
                
                if (single=='.'){
                    if(!_isHaveDian)//text中还没有小数点
                    {
                        _isHaveDian=YES;
                        return YES;
                    }else{
                        return NO;
                    }
                }else if(single=='0'){
                    if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if([textField.text isEqualToString:@"0.0"]){
                            return NO;
                        }
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if (_isFirstZero&&!_isHaveDian){
                        //首位有0没.不能再输入0
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if (_isHaveDian){
                        //存在小数点，保留两位小数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt= (int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){
                        //首位有0没点
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }else{
                //输入的数据格式不正确
                return NO;
            }
        }else{
            return YES;
        }
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
