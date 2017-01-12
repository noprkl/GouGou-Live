//
//  SellinfoView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellinfoView.h"

@interface SellinfoView ()
/** 用户图片 */
@property (strong,nonatomic) UIImageView *userImage;
/** 商家名称 */
@property (strong,nonatomic) UILabel *MedrchantName;
/** 认证商家 */
@property (strong,nonatomic) UILabel *certityLabel;
/** 时间 */
@property (strong,nonatomic) UILabel *timeLabel;
/** 箭头 */
@property (strong,nonatomic) UIImageView *arrowImage;

@end

@implementation SellinfoView

- (void)setCurrentTime:(NSString *)currentTime {

    _currentTime = currentTime;
    self.timeLabel.text = currentTime;
}

- (void)setBuynessName:(NSString *)buynessName {
    _buynessName = buynessName;
    self.MedrchantName.text = buynessName;
}
- (void)setBuynessImg:(NSString *)buynessImg {
    _buynessImg = buynessImg;
    
//    self.userImage = buynessImg;
    if (buynessImg.length != 0) {
        NSString *str = [IMAGE_HOST stringByAppendingString:buynessImg];
        NSURL *url = [NSURL URLWithString:str];
        [self.userImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"主播头像"]];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.userImage];
        [self addSubview:self.MedrchantName];
        [self addSubview:self.certityLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.arrowImage];
        
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.centerY.equalTo(weakself.centerY);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [_MedrchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.userImage.right).offset(10);
        make.centerY.equalTo(weakself.centerY);
        make.width.equalTo(70);
    }];
    
    [_certityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.MedrchantName.right);
        make.centerY.equalTo(weakself.centerY);
        make.size.equalTo(CGSizeMake(75, 25));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-30);
        make.centerY.equalTo(weakself.centerY);
    }];
    
    [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
}
#pragma mark
#pragma mark - 懒加载
-(UIImageView *)userImage {

    if (!_userImage) {
        _userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主播头像"]];
    }
    return _userImage;
}

- (UILabel *)MedrchantName {

    if (!_MedrchantName) {
        _MedrchantName = [[UILabel alloc] init];
        _MedrchantName.text = @"陈家狗狗培育中心";
        _MedrchantName.textColor = [UIColor colorWithHexString:@"#000000"];
        _MedrchantName.font = [UIFont systemFontOfSize:14];
    }
    return _MedrchantName;
}

- (UILabel *)certityLabel {

    if (!_certityLabel) {
        _certityLabel = [[UILabel alloc] init];
        _certityLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _certityLabel.text = @"认证商家";
        _certityLabel.font = [UIFont systemFontOfSize:14];
        _certityLabel.backgroundColor = [UIColor colorWithHexString:@"#ffa11a"];
        _certityLabel.layer.cornerRadius = 5;
        _certityLabel.layer.masksToBounds = YES;
        _certityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _certityLabel;
}

- (UILabel *)timeLabel {

    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _timeLabel.text = @"2016-8-30 7:00";
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIImageView *)arrowImage {

    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"返回-（小）"]];
    }
    return _arrowImage;
}

@end
