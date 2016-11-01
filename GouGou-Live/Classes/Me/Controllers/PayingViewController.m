//
//  PayingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PayingViewController.h"

@interface PayingViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ueserNameTexfiled;
@property (weak, nonatomic) IBOutlet UITextField *playingTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation PayingViewController
- (IBAction)cilckSureButton:(UIButton *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sureButton.layer.cornerRadius = 7.5;
    self.sureButton.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}
@end
