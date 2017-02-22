//
//  DogAgeFilter.m
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogAgeFilter.h"

@interface DogAgeFilter () <UIPickerViewDataSource, UIPickerViewDelegate>

/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

#pragma mark view控件
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** title */
@property (strong, nonatomic) UILabel *titleLabel;
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;
/** 最小 */
@property (strong, nonatomic) UILabel *minLabel;
/** 最大 */
@property (strong, nonatomic) UILabel *maxLabel;
/** 转盘 */
@property (strong, nonatomic) UIPickerView *agePicker;
/** 年龄数据源 */
@property (strong, nonatomic) NSArray *ageData;

#pragma mark pickerView的值
/** 最小 */
@property (strong, nonatomic) DogCategoryModel *minModel;
/** 最大 */
@property (strong, nonatomic) DogCategoryModel *maxModel;
/** 记录当前的角标 */
@property (assign, nonatomic) NSInteger currentminIndex;
/** 记录当前的角标 */
@property (assign, nonatomic) NSInteger currentmaxIndex;

@end

static NSString *cellid = @"SizeFilterCellID";

@implementation DogAgeFilter
- (void)setDataPlist:(NSArray *)dataPlist {

    _dataPlist = dataPlist;
    self.ageData = dataPlist;
    [self.agePicker reloadAllComponents];
    self.minModel = self.ageData[0];
    self.maxModel = self.ageData[0];
}


#pragma mark
#pragma mark - Action + 代理
- (void)clickSureBtnAction {
    if (_ageRangeBlock) {
        _ageRangeBlock(self.minModel, self.maxModel);
        
        [self fadeOut];
    }}
- (void)clickCancelBtnAction {
    
    [self fadeOut];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.ageData.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    // 列数
    
    return 2;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    DogCategoryModel *model = self.dataPlist[row];
    if (component == 0) {
        
//        self.minString = self.dataPlist[row];
        return model.name;
    } else {
        
//        self.maxString = self.dataPlist[row];
#pragma mark - 级联菜单越界问题

        return model.name;
    }
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // 越界问题 最大的不能比最小的小
    if (component == 0) {
        if (row > self.currentmaxIndex) {
            [pickerView selectRow:row inComponent:1 animated:YES];
        }
    }else {
        NSInteger index = [pickerView selectedRowInComponent:1];
        if (index < self.currentminIndex) {
            [pickerView selectRow:row inComponent:0 animated:YES];
        }
    }
    self.currentminIndex = [pickerView selectedRowInComponent:0];
    self.currentmaxIndex = [pickerView selectedRowInComponent:1];

    self.minModel = self.dataPlist[self.currentminIndex];
    self.maxModel = self.dataPlist[self.currentmaxIndex];
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
        [self addSubview:self.minLabel];
        [self addSubview:self.maxLabel];
        [self addSubview:self.agePicker];

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
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    
    [self.minLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.top.equalTo(self.titleLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 1, 40));
    }];
    [self.maxLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.minLabel.centerY);
        make.right.equalTo(self.right);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 2 - 1, 40));
    }];
    [self.agePicker makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.minLabel.bottom).offset(2);
        make.left.right.bottom.equalTo(self);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)ageData {
    if (!_ageData) {
        _ageData = [NSArray array];
    }
    return _ageData;
}
- (UIPickerView *)agePicker {
    if (!_agePicker) {
        _agePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _agePicker.backgroundColor = [UIColor whiteColor];
        _agePicker.delegate = self;
        _agePicker.dataSource = self;
    }
    return _agePicker;
}
- (UILabel *)maxLabel {
    if (!_maxLabel) {
        _maxLabel = [[UILabel alloc] init];
        _maxLabel.backgroundColor = [UIColor whiteColor];
        _maxLabel.text = @"最大";
        _maxLabel.textAlignment = NSTextAlignmentCenter;
        _maxLabel.textColor = [UIColor colorWithHexString:@"#666666"];
     }
    return _maxLabel;
}
- (UILabel *)minLabel {
    if (!_minLabel) {
        _minLabel = [[UILabel alloc] init];
        _minLabel.backgroundColor = [UIColor whiteColor];
        _minLabel.textAlignment = NSTextAlignmentCenter;
        _minLabel.text = @"最小";
        _minLabel.textColor = [UIColor colorWithHexString:@"#666666"];

    }
    return _minLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"年龄";
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
