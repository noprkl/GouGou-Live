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
    self.areaChooseTextfiled.delegate = self;
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"新增收货地址";

    [self.areaChooseTextfiled addTarget:self action:@selector(areaChooseTextfiled:) forControlEvents:UIControlEventEditingDidBegin];
}
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;
}


- (void)clickSaveBtn {


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated {

        
}
@end
