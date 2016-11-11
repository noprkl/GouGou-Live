//
//  CertificatePromptView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CertificatePromptView.h"
#import "CertificateViewController.h"


@interface CertificatePromptView ()
/** 倒计时 */
@property (strong,nonatomic) UIButton *countdownBtn;
/** 开心狗图片 */
@property (strong,nonatomic) UIImageView *imageView;
/** 提示文字 */
@property (strong,nonatomic) UILabel *titlelable;
/** 实名认证按钮 */
@property (strong,nonatomic) UIButton *certificateButton;

@end

@implementation CertificatePromptView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.countdownBtn];
        [self addSubview:self.imageView];
        [self addSubview:self.titlelable];
        [self addSubview:self.certificateButton];
        
    }
    return self;
}

#pragma mark
#pragma mark - 约束
-(void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;

    [_countdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(10);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(50);
        make.centerX.equalTo(weakself.centerX);
        
    }];

    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.imageView.bottom).offset(20);
        make.centerX.equalTo(weakself.centerX);
        
    }];
    
    [_certificateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.titlelable.bottom).offset(20);
        make.centerX.equalTo(weakself.centerX);
        make.left.equalTo(weakself.left).offset(10);
        make.height.equalTo(44);
        
    }];
}

#pragma mark
#pragma mark - 懒加载
-(UIButton *)countdownBtn {

    if (!_countdownBtn) {
        _countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_countdownBtn setTitle:@"2s自动跳转" forState:UIControlStateNormal];
        
        _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_countdownBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        [_countdownBtn addTarget:self action:@selector(countdownAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _countdownBtn;
}

- (UIImageView *)imageView {

    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon开心狗"]];
    }
    return _imageView;
}

- (UILabel *)titlelable {

    if (!_titlelable) {
        _titlelable = [[UILabel alloc] init];
        _titlelable.text = @"只有完成实名认证后才可商家认证";
        _titlelable.textColor = [UIColor colorWithHexString:@"#999999"];
        _titlelable.font = [UIFont systemFontOfSize:14];
    }
    return _titlelable;
}

- (UIButton *)certificateButton {

    if (!_certificateButton) {
        _certificateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _certificateButton.layer.cornerRadius = 5;
        _certificateButton.layer.masksToBounds = YES;
        [_certificateButton setTitle:@"实名认证" forState:UIControlStateNormal];
        _certificateButton.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_certificateButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _certificateButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_certificateButton addTarget:self action:@selector(clickCertificateBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _certificateButton;
}

- (void)clickCertificateBtn:(UIButton *)button {

    if (_certificateBlack) {
        _certificateBlack();
    }
    
}

- (void)countdownAction:(UIButton *)button {

    if (_countdownBlock) {
        _countdownBlock(button);
    }
}

@end
