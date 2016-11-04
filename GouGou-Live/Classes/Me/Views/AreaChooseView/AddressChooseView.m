//
//  AddressChooseView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddressChooseView.h"

@interface AddressChooseView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/** 蒙版 */
@property (strong,nonatomic) UIControl *areaHUD;
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;
/** title */
@property (strong, nonatomic) UILabel *titleLabel;
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;
/** pickerView */
@property (strong, nonatomic) UIPickerView *areaPicker;
/** 省数据源 */
//@property (strong, nonatomic) NSArray *provinceList;
///** 市数据 */
//@property (strong,nonatomic) NSArray *cityList;
///** 区数据 */
//@property (strong,nonatomic) NSArray *areaList;

@end

@implementation AddressChooseView

//-(void)setProvinceData:(NSArray *)provinceData {
//
//    _provinceData = provinceData;
//    
//    self.provinceList = provinceData;
//}
//
//- (void)setCityData:(NSArray *)cityData {
//
//    _cityData = cityData;
//    self.cityList = cityData;
//}
//
//- (void)setAreaData:(NSArray *)areaData {
//
//    _areaData = areaData;
//    
//    self.areaList = areaData;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.cancelBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.sureBtn];
        [self addSubview:self.areaPicker];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
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
    
    [self.areaPicker makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(2);
        make.left.right.bottom.equalTo(self);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
//- (NSArray *)areaList {
//    if (!_areaList) {
//        _areaList = [NSArray array];
//    }
//    return _areaList;
//}
- (UIPickerView *)areaPicker {
    if (!_areaPicker) {
        _areaPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _areaPicker.backgroundColor = [UIColor whiteColor];
        _areaPicker.delegate = self;
        _areaPicker.dataSource = self;
    }
    return _areaPicker;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请选择区域";
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


}

- (void)clickCancelBtnAction {

    [self fadeOut];
}
#pragma mark
#pragma mark - 级联代理方法

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    // 列数
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        // 获取第一列数据
        return self.areaData.count;
    }
    //第0列选中第几排
    NSInteger idx = [pickerView selectedRowInComponent:0];
    
    return self.areaData.count;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
        return nil;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        [pickerView reloadComponent:1];
    } else if (component == 1) {
    
        [pickerView reloadComponent:2];
    }
    
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
