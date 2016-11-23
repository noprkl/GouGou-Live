//
//  MessageInputView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageInputView.h"

@interface MessageInputView ()<UITextFieldDelegate>

@property(nonatomic, strong) UIButton *cameraBtn; /**< 相机 */

@property(nonatomic, strong) UIButton *faceBtn; /**< 表情输入按钮 */

@property(nonatomic, strong) UIButton *sendMesBtn; /**< 信息发送按钮 */

@property(nonatomic, strong) UILabel *line; /**< 绿色的线 */

@property(nonatomic, strong) UITextField *messageTextField; /**< 信息输入 */

@end

@implementation MessageInputView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.cameraBtn];
        [self addSubview:self.messageTextField];
        [self addSubview:self.faceBtn];
        [self addSubview:self.sendMesBtn];
        [self addSubview:self.line];
    }
    return self;
}
- (void)layoutSubviews {
    
    [self.cameraBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.messageTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.height.equalTo(30);
        make.right.equalTo(self.right).offset(-90);
        make.left.equalTo(self.left).offset(35);
    }];
    
    [self.faceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.messageTextField.centerY);
        make.left.equalTo(self.messageTextField.right).offset(10);
    }];
    
    [self.sendMesBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.messageTextField.centerY);
        make.size.equalTo(CGSizeMake(44, 25));
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageTextField.bottom);
        make.left.equalTo(self.cameraBtn.left);
        make.right.equalTo(self.faceBtn.right);
        make.height.equalTo(1);
    }];
    
    //    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    
}
#pragma mark
#pragma mark - Action

- (void)clickSendMesBtnAction {
    if (_sendBlock) {
        _sendBlock(self.messageTextField.text);
        self.messageTextField.text = @"";
    }
}

- (void)clickFaceBtnAction {
    if (_emojiBlock) {
        _emojiBlock();
    }
}
- (void)clickCameraBtnAction {
    if (_cameraBlock) {
        _cameraBlock();
    }
}
#pragma mark
#pragma mark - 懒加载
- (UITextField *)messageTextField {
    
    if (!_messageTextField) {
        _messageTextField = [[UITextField alloc] init];
        
        _messageTextField.borderStyle = UITextBorderStyleNone;
        _messageTextField.delegate = self;
    }
    return _messageTextField;
}

- (UIButton *)faceBtn {
    
    if (!_faceBtn) {
        _faceBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_faceBtn setImage:[UIImage imageNamed:@"表情（输入菜单）"] forState:(UIControlStateNormal)];
        [_faceBtn addTarget:self action:@selector(clickFaceBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _faceBtn;
}
- (UIButton *)cameraBtn {
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cameraBtn setImage:[UIImage imageNamed:@"拍照gray"] forState:(UIControlStateNormal)];
        [_cameraBtn addTarget:self action:@selector(clickCameraBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _cameraBtn;
}
- (UIButton *)sendMesBtn {
    
    if (!_sendMesBtn) {
        
        _sendMesBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        _sendMesBtn.layer.cornerRadius = 5;
        _sendMesBtn.layer.masksToBounds = YES;
        
        [_sendMesBtn setTitle:@"发送" forState:(UIControlStateNormal)];
        [_sendMesBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_sendMesBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        
        [_sendMesBtn addTarget:self action:@selector(clickSendMesBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sendMesBtn;
}

- (UILabel *)line {
    
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    }
    return _line;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


@end
