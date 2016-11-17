//
//  SellerOrderDetailInfoView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailInfoView.h"

@interface SellerOrderDetailInfoView ()

@property(nonatomic, strong) UILabel *orderCode; /**< 订单编号 */
@property(nonatomic, strong) UILabel *orderCodeNumber; /**< 编号 */

@property(nonatomic, strong) UILabel *create; /**< 创建 */
@property(nonatomic, strong) UILabel *createTime; /**< 创建时间 */

@property(nonatomic, strong) UILabel *deposit; /**< 定金 */
@property(nonatomic, strong) UILabel *depositTime; /**< 定金支付时间 */

@property(nonatomic, strong) UILabel *finalMoney; /**< 尾款 */
@property(nonatomic, strong) UILabel *finalMoneyTime; /**< 尾款支付时间 */

@property(nonatomic, strong) UILabel *send; /**< 发货 */
@property(nonatomic, strong) UILabel *sendTime; /**< 发货时间 */

@property(nonatomic, strong) UIButton *copBtn; /**< 复制按钮 */

@end

@implementation SellerOrderDetailInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.orderCode];
        [self addSubview:self.orderCodeNumber];
        
        [self addSubview:self.create];
        [self addSubview:self.createTime];
        
        [self addSubview:self.deposit];
        [self addSubview:self.depositTime];
        
        [self addSubview:self.finalMoney];
        [self addSubview:self.finalMoneyTime];
        
        [self addSubview:self.send];
        [self addSubview:self.sendTime];
        
        [self addSubview:self.copBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.orderCode makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.orderCodeNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderCode.centerY);
        make.left.equalTo(self.orderCode.right);
    }];
    [self.copBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderCode.centerY);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(50, 25));
    }];
    // 创建
    [self.create makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderCode.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.createTime makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.create.centerY);
        make.left.equalTo(self.create.right);
    }];
   
    // 定金
    [self.deposit makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.create.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.depositTime makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.deposit.centerY);
        make.left.equalTo(self.deposit.right);
    }];

    // 尾款
    [self.finalMoney makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deposit.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.finalMoneyTime makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.finalMoney.centerY);
        make.left.equalTo(self.finalMoney.right);
    }];
   
    // 发货
    [self.send makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finalMoney.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.sendTime makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.send.centerY);
        make.left.equalTo(self.send.right);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)orderCode {
    if (!_orderCode) {
        _orderCode = [[UILabel alloc] init];
        _orderCode.text = @"订单编号";
        _orderCode.textColor = [UIColor colorWithHexString:@"#000000"];
        _orderCode.font = [UIFont systemFontOfSize:16];
    }
    return _orderCode;
}
- (UILabel *)orderCodeNumber {
    if (!_orderCodeNumber) {
        _orderCodeNumber = [[UILabel alloc] init];
        _orderCodeNumber.text = @"2648765283764";
        _orderCodeNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        _orderCodeNumber.font = [UIFont systemFontOfSize:14];
    }
    return _orderCodeNumber;
}
- (UILabel *)create {
    if (!_create) {
        _create = [[UILabel alloc] init];
        _create.text = @"创建时间:";
        _create.textColor = [UIColor colorWithHexString:@"#666666"];
        _create.font = [UIFont systemFontOfSize:12];
    }
    return _create;
}

- (UILabel *)createTime {
    if (!_createTime) {
        _createTime = [[UILabel alloc] init];
       
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        
        _createTime.text = [format stringFromDate:date];
        _createTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _createTime.font = [UIFont systemFontOfSize:12];
    }
    return _create;
}
- (UILabel *)deposit {
    if (!_deposit) {
        _deposit = [[UILabel alloc] init];
        
        _deposit.text = @"定金支付时间:";
        _deposit.textColor = [UIColor colorWithHexString:@"#666666"];
        _deposit.font = [UIFont systemFontOfSize:12];
    }
    return _deposit;
}
- (UILabel *)depositTime {
    if (!_depositTime) {
        _depositTime = [[UILabel alloc] init];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSString *nowTime = [format stringFromDate:date];
        
        _depositTime.text = nowTime;
        _depositTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _depositTime.font = [UIFont systemFontOfSize:12];
    }
    return _depositTime;
}
- (UILabel *)finalMoney {
    if (!_finalMoney) {
        _finalMoney = [[UILabel alloc] init];
        
        _finalMoney.text = @"尾款支付时间:";
        _finalMoney.textColor = [UIColor colorWithHexString:@"#666666"];
        _finalMoney.font = [UIFont systemFontOfSize:12];
    }
    return _finalMoney;
}
- (UILabel *)finalMoneyTime {
    if (!_finalMoneyTime) {
        _finalMoneyTime = [[UILabel alloc] init];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSString *nowTime = [format stringFromDate:date];
        
        _finalMoneyTime.text = nowTime;
        _finalMoneyTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _finalMoneyTime.font = [UIFont systemFontOfSize:12];
    }
    return _finalMoneyTime;
}
- (UILabel *)send {
    if (!_send) {
        _send = [[UILabel alloc] init];
        
        _send.text = @"发货时间:";
        _send.textColor = [UIColor colorWithHexString:@"#666666"];
        _send.font = [UIFont systemFontOfSize:12];
    }
    return _send;
}
- (UILabel *)sendTime {
    if (!_sendTime) {
        _sendTime = [[UILabel alloc] init];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSString *nowTime = [format stringFromDate:date];
        
        _sendTime.text = nowTime;
        _sendTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _sendTime.font = [UIFont systemFontOfSize:12];
    }
    return _sendTime;
}
- (UIButton *)copBtn {
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
- (void)clickCopyBtnAction {
    if (_copyBlock) {
        _copyBlock();
    }
}
@end
