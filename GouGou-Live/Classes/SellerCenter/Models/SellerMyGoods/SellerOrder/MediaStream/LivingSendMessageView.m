//
//  LivingSendMessageView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LivingSendMessageView.h"

@interface LivingSendMessageView ()<UITextFieldDelegate>

@property(nonatomic, strong) UIButton *faceBtn; /**< 表情输入按钮 */

@property(nonatomic, strong) UIButton *sendMesBtn; /**< 信息发送按钮 */
//@property(nonatomic, strong) UILabel *line; /**< 绿色的线 */

@property(nonatomic, strong) UITextField *messageTextField; /**< 信息输入 */

@end

@implementation LivingSendMessageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.messageTextField];
        [self addSubview:self.faceBtn];
        [self addSubview:self.sendMesBtn];
//        [self addSubview:self.line];
    }
    return self;
}
- (void)layoutSubviews {

    [self.faceBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(50);
        make.size.equalTo(CGSizeMake(26, 26));
    }];
    
    [self.sendMesBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(45, 25));
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.messageTextField remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.height.equalTo(25);
        make.right.equalTo(self.sendMesBtn.left).offset(-10);
        make.left.equalTo(self.faceBtn.right).offset(10);
    }];
    
}
#pragma mark
#pragma mark - Action

- (void)clickSendMesBtnAction {
    if (_sendBlock) {
        
        _sendBlock(self.messageTextField.text);
        self.messageTextField.text = @"";
        [self.messageTextField resignFirstResponder];
    }
}

- (void)clickFaceBtnAction {
    if (_emojiBlock) {
        _emojiBlock();
    }
}
- (void)textFieldEditAction:(UITextField *)textField {
    if (_textFieldBlock) {
        _textFieldBlock(textField);
    }
}
#pragma mark
#pragma mark - 懒加载

- (UITextField *)messageTextField {
    
    if (!_messageTextField) {
        _messageTextField = [[UITextField alloc] init];
        
        _messageTextField.borderStyle = UITextBorderStyleNone;
        _messageTextField.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _messageTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入聊天内容" attributes:@{
                                                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:12]
                                                                                                        }];
       
        _messageTextField.layer.cornerRadius = 5;
        _messageTextField.layer.masksToBounds = YES;
        _messageTextField.font = [UIFont systemFontOfSize:13];
        [_messageTextField addTarget:self action:@selector(textFieldEditAction:) forControlEvents:(UIControlEventAllEvents)];
        _messageTextField.delegate = self;
    }
    return _messageTextField;
}

- (UIButton *)faceBtn {
    
    if (!_faceBtn) {
        _faceBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_faceBtn setImage:[UIImage imageNamed:@"表情"] forState:(UIControlStateNormal)];
        [_faceBtn addTarget:self action:@selector(clickFaceBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _faceBtn;
}

- (UIButton *)sendMesBtn {
    
    if (!_sendMesBtn) {
        
        _sendMesBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        _sendMesBtn.layer.cornerRadius = 10;
        _sendMesBtn.layer.masksToBounds = YES;
        
        [_sendMesBtn setTitle:@"发送" forState:(UIControlStateNormal)];
        [_sendMesBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_sendMesBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        
        [_sendMesBtn addTarget:self action:@selector(clickSendMesBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sendMesBtn;
}

//- (UILabel *)line {
//    
//    if (!_line) {
//        _line = [[UILabel alloc] init];
//        _line.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
//    }
//    return _line;
//}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [textField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
@end
