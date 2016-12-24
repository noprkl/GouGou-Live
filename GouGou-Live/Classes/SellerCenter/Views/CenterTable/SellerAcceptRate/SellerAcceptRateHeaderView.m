//
//  SellerAcceptRateHeaderView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAcceptRateHeaderView.h"
#import "StartSourceView.h"

@interface SellerAcceptRateHeaderView ()

@property(nonatomic, strong) UIImageView *sellerIconView; /**< 商家头像 */

@property(nonatomic, strong) UILabel *sellerNameLabel; /**< 商家名字 */

@property(nonatomic, strong) UILabel *certifLabel; /**< 实名认证 */

@property(nonatomic, strong) UILabel *sellCertifLabel; /**< 商家认证 */

@property(nonatomic, strong) UILabel *fansLabel; /**< 粉丝 */

@property(nonatomic, strong) UILabel *fansCountLabel; /**< 粉丝人数 */

@property(nonatomic, strong) UILabel *rateLabel; /**< 评价 */

@property(nonatomic, strong) UILabel *rateCountLabel; /**< 评价人数 */

@property(nonatomic, strong) UILabel *pleaseLabel; /**< 消费者满意度 */

@property(nonatomic, strong) StartSourceView *startView; /**< 星星 */

@end
@implementation SellerAcceptRateHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sellerIconView];
        [self addSubview:self.sellerNameLabel];

        [self addSubview:self.certifLabel];
        [self addSubview:self.sellCertifLabel];

        [self addSubview:self.fansLabel];
        [self addSubview:self.fansCountLabel];
        [self addSubview:self.rateLabel];
        [self addSubview:self.rateCountLabel];
        [self addSubview:self.pleaseLabel];
        [self addSubview:self.startView];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.sellerIconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [self.sellerNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    [self.certifLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellerNameLabel.centerY);
        make.left.equalTo(self.sellerNameLabel.right).offset(10);
        make.size.equalTo(CGSizeMake(60, 15));

    }];
    
    [self.sellCertifLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellerNameLabel.centerY);
        make.left.equalTo(self.certifLabel.right).offset(10);
        make.size.equalTo(CGSizeMake(60, 15));
    }];
    
    [self.fansLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sellerNameLabel.bottom).offset(10);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    
    [self.fansCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fansLabel.centerY);
        make.left.equalTo(self.fansLabel.right).offset(3);
    }];
    
    [self.rateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fansLabel.centerY);
        make.left.equalTo(self.fansCountLabel.right).offset(10);
    }];
    [self.rateCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fansLabel.centerY);
        make.left.equalTo(self.rateLabel.right).offset(3);
    }];

    [self.pleaseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fansLabel.bottom).offset(10);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    [self.startView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pleaseLabel.centerY);
        make.left.equalTo(self.pleaseLabel.right).offset(10);
        make.size.equalTo(CGSizeMake(100, 15));
    }];
    self.fansCountLabel.text = [@([UserInfos sharedUser].fansCount) stringValue];
    self.rateCountLabel.text = [@([UserInfos sharedUser].commentCount) stringValue];
    
    if ([UserInfos sharedUser].userimgurl.length > 0) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:[UserInfos sharedUser].userimgurl];
        
        [self.sellerIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
    self.startView.startCount = _pleasureCount;
    self.sellerNameLabel.text = [UserInfos sharedUser].username;
    self.fansCountLabel.text = [@([UserInfos sharedUser].fansCount) stringValue];
    self.rateCountLabel.text = [@([UserInfos sharedUser].commentCount) stringValue];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)sellerIconView {
    if (!_sellerIconView) {
        _sellerIconView = [[UIImageView alloc] init];
        _sellerIconView.image = [UIImage imageNamed:@"头像"];

        // 切圆
        _sellerIconView.layer.cornerRadius = 30;
        _sellerIconView.layer.masksToBounds = YES;
        // 加边框
        _sellerIconView.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _sellerIconView.layer.borderWidth = 1;
    }
    return _sellerIconView;
}
- (UILabel *)sellerNameLabel {
    if (!_sellerNameLabel) {
        _sellerNameLabel = [[UILabel alloc] init];
        _sellerNameLabel.text = @"陈家狗狗培育中心";
        _sellerNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _sellerNameLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _sellerNameLabel;
}
- (UILabel *)certifLabel {
    if (!_certifLabel) {
        _certifLabel = [[UILabel alloc] init];
        _certifLabel.text = @"实名认证";
        _certifLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _certifLabel.font = [UIFont systemFontOfSize:10];
        _certifLabel.backgroundColor = [UIColor colorWithHexString:@"ffa11a"];
        _certifLabel.textAlignment = NSTextAlignmentCenter;
        _certifLabel.layer.cornerRadius = 7.5;
        _certifLabel.layer.masksToBounds = YES;
    }
    return _certifLabel;
}
- (UILabel *)sellCertifLabel {
    if (!_sellCertifLabel) {
        _sellCertifLabel = [[UILabel alloc] init];
        _sellCertifLabel.text = @"商家认证";
        _sellCertifLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _sellCertifLabel.font = [UIFont systemFontOfSize:10];
        _sellCertifLabel.backgroundColor = [UIColor colorWithHexString:@"ffa11a"];
        _sellCertifLabel.textAlignment = NSTextAlignmentCenter;
        
        _sellCertifLabel.layer.cornerRadius = 7.5;
        _sellCertifLabel.layer.masksToBounds = YES;
    }
    return _sellCertifLabel;
}
- (UILabel *)fansLabel {
    if (!_fansLabel) {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.text = @"粉丝";
        _fansLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fansLabel.font = [UIFont systemFontOfSize:12];
    }
    return _fansLabel;
}
- (UILabel *)fansCountLabel {
    if (!_fansCountLabel) {
        _fansCountLabel = [[UILabel alloc] init];
        _fansCountLabel.text = @"1000";
        _fansCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fansCountLabel.font = [UIFont systemFontOfSize:12];
    }
    return _fansCountLabel;
}
- (UILabel *)rateLabel {
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.text = @"评价";
        _rateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _rateLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _rateLabel;
}
- (UILabel *)rateCountLabel {
    if (!_rateCountLabel) {
        _rateCountLabel = [[UILabel alloc] init];
        _rateCountLabel.text = @"80";
        _rateCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _rateCountLabel.font = [UIFont systemFontOfSize:12];
    }
    return _rateCountLabel;
}

- (UILabel *)pleaseLabel {
    if (!_pleaseLabel) {
        _pleaseLabel = [[UILabel alloc] init];
        _pleaseLabel.text = @"消费者满意度";
        _pleaseLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _pleaseLabel.font = [UIFont systemFontOfSize:12];
    }
    return _pleaseLabel;
}
- (StartSourceView *)startView {
    if (!_startView) {
        _startView = [[StartSourceView alloc] init];
        _startView.startCount = 4;
        _startView.backgroundColor = [UIColor whiteColor];
    }
    return _startView;
}
@end
