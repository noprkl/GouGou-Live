//
//  ResetPsdAlertView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ResetPsdAlertView.h"
#import "UIView+Toast.h"

@interface ResetPsdAlertView ()<UITextFieldDelegate>
/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

/** title */
@property (strong, nonatomic) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *noteLabel; /**< 提示文字 */

@property(nonatomic, strong) UITextField *editTextField; /**< 编辑处 */
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;

@end
@implementation ResetPsdAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.overLayer];
        [self addSubview:self.titleLabel];
        [self addSubview:self.editTextField];
        [self addSubview:self.noteLabel];
        [self addSubview:self.sureBtn];
        [self addSubview:self.cancelBtn];
    }
    return self;
}
- (void)setUP {
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-5);
        make.top.equalTo(self.top).offset(10);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(10);
    }];
    
    [self.editTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(5);
        make.top.equalTo(self.titleLabel.bottom).offset(10);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(44);
    }];
    
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editTextField.left);
        make.top.equalTo(self.editTextField.bottom).offset(5);
    }];
    
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(5);
        make.right.equalTo(self.right).offset(-5);
        make.bottom.equalTo(self.bottom).offset(-5);
        make.height.equalTo(44);
    }];
    
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.editTextField.placeholder = placeHolder;
}
- (void)setNoteString:(NSString *)noteString {
    _noteString = noteString;
    self.noteLabel.text = noteString;
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请输入用户昵称";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UITextField *)editTextField {
    if (!_editTextField) {
        _editTextField  = [[UITextField alloc] init];
        _editTextField.delegate = self;
        _editTextField.placeholder = @"请输入原登录密码";
        _editTextField.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _editTextField.textColor = [UIColor colorWithHexString:@"#666666"];
        _editTextField.secureTextEntry = YES;
        _editTextField.font = [UIFont systemFontOfSize:14];
        _editTextField.layer.cornerRadius = 5;
        _editTextField.layer.masksToBounds = YES;
        _editTextField.returnKeyType = UIReturnKeyDefault;
        
        _editTextField.keyboardType = UIKeyboardTypeDefault;
    }
    return _editTextField;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"原密码不能为空";
        _noteLabel.font = [UIFont systemFontOfSize:13];
        _noteLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }
    return _noteLabel;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_cancelBtn setImage:[UIImage imageNamed:@"-单删除"] forState:(UIControlStateNormal)];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchDown)];
    }
    return _cancelBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.layer.masksToBounds = YES;
        
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#99CC33"];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        [_sureBtn addTarget:self action:@selector(clickSureBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureBtn;
}
- (void)showMessage:(NSString *)string {
    [self makeToast:string duration:1.5 position:nil];
}
- (void)clickSureBtnAction {
    
    NSString *editString = self.editTextField.text;
    NSString *pullString;
    
    if (_sureBlock) {
        if ([editString isEqualToString:@""]) {
            pullString = @"密码不能为空";
            [self showMessage:pullString];

        }else if (editString.length < 6){
            pullString = @"密码不能少于6位";
            [self showMessage:pullString];

        }else if (pullString.length > 20){
            pullString = @"密码最多20位";
            [self showMessage:pullString];

        }else{

            _sureBlock(self.editTextField.text);
        }
    }
}

#pragma mark
#pragma mark - 监听代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField becomeFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.editTextField) {
        // 判断是否是数字
        BOOL flagNumber = [NSString validateNumber:string];
        BOOL charNumber = [NSString validateCharacter:string];
        
        if (range.location < 20 ) {
            if (flagNumber) {
                return YES;
            }else if (charNumber)
            {
                return YES;
            }
            return NO;
        }
        return NO;
        
    }else{
        
        return NO;
    }
    
}

#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer
{
// 懒加载 蒙版
if (!_overLayer) {
_overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];

_overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

return _overLayer;
}

- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    //    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat h = keyBoardFrame.size.height;
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 165 - 258, SCREEN_WIDTH, 165);
    self.frame = rect;
    
    [self.editTextField becomeFirstResponder];
    
    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss
{
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
        [self.editTextField resignFirstResponder];
        
    }];
}


@end
