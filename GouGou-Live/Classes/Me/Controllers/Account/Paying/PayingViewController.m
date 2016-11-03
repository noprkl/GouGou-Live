//
//  PayingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PayingViewController.h"

@interface PayingViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTexfiled;
@property (weak, nonatomic) IBOutlet UITextField *playingTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;


@end

@implementation PayingViewController
- (IBAction)cilckSureButton:(UIButton *)sender {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
    self.sureButton.layer.cornerRadius = 7.5;
    self.sureButton.layer.masksToBounds = YES;
    self.userNameTexfiled.delegate = self;
    self.playingTextfiled.delegate  = self;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
    if (textField == self.userNameTexfiled) {
        
        
        
    }else if (textField == self.playingTextfiled){
        
        BOOL flag = [NSString valiMobile:string];
        
        if (range.location < 11 && flag) {
        
            return YES;
        } else {
        
            return NO;
        }
        
        
    }
    return YES;
}

- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
