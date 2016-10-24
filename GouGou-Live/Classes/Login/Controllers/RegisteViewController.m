//
//  RegisteViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "RegisteViewController.h"
#import "LoginViewController.h"

@interface RegisteViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation RegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)initUI {
//    self.view.backgroundColor = [UIColor whiteColor];
    
    // 左边item
    UIButton *leftItem = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftItem sizeToFit];
    [leftItem setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    [leftItem addTarget:self action:@selector(leftBackBtnAction) forControlEvents:(UIControlEventTouchDown)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    // 右边item
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName:[UIColor grayColor]
                                               };
    
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    self.title = @"账号登录";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightLoginBtnAction)];
    
}

#pragma mark
#pragma mark - Action
- (void)leftBackBtnAction {

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightLoginBtnAction {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginVC animated:YES];
    
}

- (IBAction)clickGetCodeAction:(UIButton *)sender {
}
- (IBAction)clickSureBtnAction:(UIButton *)sender {
}
- (IBAction)clickReadBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    // 已阅读 可以确定
    self.sureBtn.enabled = sender.selected;
    
}
- (IBAction)clickProtocolAction:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
