//
//  TowButtonView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TowButtonView.h"

@interface TowButtonView ()


@end

@implementation TowButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.liveBtn];
        [self addSubview:self.dogBtn];
    }
    return self;
}

- (UIButton *)liveBtn{
    if (!_liveBtn) {
        _liveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _liveBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
        [_liveBtn setTitle:@"直播" forState:(UIControlStateNormal)];
        _liveBtn.titleLabel.font = [UIFont systemFontOfSize:16];

        [_liveBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        [_liveBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateSelected)];
        [_liveBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        _liveBtn.selected = YES;
    }
    return _liveBtn;
}

- (UIButton *)dogBtn{
    if (!_dogBtn) {
        _dogBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _dogBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 44);
        [_dogBtn setTitle:@"狗狗" forState:(UIControlStateNormal)];
        [_dogBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
        [_dogBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        _dogBtn.titleLabel.font = [UIFont systemFontOfSize:16];

        
        _dogBtn.selected = NO;
    }
    return _dogBtn;
}

@end
