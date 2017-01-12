//
//  SellerProtectPLogisticsInfoView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerProtectPLogisticsInfoView.h"

@interface SellerProtectPLogisticsInfoView ()
/** 物流信息 */
@property (strong,nonatomic) UILabel *logisticInfoLabel;
/** 快递名 */
@property (strong,nonatomic) UILabel *expressNameLabe;
/** 快递编号 */
@property (strong,nonatomic) UILabel *numLabel;

@property(nonatomic, strong) UIButton *copBtn; /**< 复制按钮 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@end

@implementation SellerProtectPLogisticsInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.logisticInfoLabel];
        [self addSubview:self.expressNameLabe];
        [self addSubview:self.numLabel];
        [self addSubview:self.copBtn];
        [self addSubview:self.line];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    
    [_logisticInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        
    }];
    
    [_expressNameLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.logisticInfoLabel.bottom).offset(30);
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.expressNameLabe.right).offset(10);
        make.centerY.equalTo(weakself.expressNameLabe.centerY);
        
    }];
    [_copBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.right).offset(-10);
        make.bottom.equalTo(weakself.bottom).offset(-10);
        make.size.equalTo(CGSizeMake(50, 25));
    }];
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself);
        make.bottom.equalTo(weakself.bottom);
        make.height.equalTo(1);
    }];
}
- (void)setOrderCode:(NSString *)orderCode {
    _orderCode = orderCode;
    self.numLabel.text = orderCode;
}
- (void)setOrderStyle:(NSString *)orderStyle {
    _orderStyle = orderStyle;
    self.expressNameLabe.text = orderStyle;
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)logisticInfoLabel {
    
    if (!_logisticInfoLabel) {
        _logisticInfoLabel = [[UILabel alloc] init];
        _logisticInfoLabel.text = @"物流信息";
        _logisticInfoLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _logisticInfoLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _logisticInfoLabel;
}

- (UILabel *)expressNameLabe {
    
    if (!_expressNameLabe) {
        _expressNameLabe = [[UILabel alloc] init];
        _expressNameLabe.text = @"狗狗快递";
        _expressNameLabe.textColor = [UIColor colorWithHexString:@"#000000"];
        _expressNameLabe.font = [UIFont systemFontOfSize:14];
        
    }
    return _expressNameLabe;
}
- (UILabel *)numLabel {
    
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.text = @"7281737272627";
        _numLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _numLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _numLabel;
}
- (UIButton *)copBtn {
    if (!_copBtn) {
        if (!_copBtn) {
            _copBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            
            // 字体
            [_copBtn setTitle:@"复制" forState:(UIControlStateNormal)];
            _copBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [_copBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
            // 圆角
            _copBtn.layer.cornerRadius = 10;
            _copBtn.layer.masksToBounds = YES;
            // 边框
            _copBtn.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
            _copBtn.layer.borderColor = [UIColor colorWithHexString:@"#b4b4b4"].CGColor;
            _copBtn.layer.borderWidth = 1;
            
            [_copBtn addTarget:self action:@selector(clickCopyBtnAction) forControlEvents:(UIControlEventTouchDown)];
        }
        return _copBtn;
    }
    return _copBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}


#pragma mark - Action
- (void)clickCopyBtnAction {
    if (_copyBlock) {
        _copyBlock();
    }
}
- (void)setHidEdit:(BOOL)hidEdit {
    _hidEdit = hidEdit;
    self.copBtn.hidden = hidEdit;
}

@end
