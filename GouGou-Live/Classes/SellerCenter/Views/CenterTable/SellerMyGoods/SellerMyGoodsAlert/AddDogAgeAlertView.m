//
//  AddDogAgeAlertView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddDogAgeAlertView.h"

@interface AddDogAgeAlertView () <UIPickerViewDataSource, UIPickerViewDelegate>

/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

#pragma mark view控件
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** title */
@property (strong, nonatomic) UILabel *titleLabel;
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;
/** 转盘 */
@property (strong, nonatomic) UIPickerView *colorPicker;
/** 数据源 */
@property (strong, nonatomic) NSArray *colorData;
/** 数据源 */
@property (strong, nonatomic) NSArray *yearData;
/** 数据源 */
@property (strong, nonatomic) NSArray *mouthData;

#pragma mark pickerView的值
@property (nonatomic, assign) NSInteger year; /**< 岁 */
@property (nonatomic, assign) NSInteger mouth; /**< 月 */

@end

static NSString *cellid = @"AddDogColorAlert";

@implementation AddDogAgeAlertView

#pragma mark
#pragma mark - Action + 代理
- (void)clickSureBtnAction {
    if (_ageBlock) {
       
        NSInteger age = self.year * 12 + self.mouth;
        _ageBlock(age);
        
        [self fadeOut];
    }
}
- (void)clickCancelBtnAction {
    
    [self fadeOut];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.yearData count];
    }else{
        return self.mouthData.count;
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    // 列数
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.yearData[row];
    }else{
        return self.mouthData[row];
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   
    if (component == 0) {
        self.year = row;
    }
    if (component == 1) {
        self.mouth = row;
    }
}

#pragma mark
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.sureBtn];
        [self addSubview:self.colorPicker];
    }
    return self;
}
- (void)setUP {
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(10);
    }];
    
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.colorPicker makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(10);
        make.left.right.bottom.equalTo(self);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)colorData {
    if (!_colorData) {
        _colorData = [NSArray array];
    }
    return _colorData;
}
- (NSArray *)yearData {
    if (!_yearData) {
        _yearData = @[@"0岁", @"1岁", @"2岁", @"3岁", @"4岁", @"5岁", @"6岁", @"7岁"];
    }
    return _yearData;
}
- (NSArray *)mouthData {
    if (!_mouthData) {
        _mouthData = @[@"0个月", @"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月", @"7个月", @"8个月", @"9个月", @"10个月", @"11个月", @"12个月"];
    }
    return _mouthData;
}
- (UIPickerView *)colorPicker {
    if (!_colorPicker) {
        _colorPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _colorPicker.backgroundColor = [UIColor whiteColor];
        _colorPicker.delegate = self;
        _colorPicker.dataSource = self;
    }
    return _colorPicker;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"颜色";
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
#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer
{
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}

- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 264, SCREEN_WIDTH, 264);
    self.frame = rect;
    
    // 约束
    [self setUP];
    
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
