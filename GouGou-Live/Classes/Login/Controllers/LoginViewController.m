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


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTestField;
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor orangeColor];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // navBar隐藏
    self.navigationController.navigationBarHidden = YES;
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
}
- (IBAction)clickRegisteBtnAction:(UIButton *)sender {
    
    RegisteViewController *registeVC = [[RegisteViewController alloc] init];
    [self.navigationController pushViewController:registeVC animated:YES];
}
- (IBAction)clickCodeBtnAction:(UIButton *)sender {
    
}
- (IBAction)clickForgrtPsdBtnAction:(UIButton *)sender {
    
    ForgetPsdViewController *forgetVC = [[ForgetPsdViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - 第三方登录
- (IBAction)clickQQLogin:(UIButton *)sender {
}
- (IBAction)clickWXLogin:(UIButton *)sender {
}
- (IBAction)clickSinaLogin:(UIButton *)sender {
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
