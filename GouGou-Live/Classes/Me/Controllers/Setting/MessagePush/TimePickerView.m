//
//  TimePickerView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TimePickerView.h"

@interface TimePickerView ()
/** 蒙版 */
@property (strong,nonatomic) UIControl *areaHUD;

@property(nonatomic, strong) UIView *backGroundView; /**< 背景View */
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** title */
@property (strong, nonatomic) UILabel *titleLabel;
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;

// 时间滚轮
@property (strong,nonatomic) UIDatePicker *datePicker;

@property (copy, nonatomic) NSString *timeString; /**< 获取时间信息 */

@end

@implementation TimePickerView

- (void)setTimeLabel:(NSString *)timeLabel {

    _timeLabel = timeLabel;
    self.titleLabel.text = timeLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backGroundView];
        [self.backGroundView addSubview:self.cancelBtn];
        [self.backGroundView addSubview:self.titleLabel];
        [self.backGroundView addSubview:self.sureBtn];
        [self addSubview:self.datePicker];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.backGroundView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.right.equalTo(self);
        make.height.equalTo(45);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backGroundView.center);
    }];
    
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY);
        make.left.equalTo(self.backGroundView.left).offset(10);
    }];
    
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY);
        make.right.equalTo(self.backGroundView.right).offset(-10);
    }];
    
    [self.datePicker makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView.bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _backGroundView;
}

- (UIDatePicker *)datePicker {

    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        // 设置时区
        [_datePicker setTimeZone:[NSTimeZone localTimeZone]];
        
        // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
       
        // 设置UIDatePicker的显示模式
        [_datePicker setDatePickerMode:UIDatePickerModeTime];
        // 当值发生改变的时候调用的方法
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        NSDate *date = [NSDate date];
        NSDateFormatter * format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"hh:ss";
        NSString * string = [format stringFromDate:date];
        self.timeString = string;
    }
    return _datePicker;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _titleLabel;
}

- (UIButton *)sureBtn {
    
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureBtn sizeToFit];
        [_sureBtn setTintColor:[UIColor colorWithHexString:@"#ffa11a"]];
        [_sureBtn setTitle:@"确认" forState:(UIControlStateNormal)];
        [_sureBtn addTarget:self action:@selector(clickSureBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_cancelBtn setTintColor:[UIColor colorWithHexString:@"#ffa11a"]];
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _cancelBtn;
}
#pragma mark - 时间改变
- (void)datePickerValueChanged:(UIDatePicker *)picker {
    
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"hh:ss";
    NSString * string = [format stringFromDate:picker.date];
    self.timeString = string;
}
#pragma mark - 按钮点击
- (void)clickSureBtnAction {
    if (_timeBlock) {
        _timeBlock(self.timeString);
    }
}

- (void)clickCancelBtnAction {
    
    [self fadeOut];
}


#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)areaHUD
{
    // 懒加载 蒙版
    if (!_areaHUD) {
        _areaHUD = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _areaHUD.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _areaHUD;
}

- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.areaHUD];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 264, SCREEN_WIDTH, 264);
    self.frame = rect;
    
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
    
    self.areaHUD.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.areaHUD.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.areaHUD.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.areaHUD removeFromSuperview];
    }];
}
@end
