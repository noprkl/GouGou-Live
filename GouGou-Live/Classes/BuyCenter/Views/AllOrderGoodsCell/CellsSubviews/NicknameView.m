//
//  NicknameView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NicknameView.h"

@interface NicknameView ()
///** 间隔 */
//@property (strong,nonatomic) UIView *spaceView;
///** 买家 */
//@property (strong,nonatomic) UIImageView *sellerIamge;
///** 昵称 */
//@property (strong,nonatomic) UILabel *nickName;
///** 剩余时间 */
//@property (strong,nonatomic) UILabel *remainTimeLabel;
///** 状态 */
//@property (strong,nonatomic) UILabel *stateLabe;

@end

@implementation NicknameView
// 状态设置
- (void)setStateMessage:(NSString *)stateMessage {
    
    _stateMessage = stateMessage;
    self.stateLabe.text = stateMessage;
}
/*
// 商家名称设置
- (void)setMerchantName:(NSString *)merchantName {

    _merchantName = merchantName;
    self.nickName.text = merchantName;
}
// 商家图片
- (void)setMerchantImagl:(NSString *)merchantImagl {
    
    _merchantImagl = merchantImagl;
    self.sellerIamge.image = [UIImage imageNamed:merchantImagl];
}
 */
/*
 //模型信息
- (void)setModel:(NickNameModel *)model {
    
    _model = model;
    self.nickName.text = _model.merchantName;
    self.stateLabe.text = _model.status;
    self.sellerIamge.image = [UIImage imageNamed:self.model.merchantImgl];
    
    DLog(@"%@",self.nickName.text);
    DLog(@"%@",self.stateLabe.text);
//    DLog(@"%@",self.freightMoney.text);

}
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {

        [self addSubview:self.spaceView];
        [self addSubview:self.sellerIamge];
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
    
    [_sellerIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.centerY.equalTo(weakself.centerY).offset(10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.sellerIamge.right).offset(10);
        make.centerY.equalTo(weakself.centerY).offset(10);
        make.width.equalTo(50);
    }];
    
    [_stateLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.right).offset(-10);
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

- (UIImageView *)sellerIamge {

    if (!_sellerIamge) {
        _sellerIamge = [[UIImageView alloc] init];
        _sellerIamge.layer.masksToBounds = YES;
        _sellerIamge.layer.cornerRadius = 15;
    }
    return _sellerIamge;
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
