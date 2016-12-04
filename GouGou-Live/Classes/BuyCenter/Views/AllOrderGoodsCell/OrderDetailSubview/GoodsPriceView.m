//
//  GoodsPriceView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "GoodsPriceView.h"

@interface GoodsPriceView  ()
/** 商品总价 */
@property (strong,nonatomic) UILabel *totalPrice;
/** 总钱数 */
@property (strong,nonatomic) UILabel *totalMoney;
/** 运费 */
@property (strong,nonatomic) UILabel *freightLabel;
/** 运费钱数 */
@property (strong,nonatomic) UILabel *freightMoney;
/** 优惠 */
@property (strong,nonatomic) UILabel *preferentialLabel;
/** 优惠钱数 */
@property (strong,nonatomic) UILabel *preferentialMoney;

@end

@implementation GoodsPriceView

- (void)setTraficFee:(NSString *)traficFee {

    _traficFee = traficFee;
    self.freightLabel.text = traficFee;
}

- (void)setTotalsMoney:(NSString *)totalsMoney {
    
    _totalsMoney = totalsMoney;
    self.totalMoney.text = [NSString stringWithFormat:@"%ld",[self.productBalance integerValue] + [self.productDeposit integerValue]];
    
}

- (void)setCutMoney:(NSString *)cutMoney {

    _cutMoney = cutMoney;
    self.preferentialLabel.text = [NSString stringWithFormat:@"%ld",([self.totalMoney.text integerValue] - [self.productRealDeposit integerValue] - [self.productRealBalance integerValue] - [self.freightLabel.text integerValue])];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.totalPrice];
        [self addSubview:self.totalMoney];
        [self addSubview:self.freightLabel];
        [self addSubview:self.freightMoney];
        [self addSubview:self.preferentialLabel];
        [self addSubview:self.preferentialMoney];
        
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
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.totalPrice.centerY);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    [_freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.totalPrice.bottom).offset(30);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_freightMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.freightLabel.centerY);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    [_preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.freightLabel.bottom).offset(30);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_preferentialMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.preferentialLabel.centerY);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    
}

#pragma mark
#pragma mark - 懒加载
- (UILabel *)totalPrice {

    if (!_totalPrice) {
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.text = @"商品总价";
        _totalPrice.textColor = [UIColor colorWithHexString:@"#000000"];
        _totalPrice.font = [UIFont systemFontOfSize:16];
    }
    return _totalPrice;
}

- (UILabel *)totalMoney {
    
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.text = @"2400";
        _totalMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _totalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _totalMoney;
}

- (UILabel *)freightLabel {
    
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        _freightLabel.text = @"运费";
        _freightLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _freightLabel.font = [UIFont systemFontOfSize:16];
    }
    return _freightLabel;
}
- (UILabel *)freightMoney {
    
    if (!_freightMoney) {
        _freightMoney = [[UILabel alloc] init];
        _freightMoney.text = @"50";
        _freightMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _freightMoney.font = [UIFont systemFontOfSize:16];
    }
    return _freightMoney;
}

- (UILabel *)preferentialLabel {
    
    if (!_preferentialLabel) {
        _preferentialLabel = [[UILabel alloc] init];
        _preferentialLabel.text = @"优惠";
        _preferentialLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _preferentialLabel.font = [UIFont systemFontOfSize:16];
    }
    return _preferentialLabel;
}
- (UILabel *)preferentialMoney {
    
    if (!_preferentialMoney) {
        _preferentialMoney = [[UILabel alloc] init];
        _preferentialMoney.text = @"1000";
        _preferentialMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _preferentialMoney.font = [UIFont systemFontOfSize:16];
    }
    return _preferentialMoney;
}

@end
