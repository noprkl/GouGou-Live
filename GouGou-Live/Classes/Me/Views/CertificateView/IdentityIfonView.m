//
//  IdentityIfonView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "IdentityIfonView.h"

@interface IdentityIfonView   ()<UITextFieldDelegate>
/** 姓名 */
@property (strong,nonatomic) UILabel *nameLabel;
/** 文本框 */
@property (strong,nonatomic) UITextField *nameTextfiled;
/** 箭头图片 */
@property (strong,nonatomic) UIImageView *arrowsImage1;
/** 横线 */
@property (strong,nonatomic) UIView *lineView;
/** 身份证 */
@property (strong,nonatomic) UILabel *identityLabel;
/** 身份证号 */
@property (strong,nonatomic) UITextField *identitiNumTextfiled;
/** 箭头图片 */
@property (strong,nonatomic) UIImageView *arrowsImage2;
@end

@implementation IdentityIfonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTextfiled];
        [self addSubview:self.arrowsImage1];
        [self addSubview:self.lineView];
        [self addSubview:self.identityLabel];
        [self addSubview:self.identitiNumTextfiled];
        [self addSubview:self.arrowsImage2];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_nameTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.nameLabel.right).offset(5);
        make.centerY.equalTo(weakself.nameLabel.centerY);
        make.width.equalTo(200);
        
    }];

    [_arrowsImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.nameLabel.centerY);
        make.right.equalTo(weakself.right).offset(-10);
    
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.nameTextfiled.bottom).offset(15);
        make.right.equalTo(weakself.right);
        make.height.equalTo(1);
    }];

    [_identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.nameLabel.left);
        make.top.equalTo(weakself.lineView.bottom).offset(15);
        
    }];
    
    [_identitiNumTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.identityLabel.right).offset(5);
        make.centerY.equalTo(weakself.identityLabel.centerY);
        make.width.equalTo(200);

        
    }];
    
    [_arrowsImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.identityLabel.centerY);

    }];
}

#pragma mark
#pragma mark - 懒加载

- (UILabel *)nameLabel {

    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓名:";
        _nameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _nameLabel;
}

- (UITextField *)nameTextfiled {

    if (!_nameTextfiled) {
        _nameTextfiled = [[UITextField alloc] init];
        _nameTextfiled.delegate = self;
        _nameTextfiled.textColor = [UIColor colorWithHexString:@"#333333"];
        _nameTextfiled.font = [UIFont systemFontOfSize:16];
        [_nameTextfiled addTarget:self action:@selector(nameTextChangeAction:) forControlEvents:UIControlEventAllEvents];
    }
    return _nameTextfiled;
}

- (UIImageView *)arrowsImage1 {

    if (!_arrowsImage1) {
        _arrowsImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回-（小）"]];
    }
    return _arrowsImage1;
}

- (UIView *)lineView {

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}

- (UILabel *)identityLabel {
    
    if (!_identityLabel) {
        _identityLabel = [[UILabel alloc] init];
        _identityLabel.text = @"身份证号:";
        _identityLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _identityLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _identityLabel;
}

- (UITextField *)identitiNumTextfiled {
    
    if (!_identitiNumTextfiled) {
        _identitiNumTextfiled = [[UITextField alloc] init];
        _identitiNumTextfiled.delegate = self;
        _nameTextfiled.textColor = [UIColor colorWithHexString:@"#333333"];
        _identitiNumTextfiled.font = [UIFont systemFontOfSize:16];
        [_identitiNumTextfiled addTarget:self action:@selector(identityTextChangeAction:) forControlEvents:UIControlEventAllEvents];
    }
    return _identitiNumTextfiled;
}

- (UIImageView *)arrowsImage2 {
    
    if (!_arrowsImage2) {
        _arrowsImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回-（小）"]];
    }
    return _arrowsImage2;
}

- (void)nameTextChangeAction:(UITextField *)textfiled {

    if (_nameTextBlock) {
        _nameTextBlock(textfiled);
    }
}

- (void)identityTextChangeAction:(UITextField *)textfiled {

    if (_identiityTextBlock) {
        _identiityTextBlock(textfiled);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if (textField == self.nameTextfiled) {
        if ([string isChinese]) {
            return YES;
        }
        return NO;
    }else if (textField == self.identitiNumTextfiled) {
       
//        BOOL flag = [[NSString alloc] judgeIdentityStringValid:string];
        if (range.location < 18) {
            return YES;
        }
        return NO;
        
        
    }else{
        return NO;
    }
    
}
@end
