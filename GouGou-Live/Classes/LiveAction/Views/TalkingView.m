//
//  TalkingView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TalkingView.h"

@interface TalkingView ()

@property(nonatomic, strong) UITextField *messageTextField; /**< 信息输入 */
@property(nonatomic, strong) UIButton *faceBtn; /**< 表情输入按钮 */

@property(nonatomic, strong) UIButton *sendMesBtn; /**< 信息发送按钮 */

@property(nonatomic, strong) UILabel *line; /**< 绿色的线 */

@end

@implementation TalkingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.messageTextField];
        [self addSubview:self.faceBtn];
        [self addSubview:self.sendMesBtn];
        [self addSubview:self.line];
    }
    return self;
}
- (void)layoutSubviews {
    
    [self.messageTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.height.equalTo(30);
        make.right.equalTo(self.right).offset(-90);
        make.left.equalTo(self.left).offset(10);
        
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
        make.left.right.equalTo(self.messageTextField);
        make.top.equalTo(self.messageTextField.bottom);
        make.height.equalTo(1);
        
    }];
    
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);

}
#pragma mark
#pragma mark - Action

- (void)clickSendMesBtnAction {
    if (_sendBlock) {
        _sendBlock();
    }
}

- (void)clickFaceBtnAction {
    if (_emojiBlock) {
        _emojiBlock();
    }
}
- (void)editingEvents:(UITextField *)textField {
    if (_editBlock) {
        _editBlock(textField);
    }
}
#pragma mark
#pragma mark - 懒加载
- (UITextField *)messageTextField {
    
    if (!_messageTextField) {
        _messageTextField = [[UITextField alloc] init];
        
        _messageTextField.borderStyle = UITextBorderStyleNone;
        [_messageTextField addTarget:self action:@selector(editingEvents:) forControlEvents:(UIControlEventAllEditingEvents)];
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

@end
