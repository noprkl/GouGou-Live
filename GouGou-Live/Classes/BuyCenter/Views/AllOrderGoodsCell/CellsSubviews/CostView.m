
//
//  costView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CostView.h"

@interface CostView  ()
/** 合计 */
@property (strong,nonatomic) UILabel *totalLabel;
/** 总钱数 */
@property (strong,nonatomic) UILabel *totalMoney;
/** 运费 */
@property (strong,nonatomic) UILabel *freightLabel;
/** 运费数 */
@property (strong,nonatomic) UILabel *freightMoney;
/** 已付定金 */
@property (strong,nonatomic) UILabel *fontMoneyLabel;
/** 定金 */
@property (strong,nonatomic) UILabel *fontMoney;
/** 已付尾款 */
@property (strong,nonatomic) UILabel *remainderMoneylabel;
/** 尾款 */
@property (strong,nonatomic) UILabel *remainderMoeny;

@end

@implementation CostView

- (void)costWithFreightPrice:(NSString *)freghtPrice fontMoneyLabel:(NSString *)fontLabel fontMoney:(NSString *)fontMoney backMoneyLable:(NSString *)backLabel backMoney:(NSString *)backMoney {

    self.freightMoney.text = freghtPrice;
    self.fontMoneyLabel.text = fontLabel;
    self.fontMoney.text = fontMoney;
    self.remainderMoneylabel.text = backLabel;
    self.remainderMoeny.text = backMoney;

}

- (void)setCostModel:(CostModel *)costModel {

    _costModel = costModel;
    self.freightLabel.text = [NSString stringWithFormat:@"%ld",([costModel.productRealDeposit integerValue] + [costModel.balance integerValue])];
    self.fontMoneyLabel.text = costModel.productRealDeposit;
    self.remainderMoneylabel.text = costModel.balance;
}

-(void)setMoneyMessage:(NSString *)moneyMessage {
    
    _moneyMessage = moneyMessage;
    self.totalMoney.text = moneyMessage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.totalLabel];
        [self addSubview:self.totalMoney];
        [self addSubview:self.freightLabel];
        [self addSubview:self.freightMoney];
        [self addSubview:self.fontMoneyLabel];
        [self addSubview:self.fontMoney];
        [self addSubview:self.remainderMoneylabel];
        [self addSubview:self.remainderMoeny];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    __weak typeof(self) weakself = self;

    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(5);
        
    }];
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.totalLabel.right).offset(5);
        make.centerY.equalTo(weakself.totalLabel.centerY);
        
    }];
    
    [_freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.totalLabel.bottom).offset(5);
        
    }];
    
    [_freightMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.freightLabel.right);
        make.centerY.equalTo(weakself.freightLabel.centerY);
        
    }];
    
    [_remainderMoeny mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);

        
    }];
    
    [_remainderMoneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.remainderMoeny.left);
        make.centerY.equalTo(weakself.centerY);

    }];
    
    [_fontMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.remainderMoneylabel.left).offset(-5);
        make.centerY.equalTo(weakself.centerY);
        
    }];

    
    [_fontMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.fontMoney.left);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    
    
    
}

#pragma mark
#pragma mark - 懒加载
-(UILabel *)totalLabel {

    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = @"合计:";
        _totalLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _totalLabel.font = [UIFont systemFontOfSize:14];
    }
    return _totalLabel;
}

-(UILabel *)totalMoney {
    
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.text = @"￥1450";
        _totalMoney.textColor = [UIColor colorWithHexString:@"#333333"];
        _totalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _totalMoney;
}

-(UILabel *)freightLabel {
    
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        _freightLabel.text = @"(含运费:";
        _freightLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _freightLabel.font = [UIFont systemFontOfSize:12];
    }
    return _freightLabel;
}
-(UILabel *)freightMoney {
    
    if (!_freightMoney) {
        _freightMoney = [[UILabel alloc] init];
//        _freightMoney.text = @"￥50)";
        _freightMoney.textColor = [UIColor colorWithHexString:@"#999999"];
        _freightMoney.font = [UIFont systemFontOfSize:12];
    }
    return _freightMoney;
}
-(UILabel *)fontMoneyLabel {
    
    if (!_fontMoneyLabel) {
        _fontMoneyLabel = [[UILabel alloc] init];
//        _fontMoneyLabel.text = @"已付定金:";
        _fontMoneyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _fontMoneyLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fontMoneyLabel;
}

-(UILabel *)fontMoney {
    
    if (!_fontMoney) {
        _fontMoney = [[UILabel alloc] init];
//        _fontMoney.text = @"￥500";
        _fontMoney.textColor = [UIColor colorWithHexString:@"#333333"];
        _fontMoney.font = [UIFont systemFontOfSize:16];
    }
    return _fontMoney;
}

-(UILabel *)remainderMoneylabel {
    
    if (!_remainderMoneylabel) {
        _remainderMoneylabel = [[UILabel alloc] init];
//        _remainderMoneylabel.text = @"已付尾款:";
        _remainderMoneylabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _remainderMoneylabel.font = [UIFont systemFontOfSize:14];
    }
    return _remainderMoneylabel;
}

-(UILabel *)remainderMoeny {
    
    if (!_remainderMoeny) {
        _remainderMoeny = [[UILabel alloc] init];
//        _remainderMoeny.text = @"￥950";
        _remainderMoeny.textColor = [UIColor colorWithHexString:@"#333333"];
        _remainderMoeny.font = [UIFont systemFontOfSize:16];
    }
    return _remainderMoeny;
}
@end
