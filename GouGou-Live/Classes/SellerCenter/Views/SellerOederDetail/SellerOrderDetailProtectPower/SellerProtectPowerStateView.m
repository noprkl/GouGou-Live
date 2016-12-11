//
//  SellerProtectPowerStateView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerProtectPowerStateView.h"

@interface SellerProtectPowerStateView ()
@property(nonatomic, strong) UILabel *stateLabel; /**< 订单状态 */

@property(nonatomic, strong) UILabel *noteLabel; /**< 提示文字 */

@end
@implementation SellerProtectPowerStateView

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
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
}
#pragma mark - 设置
- (void)setStateMessage:(NSString *)stateMessage {
    _stateMessage = stateMessage;
    self.stateLabel.text = stateMessage;
}
- (void)setNoteStr:(NSString *)noteStr {
    _noteStr = noteStr;
    self.noteLabel.text = noteStr;
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"维权中";
        
        _stateLabel.layer.cornerRadius = 5;
        _stateLabel.layer.masksToBounds = YES;
        _stateLabel.backgroundColor = [UIColor colorWithHexString:@"#ffa11a"];
        _stateLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _stateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _stateLabel;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"买家于2016-10-11 19:10:10收货,未评价";
        _noteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noteLabel.font = [UIFont systemFontOfSize:12];
    }
    return _noteLabel;
}
@end
