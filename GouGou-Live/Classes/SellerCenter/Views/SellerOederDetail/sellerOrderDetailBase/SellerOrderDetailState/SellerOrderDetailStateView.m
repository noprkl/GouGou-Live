//
//  SellerOrderDetailStateView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailStateView.h"

@interface SellerOrderDetailStateView ()

@property(nonatomic, strong) UILabel *stateLabel; /**< 订单状态 */

@property(nonatomic, strong) UILabel *noteLabel; /**< 提示文字 */

@end
@implementation SellerOrderDetailStateView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.stateLabel];
        [self addSubview:self.noteLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
}
#pragma mark
#pragma mark - 设置
- (void)setStateMessage:(NSString *)stateMessage {
    _stateMessage = stateMessage;
    self.stateLabel.text = stateMessage;
}

#pragma mark
#pragma mark - 懒加载
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"待发货";
        _stateLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _stateLabel.font = [UIFont systemFontOfSize:16];
    }
    return _stateLabel;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"买家等了好久了,赶紧发货";
        _noteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noteLabel.font = [UIFont systemFontOfSize:12];
    }
    return _noteLabel;
}
@end
