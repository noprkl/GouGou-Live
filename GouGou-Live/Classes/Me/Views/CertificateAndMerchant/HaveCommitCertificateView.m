//
//  HaveCommitCertificateView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/12.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HaveCommitCertificateView.h"

@interface HaveCommitCertificateView ()

@property (nonatomic, strong) UIImageView *iconView; /**< 图片 */

@property (nonatomic, strong) UILabel *noteLabel; /**< 提示 */

@property (nonatomic, strong) UIButton *backBtn; /**< 返回按钮 */

@end

@implementation HaveCommitCertificateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.noteLabel];
        [self addSubview:self.backBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(70);
        make.centerX.equalTo(self.centerX);
    }];
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.bottom).offset(10);
        make.centerX.equalTo(self.centerX);
    }];
    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noteLabel.bottom).offset(20);
        make.centerX.equalTo(self.centerX);
        make.left.equalTo(self.left).offset(40);
    }];
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矢量智能对象"]];
    }
    return _iconView;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"您的信息正在审核中";
        _noteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noteLabel.font = [UIFont systemFontOfSize:13];
    }
    return _noteLabel;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [_backBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _backBtn.layer.cornerRadius = 5;
        _backBtn.layer.masksToBounds = YES;
        _backBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (void)clickBackAction {
    if (_backBlock) {
        _backBlock();
    }
}
@end
