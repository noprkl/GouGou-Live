//
//  PromptView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PromptView.h"
#import "UIView+Toast.h"


@interface PromptView ()<UITextFieldDelegate>
/** 蒙版 */
@property (strong,nonatomic) UIControl *hud;
/** 提示框title */
@property (strong,nonatomic) UILabel *titlelabel;
/** 提示框textfiled */
@property (strong,nonatomic) UITextField *editngtextfiled;
/** 密码提示文字 */
@property (strong,nonatomic) UILabel *psdLabel;
/** 忘记密码 */
@property (strong,nonatomic) UIButton *forgetPsd;
/** 确定按钮 */
@property (strong,nonatomic) UIButton *sureButton;
/** 取消按钮 */
@property (strong,nonatomic) UIButton *cancleButton;

@property(nonatomic, strong) UIView *backView; /**< 背景 */

@end

@implementation PromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.titlelabel];
        [self addSubview:self.backView];
        [self.backView addSubview:self.editngtextfiled];
        [self addSubview:self.psdLabel];
        [self addSubview:self.forgetPsd];
        [self addSubview:self.sureButton];
        [self addSubview:self.cancleButton];
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titlelabel.text = title;
}
- (void)setHidNote:(BOOL)hidNote {
    _hidNote = hidNote;
    self.psdLabel.hidden = hidNote;
}
- (void)setHidForGet:(BOOL)hidForGet {
    _hidForGet = hidForGet;
    self.forgetPsd.hidden = hidForGet;
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.editngtextfiled.placeholder = placeHolder;
}
- (void)setNoteStr:(NSString *)noteStr {
    _noteStr = noteStr;
    self.psdLabel.text = noteStr;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.centerX.equalTo(weakself.centerX);
    }];
    [self.backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titlelabel.bottom).equalTo(15);
        make.left.equalTo(weakself.left).offset(10);
        make.right.equalTo(weakself.right).offset(-10);
        make.height.equalTo(44);
    }];
    [_editngtextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.backView.top);
        make.left.equalTo(weakself.backView.left).offset(10);
        make.right.equalTo(weakself.backView.right);
        make.height.equalTo(44);
    }];
    
    [_psdLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.editngtextfiled.bottom).offset(10);
        make.left.equalTo(weakself.left).offset(10);
    }];
    
    [_forgetPsd mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.psdLabel.centerY);
        make.right.equalTo(weakself.right).offset(-10);
    }];
    
    
    [_cancleButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left);
        make.top.equalTo(weakself.psdLabel.bottom).offset(10);
        make.bottom.equalTo(weakself.bottom);
        make.height.equalTo(44);
    }];
    
    [_sureButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.cancleButton.right);
        make.right.bottom.equalTo(weakself);
        make.width.equalTo(weakself.cancleButton.width);
        make.height.equalTo(weakself.cancleButton.height);
    }];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}


- (UILabel *)titlelabel {
    
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"支付密码";
        _titlelabel.font = [UIFont systemFontOfSize:16];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}
- (UITextField *)editngtextfiled {
    
    if (!_editngtextfiled) {
        _editngtextfiled = [[UITextField alloc] init];
        _editngtextfiled.placeholder = @"请输入6-20位数字、字母密码";
        _editngtextfiled.font = [UIFont systemFontOfSize:14];
        _editngtextfiled.textColor = [UIColor colorWithHexString:@"#999999"];
        _editngtextfiled.delegate = self;

        //        _editngtextfiled.keyboardAppearance =
        [_editngtextfiled addTarget:self action:@selector(begingEditing:) forControlEvents:UIControlEventEditingDidEnd];
        _editngtextfiled.returnKeyType = UIReturnKeyDefault;
        
        _editngtextfiled  .keyboardType = UIKeyboardTypeDefault;
    }
    return _editngtextfiled;
}

- (UILabel *)psdLabel {
    
    if (!_psdLabel) {
        _psdLabel = [[UILabel alloc] init];
        _psdLabel.font = [UIFont systemFontOfSize:14];
        _psdLabel.textColor = [UIColor colorWithHexString:@"#ffbb6f"];
        _psdLabel.text = @"原密码不能为空";
    }
    return _psdLabel;
}

- (UIButton *)forgetPsd {
    
    if (!_forgetPsd) {
        _forgetPsd = [UIButton buttonWithType:UIButtonTypeSystem];
        [_forgetPsd setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetPsd.titleLabel.font = [UIFont systemFontOfSize:16];
        [_forgetPsd setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_forgetPsd addTarget:self action:@selector(clickForgrtBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _forgetPsd;
}

- (UIButton *)sureButton {
    
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sureButton setTitle:@"确认" forState:UIControlStateNormal];
        
        [_sureButton setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        
        [_sureButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_sureButton addTarget:self action:@selector(cilckSureButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

- (UIButton *)cancleButton {
    
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(clickCancleBtnFedOutHud) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancleButton;
}
- (void)showMessage:(NSString *)string {
    [self makeToast:string duration:1.5 position:nil];
}
- (void)cilckSureButton {

    NSString *editString = self.editngtextfiled.text;
    NSString *pullString;
    
    if (_clickSureBtnBlock) {
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
            
            [self fadeOut];
            _clickSureBtnBlock(self.editngtextfiled.text);
        }
    }
}


- (void)clickCancleBtnFedOutHud {
    [self fadeOut];
    
    if (_cancelBlock) {
        _cancelBlock();
    }
    
}

- (void)begingEditing:(UITextField *)textfiled {

    if (_playpsdBlock) {
        _playpsdBlock(textfiled);
    }
}
- (void)clickForgrtBtnAction {
    if (_forgetBlock) {
        [self dismiss];
        _forgetBlock();
    }
}
#pragma mark
#pragma mark - 蒙版
- (UIControl *)hud {
    
    if (!_hud) {
        _hud = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _hud.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
    }
    return _hud;
}
- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.hud];
    //载入alertView
    [keyWindow addSubview:self];
    
    
    //根据overlayer设置alertView的中心点
    CGRect rect = self.frame;
    rect = CGRectMake(10, SCREEN_HEIGHT - 264 - 180, SCREEN_WIDTH - 20, 170);
    self.frame = rect;
    
    [self.editngtextfiled becomeFirstResponder];
    
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
    
    self.hud.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.hud.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.hud.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.hud removeFromSuperview];
        [self.editngtextfiled resignFirstResponder];

    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField becomeFirstResponder];

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.editngtextfiled) {
        // 判断是否是数字
        
        if (range.location < 20) {
            return YES;
        }
        return NO;
        
    }else{
        
        return NO;
    }

}

@end
