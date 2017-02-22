//
//  NonoDogTypesView.m
//  GouGou-Live
//
//  Created by 李祥起 on 2017/2/22.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "NonoDogTypesView.h"

@interface NonoDogTypesView ()

/** icon */
@property (strong, nonatomic) UIImageView *iconImage;

/** 提示label */
@property (strong, nonatomic) UILabel *warnLabel;


@property (nonatomic, strong) UIButton *reRequest; /**< 重新加载 */

@end

@implementation NonoDogTypesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.warnLabel];
        [self addSubview:self.reRequest];
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
    [self.reRequest makeConstraints:^(MASConstraintMaker *make) {
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
        
        _warnLabel.text = @"没有搜到该类的直播";
    }
    return _warnLabel;
}
- (UIButton *)reRequest {
    if (!_reRequest) {
        _reRequest = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [_reRequest setTitle:@"重新加载" forState:(UIControlStateNormal)];
        [_reRequest setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        _reRequest.layer.cornerRadius = 5;
        _reRequest.layer.masksToBounds = YES;
        _reRequest.titleLabel.font = [UIFont systemFontOfSize:16];
        _reRequest.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_reRequest addTarget:self action:@selector(ClickRequestAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _reRequest;
}
- (void)ClickRequestAction:(UIButton *)btn {
    if (_requestBlock) {
        _requestBlock();
    }
}

@end
