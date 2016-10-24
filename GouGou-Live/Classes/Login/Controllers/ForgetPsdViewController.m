//
//  ForgetPsdViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ForgetPsdViewController.h"
#import "SurePsdViewController.h"


@interface ForgetPsdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;


@end

@implementation ForgetPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
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
    
    self.title = @"手机号验证";
    
    
}

#pragma mark
#pragma mark - Action
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickGetCodeBtnAction:(UIButton *)sender {
}

- (IBAction)codeTextFieldExiding:(UITextField *)sender {
    UIButton *button = [sender valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:@"-单删除"] forState:UIControlStateNormal];
    
    sender.clearButtonMode = UITextFieldViewModeWhileEditing;

}
- (IBAction)clickSureBtnAction:(UIButton *)sender {
    
    SurePsdViewController *surePsdVC = [[SurePsdViewController alloc] init];
    
    [self.navigationController pushViewController:surePsdVC animated:YES];
    
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
