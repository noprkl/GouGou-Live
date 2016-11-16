//
//  SellerNickNameView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerNickNameView.h"

@interface SellerNickNameView ()

/** 买家 */
@property (strong,nonatomic) UILabel *buyLabel;
/** 昵称 */
@property (strong,nonatomic) UILabel *nickName;
/** 状态 */
@property (strong,nonatomic) UILabel *stateLabe;

@property(nonatomic, strong) UILabel *dateLabel; /**< 时间 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@end

@implementation SellerNickNameView

- (void)setStateMessage:(NSString *)stateMessage {
    
    _stateMessage = stateMessage;
    self.stateLabe.text = stateMessage;
}
- (void)setDateIsHid:(BOOL)dateIsHid {
    _dateIsHid = dateIsHid;
    self.dateLabel.hidden = dateIsHid;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.buyLabel];
        [self addSubview:self.nickName];
        [self addSubview:self.dateLabel];
        [self addSubview:self.stateLabe];
        [self addSubview:self.line];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    __weak typeof(self) weakself = self;
    
    [_buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.centerY.equalTo(weakself.centerY);
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.buyLabel.right).offset(10);
        make.centerY.equalTo(weakself.centerY);
    }];
    
    [_stateLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);
        make.size.equalTo(CGSizeMake(70, 20));
    }];
    
    [_dateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.stateLabe.left).offset(-10);
        make.centerY.equalTo(weakself.centerY);
    }];
    
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.bottom);
        make.left.width.equalTo(weakself);
        make.height.equalTo(1);
    }];
}
#pragma mark
#pragma mark - 懒加载

- (UILabel *)buyLabel {
    
    if (!_buyLabel) {
        _buyLabel = [[UILabel alloc] init];
        _buyLabel.text = @"买家:";
        _buyLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _buyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _buyLabel;
}

- (UILabel *)nickName {
    
    if (!_nickName) {
        _nickName = [[UILabel alloc] init];
        _nickName.text = @"慧摩尔";
        _nickName.textColor = [UIColor colorWithHexString:@"#000000"];
        _nickName.font = [UIFont systemFontOfSize:16];
    }
    return _nickName;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"HH时mm分ss秒";
        
        _dateLabel.text = [format stringFromDate:date];
        _dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dateLabel;
}
- (UILabel *)stateLabe {
    
    if (!_stateLabe) {
        _stateLabe = [[UILabel alloc] init];
        _stateLabe.text = @"已完成";
        _stateLabe.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _stateLabe.font = [UIFont systemFontOfSize:14];
        _stateLabe.backgroundColor = [UIColor colorWithHexString:@"#ffa11a"];
        _stateLabe.layer.cornerRadius = 5;
        _stateLabe.layer.masksToBounds = YES;
        _stateLabe.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabe;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}

@end
