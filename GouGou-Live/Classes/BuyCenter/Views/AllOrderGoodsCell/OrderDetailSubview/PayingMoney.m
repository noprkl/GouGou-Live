//
//  PayingMoney.m
//  GouGou-Live
//
//  Created by ma c on 16/11/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PayingMoney.h"

@interface PayingMoney ()
/** 应付全款 */
@property (strong,nonatomic) UILabel *payLabel;
/** 钱数 */
@property (strong,nonatomic) UILabel *payMoney;

@end

@implementation PayingMoney

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.payLabel];
        [self addSubview:self.payMoney];
    }
    return self;
}

- (void)setTotalMoney:(NSString *)totalMoney {

    _totalMoney = totalMoney;
    self.payMoney.text = [NSString stringWithFormat:@"%ld",[self.realLalance integerValue] + [self.productRealDeposit integerValue]];
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);
    }];
    
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.payMoney.left).offset(-10);
        make.centerY.equalTo(weakself.centerY);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)payMoney {

    if (!_payMoney) {
        _payMoney = [[UILabel alloc] init];
        _payMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _payMoney.text = @"￥1450";
        _payMoney.font = [UIFont systemFontOfSize:16];
    }
    return _payMoney;
}

- (UILabel *)payLabel {
    
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] init];
        _payLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _payLabel.text = @"应付全款";
        _payLabel.font = [UIFont systemFontOfSize:16];
    }
    return _payLabel;
}
@end
