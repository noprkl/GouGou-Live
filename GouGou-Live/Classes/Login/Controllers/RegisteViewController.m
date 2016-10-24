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
@property (weak, nonatomic) IBOutlet UINavigationBar *registeNavBar;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation RegisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}
- (void)initUI {
//    self.view.backgroundColor = [UIColor whiteColor];
    self.registeNavBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:[UIColor grayColor]
                                               };
    
    
    
}

#pragma mark
#pragma mark - Action
- (IBAction)clickLeftActionBtn:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRightBtnAction:(UIBarButtonItem *)sender {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
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
