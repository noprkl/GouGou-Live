//
//  OrderNumberView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "OrderNumberView.h"

@interface OrderNumberView ()

/** 订单号 */
@property (strong,nonatomic) UILabel *orderNumLabel;
/** 号码 */
@property (strong,nonatomic) UILabel *orderNumber;
/** 复制 */
@property (strong,nonatomic) UIButton *copysButton;
/** 创建 */
@property (strong,nonatomic) UILabel *creatTimeLabel;
/** 创建时间 */
@property (strong,nonatomic) UILabel *creatTime;
/** 定金支付 */
@property (strong,nonatomic) UILabel *fontMoneyLabel;
/** 定金支付时间 */
@property (strong,nonatomic) UILabel *fontMoneyTime;
/** 尾款支付 */
@property (strong,nonatomic) UILabel *backMoneyLabel;
/** 尾款支付时间 */
@property (strong,nonatomic) UILabel *backMoneyTime;
/** 发货 */
@property (strong,nonatomic) UILabel *consignmentLabel;
/** 发货时间 */
@property (strong,nonatomic) UILabel *consignmentTime;

@end

@implementation OrderNumberView
- (void)setBuyUserId:(NSString *)buyUserId {

    _buyUserId = buyUserId;
    self.orderNumLabel.text = buyUserId;
}
// 订单创建时间
- (void)setCreateTimes:(NSString *)createTimes {
    
    _createTimes = createTimes;
    self.creatTime.text = createTimes;

}
// 定金支付时间
- (void)setDepositTimes:(NSString *)depositTimes {

    _depositTimes = depositTimes;
    self.fontMoneyTime.text = depositTimes;
}
// 尾款支付时间
- (void)setBalanceTimes:(NSString *)balanceTimes {
    
    _balanceTimes = balanceTimes;
    self.backMoneyTime.text = balanceTimes;
}
// 发货时间
- (void)setDeliveryTimes:(NSString *)deliveryTimes {

    _deliveryTimes = deliveryTimes;
    self.consignmentTime.text = deliveryTimes;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self addSubview:self.orderNumLabel];
        [self addSubview:self.orderNumber];
        [self addSubview:self.copysButton];
        [self addSubview:self.creatTimeLabel];
        [self addSubview:self.creatTime];
        [self addSubview:self.fontMoneyLabel];
        [self addSubview:self.fontMoneyTime];
        [self addSubview:self.backMoneyLabel];
        [self addSubview:self.backMoneyTime];
        [self addSubview:self.consignmentLabel];
        [self addSubview:self.consignmentTime];
        
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
    
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(15);
        
    }];
    
    [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(weakself.orderNumLabel.right).offset(10);
        make.centerY.equalTo(weakself.orderNumLabel.centerY);
        
    }];
    
    [_copysButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.orderNumLabel.centerY);
        make.size.equalTo(CGSizeMake(50, 25));
        
    }];
    
    [_creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.orderNumLabel.bottom).offset(10);
        
    }];
    
    [_creatTime makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.creatTimeLabel.right);
        make.centerY.equalTo(weakself.creatTimeLabel.centerY);
        
    }];
    
    [_fontMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.creatTimeLabel.bottom).offset(10);
        
    }];
    
    [_fontMoneyTime makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.fontMoneyLabel.right);
        make.centerY.equalTo(weakself.fontMoneyLabel.centerY);
        
    }];
    
    [_backMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.fontMoneyLabel.bottom).offset(10);
        
    }];
    
    [_backMoneyTime makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.backMoneyLabel.right);
        make.centerY.equalTo(weakself.backMoneyLabel.centerY);
        
    }];
    
    [_consignmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.backMoneyLabel.bottom).offset(10);
        
    }];
    
    [_consignmentTime makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.consignmentLabel.right);
        make.centerY.equalTo(weakself.consignmentLabel.centerY);
        
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)orderNumLabel {

    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] init];
        _orderNumLabel.text = @"订单编号";
        _orderNumLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _orderNumLabel.font = [UIFont systemFontOfSize:16];
    }
    return _orderNumLabel;
}

- (UILabel *)orderNumber {
    
    if (!_orderNumber) {
        _orderNumber = [[UILabel alloc] init];
        _orderNumber.text = @"7821737273627";
        _orderNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        _orderNumber.font = [UIFont systemFontOfSize:14];
    }
    return _orderNumber;
}

- (UIButton *)copysButton {

    if (!_copysButton) {
        _copysButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_copysButton setTitle:@"复制" forState:UIControlStateNormal];
        [_copysButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_copysButton setBackgroundColor:[UIColor colorWithHexString:@"#e0e0e0"]];
        _copysButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _copysButton.layer.cornerRadius = 10;
        _copysButton.layer.masksToBounds = YES;
        
        _copysButton.layer.borderWidth = 1;
        _copysButton.layer.borderColor = [UIColor colorWithHexString:@"#b4b4b4"].CGColor;
        [_copysButton addTarget:self action:@selector(clickTheCopyButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copysButton;
}

- (UILabel *)creatTimeLabel {
    
    if (!_creatTimeLabel) {
        _creatTimeLabel = [[UILabel alloc] init];
        _creatTimeLabel.text = @"创建时间:";
        _creatTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _creatTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _creatTimeLabel;
}

- (UILabel *)creatTime {

    if (!_creatTime) {
        _creatTime = [[UILabel alloc] init];
        _creatTime .text = @"2016-11-11 19:00";
        _creatTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _creatTime.font = [UIFont systemFontOfSize:12];
    }
    return _creatTime;
}

- (UILabel *)fontMoneyLabel {
    
    if (!_fontMoneyLabel) {
        _fontMoneyLabel = [[UILabel alloc] init];
        _fontMoneyLabel.text = @"定金支付时间:";
        _fontMoneyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _fontMoneyLabel.font = [UIFont systemFontOfSize:12];
    }
    return _fontMoneyLabel;
}

- (UILabel *)fontMoneyTime {
    
    if (!_fontMoneyTime) {
        _fontMoneyTime = [[UILabel alloc] init];
        _fontMoneyTime .text = @"2016-11-11 19:00";
        _fontMoneyTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _fontMoneyTime.font = [UIFont systemFontOfSize:12];
    }
    return _fontMoneyTime;
}

- (UILabel *)backMoneyLabel {
    
    if (!_backMoneyLabel) {
        _backMoneyLabel = [[UILabel alloc] init];
        _backMoneyLabel.text = @"尾款支付时间:";
        _backMoneyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _backMoneyLabel.font = [UIFont systemFontOfSize:12];
    }
    return _backMoneyLabel;
}

- (UILabel *)backMoneyTime {
    
    if (!_backMoneyTime) {
        _backMoneyTime = [[UILabel alloc] init];
        _backMoneyTime .text = @"2016-11-11 19:00";
        _backMoneyTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _backMoneyTime.font = [UIFont systemFontOfSize:12];
    }
    return _backMoneyTime;
}

- (UILabel *)consignmentLabel {
    
    if (!_consignmentLabel) {
        _consignmentLabel = [[UILabel alloc] init];
        _consignmentLabel.text = @"发货时间:";
        _consignmentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _consignmentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _consignmentLabel;
}

- (UILabel *)consignmentTime {
    
    if (!_consignmentTime) {
        _consignmentTime = [[UILabel alloc] init];
        _consignmentTime .text = @"2016-11-11 19:00";
        _consignmentTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _consignmentTime.font = [UIFont systemFontOfSize:12];
    }
    return _consignmentTime;
}

- (void)clickTheCopyButton {

    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.orderNumber.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        DLog(@"%@",pab.string);
        
    }else
    {
        DLog(@"%@",pab.string);
        
    }
}

@end
