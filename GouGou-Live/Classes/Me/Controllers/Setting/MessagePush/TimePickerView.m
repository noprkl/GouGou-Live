//
//  TimePickerView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TimePickerView.h"

@interface TimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/** 蒙版 */
@property (strong,nonatomic) UIControl *areaHUD;

@property(nonatomic, strong) UIView *backGroundView; /**< 背景View */
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** title */
@property (strong, nonatomic) UILabel *titleLabel;
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;
///** pickerView */
//@property (strong, nonatomic) UIPickerView *areaPicker;
/** 时间datePicker */
@property (strong,nonatomic) UIDatePicker *datePicker;
/** 第一列数据 */
@property (strong,nonatomic) NSArray *firstData;
@property (assign, nonatomic) NSInteger apmCurrentIndex;// 用来记录‘当前’上下午的下标(地址键盘第 0 列选中 row))
@property (assign, nonatomic) NSInteger hourCurrentIndex; // 用来记录''当前''的小时的下标(地址键盘第 1 列选中的 row)
@property (assign, nonatomic) NSInteger secondCurrenIndex; // 记录分
@end

@implementation TimePickerView

- (void)setTimeLabel:(NSString *)timeLabel {

    _timeLabel = timeLabel;
    self.titleLabel.text = timeLabel;
}

- (NSArray *)firstData {

    if (!_firstData) {
        _firstData = @[@"上午",@"下午"];
    }
    return _firstData;
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
//- (UIPickerView *)areaPicker {
//    if (!_areaPicker) {
//        _areaPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
//        _areaPicker.backgroundColor = [UIColor whiteColor];
//        _areaPicker.delegate = self;
//        _areaPicker.dataSource = self;
//    }
//    return _areaPicker;
//}

- (UIDatePicker *)datePicker {

    if (!_datePicker) {
        
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
- (void)clickSureBtnAction {
    if (_timeBlock) {
        _timeBlock( @"am", @"pm");
    }
    
}

- (void)clickCancelBtnAction {
    
    [self fadeOut];
}
/*
#pragma mark
#pragma mark - 级联代理方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    // 列数
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        // 获取第一列数据
        return self.firstData.count;
    } else if (component == 1) {
    
        return self.hourTime.count;
    } else if (component == 2) {
    
        return 60;
    }
    
    return 0;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return self.firstData[row];
    } else if (component == 1) {

        
        NSString * string = [NSString stringWithFormat:@"%@",self.hourTime[row]];
        
        return string;
    } else if (component == 2) {
    
        NSString * string = [NSString stringWithFormat:@"%@",self.secondTime[row]];
        
        return string;
    }
//
    return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    switch (component) {
        case 0:
            // 滑动了第 0 列 更新后两列
            self.apmCurrentIndex = [pickerView selectedRowInComponent:0];
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            self.hourCurrentIndex = 0;
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            break;
            
        case 1:
            // 滑动了第 1 列 更新最后一列
            self.hourCurrentIndex = [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            self.secondCurrenIndex = 0;
            break;
            
        case 2:
            self.secondCurrenIndex = [pickerView selectedRowInComponent:2];
            break;
            
        default:
            break;
    }
    
}
*/

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
