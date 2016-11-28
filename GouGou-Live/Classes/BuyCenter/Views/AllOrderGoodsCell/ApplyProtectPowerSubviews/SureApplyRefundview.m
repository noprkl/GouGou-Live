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
#pragma mark
#pragma mark - 约束

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
        [_refundTextfiled addTarget:self action:@selector(inputRefundMoney:) forControlEvents:UIControlEventAllEvents];
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
#pragma mark - textfiled点击事件
- (void)inputRefundMoney:(UITextField *)textfiled {

    if (_refundBlock) {
        _refundBlock(textfiled);
    }
}

#pragma mark
#pragma mark - textfiled代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.refundTextfiled) {
        
        BOOL flag = [NSString validateNumber:string];
        
        if (flag) {
            return YES;
        }
        return NO;
    }
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

     if (textView == _detailTextView) {
        
        if ([NSString isChinese:textView.text]) {
            
            return YES;
        }
        return NO;
    }

    return YES;
}
@end
