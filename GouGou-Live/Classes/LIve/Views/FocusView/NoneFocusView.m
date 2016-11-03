//
//  NoneFocusView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NoneFocusView.h"

@interface NoneFocusView ()

/** icon */
@property (strong, nonatomic) UIImageView *iconImage;

/** 提示label */
@property (strong, nonatomic) UILabel *warnLabel;

@end

@implementation NoneFocusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.warnLabel];
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
        _warnLabel.text = @"没有正在直播的主播";
    }
    return _warnLabel;
}
@end
