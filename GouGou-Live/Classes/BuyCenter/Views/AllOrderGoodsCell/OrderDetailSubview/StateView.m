//
//  StateView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "StateView.h"

@interface StateView ()
/** 订单状态 */
@property (strong,nonatomic) UILabel *orderState;
/** 剩余时间 */
@property (strong,nonatomic) UILabel *remianTime;

@end

@implementation StateView

- (void)setStateMessage:(NSString *)stateMessage {

    _stateMessage = stateMessage;
    self.orderState.text = stateMessage;
}

- (void)setTimeMessage:(NSString *)timeMessage {

    _timeMessage = timeMessage;
    self.remianTime.text = timeMessage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.orderState];
        [self addSubview:self.remianTime];
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_orderState mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(10);
        make.left.equalTo(weakself.left).offset(10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_remianTime mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(10);
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (UILabel *)orderState {

    if (!_orderState) {
        _orderState = [[UILabel alloc] init];

        _orderState.font = [UIFont systemFontOfSize:16];
        _orderState.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _orderState;
}

- (UILabel *)remianTime {

    if (!_remianTime) {
        _remianTime = [[UILabel alloc] init];
        _remianTime.text = @"还剩1天1小时自动放弃定金";
        _remianTime.font = [UIFont systemFontOfSize:12];
        _remianTime.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _remianTime;

}
@end
