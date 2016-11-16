//
//  EditNewAddressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditNewAddressViewController.h"
#import "AddressChooseView.h"

static NSString * detailCellid = @"detailCellid";
@interface EditNewAddressViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *areaChooseTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *postalcodeTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextfiled;


@end

@implementation EditNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    self.userNameTextfiled.delegate = self;
    self.areaChooseTextfiled.delegate = self;
    self.postalcodeTextfiled.delegate = self;
    self.detailAddressTextfiled.delegate = self;

    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"新增收货地址";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSaveBtnAction)];
    
    [self.areaChooseTextfiled addTarget:self action:@selector(areaChooseTextfiled:) forControlEvents:UIControlEventEditingDidBegin];
}
- (void)clickSaveBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - textfiled内容编辑
- (void)userNameTextfiled:(UITextField *)sender {
    
    
}

- (void)areaChooseTextfiled:(UITextField *)sender {
    
    AddressChooseView * choose = [[AddressChooseView alloc] init];
    
    [choose show];
}

- (void)postalcodeTextfiled:(UITextField *)sender {
    
    
    
}

- (void)detailAddressTextFiled:(UITextField *)sender {
    
    
}
#pragma mark - 点击保存按钮
- (void)clickSaveBtn {
    
    
}

#pragma mark
#pragma mark - TextFiled代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.userNameTextfiled) {
        
        
    } else if (textField == self.areaChooseTextfiled) {
    
    
    } else if (textField == self.postalcodeTextfiled) {
    
        BOOL flag = [NSString validateNumber:textField.text];
        
        if (range.location < 6 && flag) {
            
            return YES;
        }
        return NO;
    
    } else if (textField == self.detailAddressTextfiled) {
    
    
    }

    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
