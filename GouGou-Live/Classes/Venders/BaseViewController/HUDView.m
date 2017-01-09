//
//  HUDView.m
//  GouGou-Live
//
//  Created by ma c on 17/1/7.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "HUDView.h"

@interface HUDView ()

@property (nonatomic, strong) UIControl *overLayer; /**< 背景 */

@property (nonatomic, strong) UIView *blackView; /**< 黑色方块 */

@property (nonatomic, strong) UIActivityIndicatorView *ActivityView; /**< 指示器 */

@property (nonatomic, strong) UILabel *alertLabel; /**< 提示文字 */

@end

@implementation HUDView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.overLayer];
        [self.overLayer addSubview:self.blackView];
        [self.blackView addSubview:self.ActivityView];
        [self.blackView addSubview:self.alertLabel];
    }
    return self;
}

- (void)setUP {
    [self.blackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(200);
        make.size.equalTo(CGSizeMake(80, 100));
    }];
    [self.ActivityView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blackView.centerX);
        make.top.equalTo(self.blackView.top).offset(15);
    }];
    [self.alertLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.blackView.centerX);
        make.top.equalTo(self.ActivityView.bottom).offset(10);
    }];
}
- (void)setAlertStr:(NSString *)alertStr {
    _alertStr = alertStr;
    self.alertLabel.text = alertStr;
}
#pragma mark
#pragma mark - 懒加载
- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        _blackView.layer.cornerRadius = 10;
        _blackView.layer.masksToBounds = YES;
    }
    return _blackView;
}
- (UIActivityIndicatorView *)ActivityView {
    if (!_ActivityView) {
        _ActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    }
    return _ActivityView;
}
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _alertLabel.font = [UIFont systemFontOfSize:16];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _alertLabel;
}
#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer {
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor clearColor];
        //        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}
- (void)show {
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.frame = rect;
    [self.ActivityView startAnimating];
    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss {
    //返回时调用
    [self.ActivityView stopAnimating];
    [self fadeOut];
    
}
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut {
    [UIView animateWithDuration:0.5 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}

@end
