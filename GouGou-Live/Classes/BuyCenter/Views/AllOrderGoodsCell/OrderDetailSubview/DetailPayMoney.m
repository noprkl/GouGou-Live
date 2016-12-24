//
//  DetailPayMoney.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DetailPayMoney.h"

@interface DetailPayMoney ()
/** 尾款 */
@property (strong,nonatomic) UILabel *backMoneyLabel;
/** 尾款数 */
@property (strong,nonatomic) UILabel *backMoney;
/** 实付款 */
@property (strong,nonatomic) UILabel *totalMoneyLabel;
/** 总款数 */
@property (strong,nonatomic) UILabel *totalMoney;
/** 实付尾款 */
@property (strong,nonatomic) UILabel *needBackLabel;
/** 实付尾款数 */
@property (strong,nonatomic) UILabel *needBackMoney;
/** 实付定金 */
@property (strong,nonatomic) UILabel *fontMoneyLabel;
/** 实付定金数 */
@property (strong,nonatomic) UILabel *fontMoney;

@end

@implementation DetailPayMoney

- (void)setBalance:(NSString *)balance {

    _balance = balance;
    self.backMoney.text = balance;
}

- (void)setRealMoney:(NSString *)realMoney {
    
    _realMoney = realMoney;
    self.totalMoney.text = realMoney;
//    self.totalMoney.text = [NSString stringWithFormat:@"%ld",[self.needBackMessage integerValue] + [self.fontMoneyMessage integerValue]];
}
- (void)setNeedBackMessage:(NSString *)needBackMessage {
    
    _needBackMessage = needBackMessage;
    self.needBackMoney.text = needBackMessage;
}

- (void)setFontMoneyMessage:(NSString *)fontMoneyMessage {
    
    _fontMoneyMessage = fontMoneyMessage;
    self.fontMoney.text = fontMoneyMessage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.backMoneyLabel];
        [self addSubview:self.backMoney];
        [self addSubview:self.totalMoneyLabel];
        [self addSubview:self.totalMoney];
        [self addSubview:self.needBackLabel];
        [self addSubview:self.needBackMoney];
        [self addSubview:self.fontMoneyLabel];
        [self addSubview:self.fontMoney];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.top.equalTo(weakself.top).offset(10);
        
    }];
    
    [_totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.totalMoney.left);
        make.centerY.equalTo(weakself.totalMoney.centerY);
    }];
    
    [_backMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.totalMoneyLabel.left).offset(-10);
        make.centerY.equalTo(weakself.totalMoney.centerY);
    }];
    
    [_backMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.backMoney.left);
        make.centerY.equalTo(weakself.totalMoney.centerY);
    }];
    
    [_needBackMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(weakself.right).offset(-10);
        make.top.equalTo(weakself.totalMoney.bottom).offset(25);
        
    }];
    
    [_needBackLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.needBackMoney.left).offset(-10);
        make.centerY.equalTo(weakself.needBackMoney.centerY);
        
    }];
    
    [_fontMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.right.equalTo(weakself.right).offset(-10);
        make.top.equalTo(weakself.needBackMoney.bottom).offset(20);
        
    }];
    
    [_fontMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.fontMoney.left).offset(-10);
        make.centerY.equalTo(weakself.fontMoney.centerY);
        
    }];
    
    
}

#pragma mark
#pragma mark - 懒加载
- (UILabel *)backMoneyLabel {

    if (!_backMoneyLabel) {
        _backMoneyLabel = [[UILabel alloc] init];
        _backMoneyLabel.text = @"尾款:";
        _backMoneyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _backMoneyLabel.font = [UIFont systemFontOfSize:14];
    }
    return _backMoneyLabel;
}
- (UILabel *)backMoney {
    
    if (!_backMoney) {
        _backMoney = [[UILabel alloc] init];
        _backMoney.text = @"￥950";
        _backMoney.textColor = [UIColor colorWithHexString:@"#333333"];
        _backMoney.font = [UIFont systemFontOfSize:16];
    }
    return _backMoney;
}
- (UILabel *)totalMoneyLabel {
    
    if (!_totalMoneyLabel) {
        _totalMoneyLabel = [[UILabel alloc] init];
        _totalMoneyLabel.text = @"实付款:";
        _totalMoneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _totalMoneyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _totalMoneyLabel;
}
- (UILabel *)totalMoney {
    
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.text = @"￥1450";
        _totalMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _totalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _totalMoney;
}
- (UILabel *)needBackLabel {
    
    if (!_needBackLabel) {
        _needBackLabel = [[UILabel alloc] init];
        _needBackLabel.text = @"实付尾款:";
        _needBackLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _needBackLabel.font = [UIFont systemFontOfSize:14];
    }
    return _needBackLabel;
}
- (UILabel *)needBackMoney {
    
    if (!_needBackMoney) {
        _needBackMoney = [[UILabel alloc] init];
        _needBackMoney.text = @"￥950";
        _needBackMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _needBackMoney.font = [UIFont systemFontOfSize:14];
    }
    return _needBackMoney;
}
- (UILabel *)fontMoneyLabel {
    
    if (!_fontMoneyLabel) {
        _fontMoneyLabel = [[UILabel alloc] init];
        _fontMoneyLabel.text = @"实付定金:";
        _fontMoneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fontMoneyLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fontMoneyLabel;
}
- (UILabel *)fontMoney {
    
    if (!_fontMoney) {
        _fontMoney = [[UILabel alloc] init];
        _fontMoney.text = @"￥500";
        _fontMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _fontMoney.font = [UIFont systemFontOfSize:14];
    }
    return _fontMoney;
}

@end
