//
//  SureApplyRefundview.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SureApplyRefundview.h"

@interface SureApplyRefundview ()<UITextViewDelegate,UITextFieldDelegate>
/** 是否申请退款 */
@property (strong,nonatomic) UILabel *whetherApplyRefund;
/** switch */
@property (strong,nonatomic) UISwitch *swich;
/** 退款金额 */
@property (strong,nonatomic) UITextField *refundTextfiled;
/** 描述详情 */
@property (strong,nonatomic) UILabel *detailLabel;
/** 具体情况 */
@property (strong,nonatomic) UITextView *detailTextView;

@property (nonatomic, assign) BOOL isHaveDian; /**< 第一个是点 */

@property (nonatomic, assign) BOOL isFirstZero; /**< 第一个是0 */

@end

@implementation SureApplyRefundview

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.whetherApplyRefund];
        [self addSubview:self.swich];
        [self addSubview:self.refundTextfiled];
        [self addSubview:self.detailLabel];
        [self addSubview:self.detailTextView];
        }
    return self;
}
#pragma mark - setter

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_whetherApplyRefund mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        
    }];
    
    [_swich mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.whetherApplyRefund.centerY);
        
    }];
    
    [_refundTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.whetherApplyRefund.bottom).offset(10);
        make.centerX.equalTo(weakself.centerX);
        make.left.equalTo(weakself.left).offset(10);
        make.height.equalTo(44);
    }];

    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.refundTextfiled.bottom).offset(10);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.detailLabel.bottom).offset(10);
        make.centerX.equalTo(weakself.centerX);
        make.left.equalTo(weakself.left).offset(10);
        make.height.equalTo(80);
    }];
}

#pragma mark
#pragma mark - 懒加载
-(UILabel *)whetherApplyRefund {

    if (!_whetherApplyRefund) {
        _whetherApplyRefund = [[UILabel alloc] init];
        _whetherApplyRefund.text = @"是否需要申请退款";
        _whetherApplyRefund.textColor = [UIColor colorWithHexString:@"#333333"];
        _whetherApplyRefund.font = [UIFont systemFontOfSize:16];
    }
    return _whetherApplyRefund;
}

- (UISwitch *)swich {
    if (!_swich) {
        _swich = [[UISwitch alloc] init];
        [_swich setOn:NO];
        _swich.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
        [_swich addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _swich;
}

- (UITextField *)refundTextfiled {

    if (!_refundTextfiled) {
        _refundTextfiled = [[UITextField alloc] init];
        _refundTextfiled.delegate = self;
        _refundTextfiled.placeholder = @"￥ 金额不能大于实际交易额";
        _refundTextfiled.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _refundTextfiled.font = [UIFont systemFontOfSize:16];
        _refundTextfiled.layer.cornerRadius = 10;
        _refundTextfiled.layer.masksToBounds = YES;
        [_refundTextfiled addTarget:self action:@selector(inputRefundMoney:) forControlEvents:UIControlEventEditingChanged];
    }
    return _refundTextfiled;
}

- (UILabel *)detailLabel {

    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"描述详情（必填）";
        _detailLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _detailLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailLabel;
}

- (UITextView *)detailTextView {

    if (!_detailTextView) {
        _detailTextView = [[UITextView alloc] init];
        _detailTextView.delegate = self;
        _detailTextView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _detailTextView.font = [UIFont systemFontOfSize:14];
        _detailTextView.layer.cornerRadius = 10;
        _detailTextView.layer.masksToBounds = YES;
    }
    return _detailTextView;
}

- (void)openAction:(UISwitch *)swich {

    if (_openBlock) {
        _openBlock(swich.isOn);
    }
}

#pragma mark - textfiled点击事件
- (void)inputRefundMoney:(UITextField *)textfiled {
    // 设置大于实际金额时改为实际金额
    CGFloat realMoney = [_realMoney floatValue];
    CGFloat inputMoney = [textfiled.text floatValue];
    if (inputMoney > realMoney) {
        textfiled.text = _realMoney;
    }
    if (_refundBlock) {
        _refundBlock(textfiled.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.refundTextfiled) {
        
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian = NO;
        }
        if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
            _isFirstZero = NO;
        }
        
        if ([string length]>0)
            {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
                {
                
                if([textField.text length]==0){
                    if(single == '.'){
                        //首字母不能为小数点
                        return NO;
                    }
                    if (single == '0') {
                        _isFirstZero = YES;
                        return YES;
                    }
                }
                
                if (single=='.'){
                    if(!_isHaveDian)//text中还没有小数点
                        {
                        _isHaveDian=YES;
                        return YES;
                        }else{
                            return NO;
                        }
                }else if(single=='0'){
                    if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if([textField.text isEqualToString:@"0.0"]){
                            return NO;
                        }
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if (_isFirstZero&&!_isHaveDian){
                        //首位有0没.不能再输入0
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if (_isHaveDian){
                        //存在小数点，保留两位小数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt= (int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){
                        //首位有0没点
                        return NO;
                    }else{
                        return YES;
                    }
                }
                }else{
                    //输入的数据格式不正确
                    return NO;
                }
            }else{
                return YES;
            }
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    if (_descBlock) {
        _descBlock(textView.text);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

@end
