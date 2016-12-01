//
//  PayingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PayingViewController.h"
#import "AddPayingSuccessViewController.h"


@interface PayingViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTexfiled;
@property (weak, nonatomic) IBOutlet UITextField *payingTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;


@end

@implementation PayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
    self.userNameTexfiled.text = [UserInfos sharedUser].username;
    self.sureButton.layer.cornerRadius = 7.5;
    self.sureButton.layer.masksToBounds = YES;
    self.userNameTexfiled.delegate = self;
    self.payingTextfiled.delegate  = self;
    
}
#pragma mark
#pragma mark - 网络请求
- (void)requestPhoneNum {
#pragma 验证手机号
    
    // 如果验证成功，跳转到添加成功
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"user_name":self.userNameTexfiled.text,
                           @"user_ali_code":self.payingTextfiled.text
                           };
    [self postRequestWithPath:API_Treasure params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
    AddPayingSuccessViewController * addPaySuccVC = [[AddPayingSuccessViewController alloc] init];
    
    [self.navigationController pushViewController:addPaySuccVC animated:YES];
    
}

- (IBAction)cilckSureButton:(UIButton *)sender {
    [self.payingTextfiled resignFirstResponder];
    NSString * payingAcount = self.payingTextfiled.text;
    
    BOOL flag =  [NSString valiMobile:payingAcount];
    
    if (payingAcount.length == 0) {
        
        [self showAlert:@"手机号不能为空"];
        
    }else if(!flag){
        
        [self showAlert:@"手机号输入有误"];
        
    }else if(![[UserInfos sharedUser].usertel isEqualToString:payingAcount]){
        
        [self showAlert:@"您输入的手机号与账号不一致"];
        
    }else{
        // 自出说明输入的是手机号，需要进行网络请求验证
        [self requestPhoneNum];
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
    if (textField == self.userNameTexfiled) {
        
        return NO;
        
    }else if (textField == self.payingTextfiled){
        
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 11 && flag) {
            return YES;
        }
        return NO;
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.userNameTexfiled) {
        [textField resignFirstResponder];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField == self.userNameTexfiled) {
        return NO;
    }
    return YES;
    
}
@end
