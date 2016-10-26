//
//  ResetLoginPsdView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ResetLoginPsdView.h"

@interface ResetLoginPsdView ()

@property (strong, nonatomic)  UITextField *oldPsdTextField;

@property (strong, nonatomic)  UILabel *viewTitleLabel;

@property (strong, nonatomic)  UILabel *alertLabel;

//背景蒙版
@property (strong , nonatomic) UIControl *overLayer;


@end


@implementation ResetLoginPsdView
- (UIControl *)overLayer
{
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}
- (void)awakeFromNib {

    NSString *title = self.titltBlock();
    self.viewTitleLabel.text = title;
    
    NSString *textHolder = self.textBlock(self.oldPsdTextField.text);
    self.oldPsdTextField.placeholder = textHolder;
    
    
}
- (IBAction)ClickDeleteBtnAction:(UIButton *)sender {
    
    self.deleBlock();
}
- (IBAction)clockSureBtnAction:(UIButton *)sender {
    
    self.sureBlock();
}
- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
    //根据overlayer设置alertView的中心点
    self.center = self.overLayer.center;
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss
{
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}

@end
