//
//  NicknameView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NicknameView.h"

@interface NicknameView ()
/** 间隔 */
@property (strong,nonatomic) UIView *spaceView;
/** 买家 */
@property (strong,nonatomic) UILabel *buyLabel;
/** 昵称 */
@property (strong,nonatomic) UILabel *nickName;
/** 剩余时间 */
@property (strong,nonatomic) UILabel *remainTimeLabel;
/** 状态 */
@property (strong,nonatomic) UILabel *stateLabe;

@end

@implementation NicknameView

- (void)setStateMessage:(NSString *)stateMessage {

    _stateMessage = stateMessage;
    self.stateLabe.text = stateMessage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self addSubview:self.spaceView];
        [self addSubview:self.buyLabel];
        [self addSubview:self.nickName];
        [self addSubview:self.stateLabe];
        [self addSubview:self.remainTimeLabel];
        
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    __weak typeof(self) weakself = self;
    
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(weakself);
        make.height.equalTo(10);
        
    }];
    
    [_buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.centerY.equalTo(weakself.centerY).offset(10);
        
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.buyLabel.right).offset(10);
        make.centerY.equalTo(weakself.centerY).offset(10);
        
    }];
    
    [_stateLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(295);
        make.centerY.equalTo(weakself.centerY).offset(10);
        make.size.equalTo(CGSizeMake(70, 20));
        
    }];
    
    [_remainTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.stateLabe.left).offset(-10);
        make.centerY.equalTo(weakself.stateLabe.centerY);
        
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIView *)spaceView {

    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _spaceView;
}

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
        _nickName.text = @"丁丁";
        _nickName.textColor = [UIColor colorWithHexString:@"#000000"];
        _nickName.font = [UIFont systemFontOfSize:16];
    }
    return _nickName;
}

- (UILabel *)remainTimeLabel {

    if (!_remainTimeLabel) {
        _remainTimeLabel = [[UILabel alloc] init];
        _remainTimeLabel.text = @"剩余1天1小时";
        _remainTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _remainTimeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _remainTimeLabel;
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
@end
