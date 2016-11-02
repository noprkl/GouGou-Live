//
//  PresentApplicationViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PresentApplicationViewController.h"

@interface PresentApplicationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextfiled;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation PresentApplicationViewController
- (IBAction)cilckSureBtn:(UIButton *)sender {
    
    NSString * moneyNumString = self.moneyTextfiled.text;
    NSInteger moneyNum = [moneyNumString integerValue];
    if (moneyNum == 0) {
        DLog(@"输入金钱不能为0");
    } else if (moneyNum > 7262) {
        
        DLog(@"最高输入金钱数为7262");
    }
}

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self initUI];
    
   
    [self setNavBarItem];
}

- (void)initUI {

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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.moneyTextfiled) {
        // 判断是否是数字
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 4 && flag) {
            return YES;
        }
        return NO;
    
    }else{
        
        return NO;
    }


}
- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
    
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
