//
//  PowerOrderStateView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PowerOrderStateView.h"

@interface PowerOrderStateView ()
/** 订单状态 */
@property (strong,nonatomic) UILabel *orderState;
/** 订单号 */
@property (strong,nonatomic) UILabel *orderNumLabel;
/** 订单编号 */
@property (strong,nonatomic) UILabel *orderNumber;

@end

@implementation PowerOrderStateView
- (void)setOrderStateMessage:(NSString *)orderStateMessage {

    _orderStateMessage = orderStateMessage;
    self.orderState.text = orderStateMessage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.orderState];
        [self addSubview:self.orderNumLabel];
        [self addSubview:self.orderNumber];
        
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
    
    [_orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.orderNumber.left);
        make.centerY.equalTo(weakself.centerY);
        
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)orderState {

    if (!_orderState) {
        _orderState = [[UILabel alloc] init];
        _orderState.textColor = [UIColor colorWithHexString:@"#333333"];
        _orderState.text = @"待付尾款";
        _orderState.font = [UIFont systemFontOfSize:16];
    }
    return _orderState;
}

- (UILabel *)orderNumLabel {

    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc] init];
        _orderNumLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _orderNumLabel.text = @"订单号:";
        _orderNumLabel.font = [UIFont systemFontOfSize:14];
    }
    return _orderNumLabel;
}

- (UILabel *)orderNumber {

    if (!_orderNumber) {
        _orderNumber = [[UILabel alloc] init];
        _orderNumber.textColor = [UIColor colorWithHexString:@"#666666"];
        _orderNumber.text = @"827398292822";
        _orderNumber.font = [UIFont systemFontOfSize:14];
    }
    return _orderNumber;
}
@end
