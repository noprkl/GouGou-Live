//
//  AddPicturesViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddPicturesViewController.h"

@interface AddPicturesViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *nameTextField; /**< 相册名字 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@property(nonatomic, strong) UILabel *countLabel; /**< 字数 */

@property(nonatomic, strong) UIButton *saveBtn; /**< 保存 */

@end

@implementation AddPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    [self setNavBarItem];
    self.title = @"新建相册";
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.line];
    [self.view addSubview:self.countLabel];
    [self.view addSubview:self.saveBtn];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(43);
        make.left.equalTo(self.view.left).offset(10);
        make.size.equalTo(CGSizeMake(355, 1));
    }];
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.line.right);
        make.bottom.equalTo(self.line.top);
    }];
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line.left);
        make.bottom.equalTo(self.line.top);
        make.right.equalTo(self.countLabel.left);
        make.height.equalTo(25);
    }];
    
    [self.saveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.line.bottom).offset(40);
        make.size.equalTo(CGSizeMake(310, 44));
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入相册名称" attributes:@{
                                                                                                                  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _nameTextField.delegate = self;
        _nameTextField.textColor = [UIColor colorWithHexString:@"#999999"];
        _nameTextField.font = [UIFont systemFontOfSize:14];
        
        [_nameTextField addTarget:self action:@selector(nameTextFieldEdit:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _nameTextField;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"12";
        _countLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _countLabel.font = [UIFont systemFontOfSize:12];
    }
    return _countLabel;
}
- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _saveBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_saveBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        _saveBtn.layer.cornerRadius = 8;
        _saveBtn.layer.masksToBounds = YES;
        
        [_saveBtn addTarget:self action:@selector(clickSaveBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _saveBtn;
}
#pragma mark
#pragma mark - Action
- (void)nameTextFieldEdit:(UITextField *)textField {
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (12 - textField.text.length)];
}
- (void)clickSaveBtnAction {
    if (self.nameTextField.text.length == 0) {
        [self showAlert:@"名字不能空"];
    }else{
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                               @"name":self.nameTextField.text
                               };
        [self postRequestWithPath:API_Albums params:dict success:^(id successJson) {
//            DLog(@"%@", successJson);
//            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"添加成功"]) {
                // 自动调回
                    [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
    
}
#pragma mark
#pragma mark - 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location < 12) {
        return YES;
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
