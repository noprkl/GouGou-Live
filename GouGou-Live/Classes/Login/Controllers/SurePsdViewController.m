//
//  SurePsdViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SurePsdViewController.h"
#import "LoginViewController.h"

@interface SurePsdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *psdTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePsdTextField;

@end

@implementation SurePsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}
- (void)initUI {
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

    self.title = @"密码确认";


}

#pragma mark
#pragma mark - Action
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickEyeBtnAction:(UIButton *)sender {
    
    self.surePsdTextField.secureTextEntry = !self.surePsdTextField.secureTextEntry;
    
    sender.selected = !sender.selected;
}
- (IBAction)clickSureBtnAction:(UIButton *)sender {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
