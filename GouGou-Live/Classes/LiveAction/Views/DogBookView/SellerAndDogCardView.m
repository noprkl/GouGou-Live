//
//  SellerAndDogCardView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAndDogCardView.h"

@interface SellerAndDogCardView ()

@property(nonatomic, strong) UIImageView *sellerIconView; /**< 主播头像 */

@property(nonatomic, strong) UILabel *sellerName; /**< 主播名字 */

@property(nonatomic, strong) UILabel *sellerCertificateLabel; /**< 认证商家 */
@property(nonatomic, strong) UILabel *dateLabel; /**< 时间戳 */

@property (strong, nonatomic)  UIImageView *dogImageView;/**< 狗狗图片*/

@property (strong, nonatomic)  UILabel *dogNameLabel;/**< 狗狗名字 */

@property(nonatomic, strong) UILabel *kindLabel; /**< 品种 */

@property (strong, nonatomic)  UILabel *dogKindLabel;/**< 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogAgeLabel;/**< 狗狗年龄*/

@property (strong, nonatomic)  UILabel *dogSizeLabel;/**< 狗狗体型*/

@property (strong, nonatomic)  UILabel *dogColorLabel;/**< 狗狗颜色*/

@property (strong, nonatomic)  UILabel *nowPriceLabel;/**< 狗狗价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;/**< 狗狗老价格*/

@end
@implementation SellerAndDogCardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.sellerIconView];
        [self addSubview:self.sellerName];
        [self addSubview:self.sellerCertificateLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.dogImageView];
        [self addSubview:self.dogNameLabel];
        [self addSubview:self.kindLabel];
        [self addSubview:self.dogKindLabel];
        [self addSubview:self.dogAgeLabel];
        [self addSubview:self.dogSizeLabel];
        [self addSubview:self.dogColorLabel];
        [self addSubview:self.nowPriceLabel];
        [self addSubview:self.oldPriceLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
    [self.sellerIconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.sellerName makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellerIconView.centerY);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    [self.sellerCertificateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellerIconView.centerY);
        make.left.equalTo(self.sellerName.right).offset(10);
    }];
    
    [self.dateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellerIconView.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.sellerIconView.bottom).offset(10);

    }];
    [self.dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogImageView.top);
        make.left.equalTo(self.dogImageView.right).offset(20);
    }];
    [self.kindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dogNameLabel.bottom);
        make.left.equalTo(self.dogNameLabel.right).offset(10);
    }];
    
    [self.dogKindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dogNameLabel.bottom);
        make.left.equalTo(self.kindLabel.right).offset(10);
    }];
    
    [self.dogAgeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogNameLabel.bottom).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(20);
    }];
    [self.dogSizeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogAgeLabel.centerY);
        make.left.equalTo(self.dogAgeLabel.right).offset(10);
    }];
    [self.dogColorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogAgeLabel.centerY);
        make.left.equalTo(self.dogSizeLabel.right).offset(10);
    }];
    [self.nowPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogAgeLabel.bottom).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(20);
    }];
    [self.oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nowPriceLabel.bottom).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(20);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)sellerIconView {
    if (!_sellerIconView) {
        _sellerIconView = [[UIImageView alloc] init];
        _sellerIconView.image = [UIImage imageNamed:@"主播头像"];
    }
    return _sellerIconView;
}
- (UILabel *)sellerName {
    if (!_sellerName) {
        _sellerName = [[UILabel alloc] init];
        _sellerName.text = @"哦呵呵";
        _sellerName.textColor = [UIColor colorWithHexString:@"#666666"];
        _sellerName.font = [UIFont systemFontOfSize:14];
    }
    return _sellerName;
}
- (UILabel *)sellerCertificateLabel {
    if (!_sellerCertificateLabel) {
        _sellerCertificateLabel = [[UILabel alloc] init];
        _sellerCertificateLabel.text = @"认证商家";
        _sellerCertificateLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _sellerCertificateLabel.font = [UIFont systemFontOfSize:14];
        _sellerCertificateLabel.backgroundColor = [UIColor orangeColor];
        _sellerCertificateLabel.layer.cornerRadius = 5;
        _sellerCertificateLabel.layer.masksToBounds = YES;
    }
    return _sellerCertificateLabel;
}
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm";
        _dateLabel.text = [format stringFromDate:date];
        
        _dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dateLabel;
}
- (UIImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[UIImageView alloc] init];
        _dogImageView.image = [UIImage imageNamed:@"组-7"];
        _dogImageView.layer.cornerRadius = 5;
        _dogImageView.layer.masksToBounds = YES;
    }
    return _dogImageView;
}
- (UILabel *)dogNameLabel {
    if (!_dogNameLabel) {
        _dogNameLabel = [[UILabel alloc] init];
        
        _dogNameLabel.text = @"豆豆";
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _dogNameLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _dogNameLabel;
}
- (UILabel *)kindLabel {
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        
        _kindLabel.text = @"品种";
        _kindLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _kindLabel.font = [UIFont systemFontOfSize:12];
    }
    return _kindLabel;
}
- (UILabel *)dogKindLabel {
    if (!_dogKindLabel) {
        _dogKindLabel = [[UILabel alloc] init];
        
        _dogKindLabel.text = @"拉布拉多";
        _dogKindLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogKindLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _dogKindLabel;
}
- (UILabel *)dogAgeLabel {
    if (!_dogAgeLabel) {
        _dogAgeLabel = [[UILabel alloc] init];
        
        _dogAgeLabel.text = @"6个月";
        _dogAgeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogAgeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogAgeLabel;
}
- (UILabel *)dogSizeLabel {
    if (!_dogSizeLabel) {
        _dogSizeLabel = [[UILabel alloc] init];
        
        _dogSizeLabel.text = @"大型犬";
        _dogSizeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogSizeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogSizeLabel;
}
- (UILabel *)dogColorLabel {
    if (!_dogColorLabel) {
        _dogColorLabel = [[UILabel alloc] init];
        
        _dogColorLabel.text = @"白色";
        _dogColorLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogColorLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogColorLabel;
}
- (UILabel *)nowPriceLabel {
    if (!_nowPriceLabel) {
        _nowPriceLabel = [[UILabel alloc] init];
        
        _nowPriceLabel.text = @"¥ 1400";
        _nowPriceLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _nowPriceLabel.font = [UIFont systemFontOfSize:18];
    }
    return _nowPriceLabel;
}
- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc] init];
        
        _oldPriceLabel.text = @"¥ 2400";
        _oldPriceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _oldPriceLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _oldPriceLabel;
}

@end
