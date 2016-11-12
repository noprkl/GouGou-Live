//
//  MyUnLoginView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyUnLoginView.h"
#import "FilteButton.h"

@interface MyUnLoginView ()

@property(nonatomic, strong) UIImageView *iconView; /**< 头像 */

@property(nonatomic, strong) FilteButton *loginBtn; /**< 登录 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@property(nonatomic, strong) UIButton *liveBtn; /**< 直播按钮 */

@property(nonatomic, strong) UIView *line2; /**< 线2 */

@end
@implementation MyUnLoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.loginBtn];
        [self addSubview:self.line];
        [self addSubview:self.liveBtn];
        [self addSubview:self.line2];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
   
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.centerX).offset(-10);
    }];
    
    [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView.centerY);
        make.left.equalTo(self.iconView.right).offset(10);
        make.size.equalTo(CGSizeMake(100, 50));
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.iconView.bottom).offset(5);
        make.height.equalTo(10);
    }];
    [self.liveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.liveBtn.bottom);
        make.height.equalTo(10);
    }];
}
#pragma mark
#pragma mark - Action
- (void)ClickLoginBtnAction {
    if (_loginBlcok) {
        _loginBlcok();
    }
}
- (void)ClickLiveBtnAction {
    
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"头像"];
    }
    return _iconView;
}
- (FilteButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [FilteButton buttonWithType:(UIButtonTypeSystem)];
        [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginBtn setImage:[UIImage imageNamed:@"返回-（小）"] forState:(UIControlStateNormal)];
        [_loginBtn addTarget:self action:@selector(ClickLoginBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _loginBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line2;
}
- (UIButton *)liveBtn {
    if (!_liveBtn) {
        _liveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_liveBtn setTintColor:[UIColor colorWithHexString:@"#333333"]];
        _liveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_liveBtn setTitle:@"商家认证后才能直播" forState:(UIControlStateNormal)];
        [_liveBtn addTarget:self action:@selector(ClickLiveBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _liveBtn;
}
@end
