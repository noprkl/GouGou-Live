//
//  SellerCostView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerCostView.h"

@interface SellerCostView  ()

/** 合计 */
@property (strong,nonatomic) UILabel *totalLabel;
/** 总钱数 */
@property (strong,nonatomic) UILabel *totalMoney;
/** 运费 */
@property (strong,nonatomic) UILabel *freightLabel;
/** 已付定金 */
@property (strong,nonatomic) UILabel *fontMoneyLabel;
/** 定金 */
@property (strong,nonatomic) UILabel *fontMoney;
/** 已付尾款 */
@property (strong,nonatomic) UILabel *remainderMoneylabel;
/** 尾款 */
@property (strong,nonatomic) UILabel *remainderMoeny;

@property(nonatomic, strong) UIView *line; /**< 线 */

@end

@implementation SellerCostView

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
        [self addSubview:self.fontMoneyLabel];
        [self addSubview:self.fontMoney];
        [self addSubview:self.remainderMoneylabel];
        [self addSubview:self.remainderMoeny];
        [self addSubview:self.line];
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
    
    [_fontMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.totalMoney.right).offset(20);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_fontMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.fontMoneyLabel.right).offset(5);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_remainderMoneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.fontMoney.right).offset(10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_remainderMoeny mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.remainderMoneylabel.right).offset(5);
        make.centerY.equalTo(weakself.centerY);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
    }];
}

#pragma mark
#pragma mark - 懒加载
-(UILabel *)totalLabel {
    
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = @"合计:";
        _totalLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _totalLabel.font = [UIFont systemFontOfSize:14];
    }
    return _totalLabel;
}

-(UILabel *)totalMoney {
    
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.text = @"￥1450";
        _totalMoney.textColor = [UIColor colorWithHexString:@"#000000"];
        _totalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _totalMoney;
}

-(UILabel *)freightLabel {
    
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        _freightLabel.text = @"(含运费:￥50)";
        _freightLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _freightLabel.font = [UIFont systemFontOfSize:12];
    }
    return _freightLabel;
}

-(UILabel *)fontMoneyLabel {
    
    if (!_fontMoneyLabel) {
        _fontMoneyLabel = [[UILabel alloc] init];
        _fontMoneyLabel.text = @"已付定金:";
        _fontMoneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fontMoneyLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fontMoneyLabel;
}

-(UILabel *)fontMoney {
    
    if (!_fontMoney) {
        _fontMoney = [[UILabel alloc] init];
        _fontMoney.text = @"￥500";
        _fontMoney.textColor = [UIColor colorWithHexString:@"#000000"];
        _fontMoney.font = [UIFont systemFontOfSize:16];
    }
    return _fontMoney;
}

-(UILabel *)remainderMoneylabel {
    
    if (!_remainderMoneylabel) {
        _remainderMoneylabel = [[UILabel alloc] init];
        _remainderMoneylabel.text = @"已付尾款:";
        _remainderMoneylabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _remainderMoneylabel.font = [UIFont systemFontOfSize:14];
    }
    return _remainderMoneylabel;
}

-(UILabel *)remainderMoeny {
    
    if (!_remainderMoeny) {
        _remainderMoeny = [[UILabel alloc] init];
        _remainderMoeny.text = @"￥950";
        _remainderMoeny.textColor = [UIColor colorWithHexString:@"#000000"];
        _remainderMoeny.font = [UIFont systemFontOfSize:16];
    }
    return _remainderMoeny;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
@end
