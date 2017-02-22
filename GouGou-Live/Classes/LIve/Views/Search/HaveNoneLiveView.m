//
//  HaveNoneLiveView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HaveNoneLiveView.h"

@interface HaveNoneLiveView ()

/** icon */
@property (strong, nonatomic) UIImageView *iconImage;

/** 提示label */
@property (strong, nonatomic) UILabel *warnLabel;


@property (nonatomic, strong) UIButton *backBtn; /**< 返回 */

@end

@implementation HaveNoneLiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.warnLabel];
        [self addSubview:self.backBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(100);
    }];
    
    [self.warnLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.iconImage.bottom).offset(20);
    }];
    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.warnLabel.bottom).offset(20);
        make.left.equalTo(self.left).offset(40);
        make.height.equalTo(50);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矢量智能对象"]];
    }
    return _iconImage;
}
- (UILabel *)warnLabel {
    if (!_warnLabel) {
        _warnLabel = [[UILabel alloc] init];
        _warnLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _warnLabel.font = [UIFont systemFontOfSize:15];
        _warnLabel.text = @"没有搜到该品种的直播";
    }
    return _warnLabel;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [_backBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        _backBtn.layer.cornerRadius = 5;
        _backBtn.layer.masksToBounds = YES;
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _backBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_backBtn addTarget:self action:@selector(ClickRequestAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (void)ClickRequestAction {
    if (_backBlock) {
        _backBlock();
    }
}
@end
