//
//  ChosedAdressView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ChosedAdressView.h"
#import "MyShopAdressModel.h"
#import "SellerAdressModel.h"

@interface ChosedAdressView ()

@property(nonatomic, strong) UIImageView *markImageView; /**< 定位 */

@property(nonatomic, strong) UILabel *ownerLabel; /**< 联系人 */

@property(nonatomic, strong) UILabel *ownerNameLaben; /**< 姓名 */

@property(nonatomic, strong) UILabel *phoneLabel; /**< 电话 */

@property(nonatomic, strong) UILabel *adressLabel; /**< 地址 */

@property(nonatomic, strong) UILabel *adressDesclabel; /**< 详细地址 */

@property(nonatomic, strong) UIImageView *smallImageView; /**< 箭头 */

@end

@implementation ChosedAdressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.markImageView];
        [self addSubview:self.ownerLabel];
        [self addSubview:self.ownerNameLaben];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.adressLabel];
        [self addSubview:self.adressDesclabel];
        [self addSubview:self.smallImageView];
    }
    return self;
}
- (void)setShopAdress:(MyShopAdressModel *)shopAdress {
    _shopAdress = shopAdress;
    self.ownerNameLaben.text = shopAdress.userName;
    self.phoneLabel.text = shopAdress.userTel;
    self.adressDesclabel.text = [NSString stringWithFormat:@"%@%@%@%@", shopAdress.userProvince, shopAdress.userCity, shopAdress.userDistrict, shopAdress.userAddress];
    if (shopAdress.isDefault) {
        self.adressLabel.text = @"默认地址:";
        self.adressLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }else{
        self.adressLabel.text = @"地址:";
        self.adressLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    
}
- (void)setSellerAdress:(SellerAdressModel *)sellerAdress {
    _sellerAdress = sellerAdress;
  
    self.ownerNameLaben.text = sellerAdress.merchantName;
    self.phoneLabel.text = sellerAdress.merchantTel;
    self.adressDesclabel.text = [NSString stringWithFormat:@"%@%@%@%@", sellerAdress.merchantProvince, sellerAdress.merchantCity, sellerAdress.merchantDistrict, sellerAdress.merchantAddress];
    if (sellerAdress.isDefault) {
        self.adressLabel.text = @"默认地址:";
        self.adressLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }else{
        self.adressLabel.text = @"地址:";
        self.adressLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }

}
- (void)setIsHid:(BOOL)isHid {
    _isHid = isHid;
    self.smallImageView.hidden = isHid;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.markImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(10, 10));
    }];
    
    [self.ownerLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.markImageView.right).offset(5);
        make.bottom.bottom.equalTo(self.markImageView.top);
    }];
    [self.ownerNameLaben makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ownerLabel.centerY);
        make.left.equalTo(self.ownerLabel.right);
    }];
    [self.phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ownerLabel.centerY);
        make.right.equalTo(self.right).offset(-30);
    }];
    [self.adressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.markImageView.bottom);
        make.left.equalTo(self.markImageView.right).offset(5);
        make.width.equalTo(60);
    }];
    [self.adressDesclabel makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.markImageView.bottom).offset(3);
        make.left.equalTo(self.adressLabel.right);
        make.centerY.equalTo(self.adressLabel.centerY);
        make.right.equalTo(self.right).offset(-40);
    }];
    [self.smallImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.right).offset(-10);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)smallImageView {
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] init];
        _smallImageView.image = [UIImage imageNamed:@"返回-（小）"];
    }
    return _smallImageView;
}
- (UILabel *)adressDesclabel {
    if (!_adressDesclabel) {
        _adressDesclabel = [[UILabel alloc] init];
        _adressDesclabel.text = @"北京市海淀区五道口加速器慧摩尔";
        _adressDesclabel.numberOfLines = 0;
        _adressDesclabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _adressDesclabel.font = [UIFont systemFontOfSize:13];

    }
    return _adressDesclabel;
}
- (UILabel *)adressLabel {
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc] init];
        _adressLabel.text = @"地址：";
        _adressLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _adressLabel.font = [UIFont systemFontOfSize:13];
        _adressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _adressLabel;
}
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = @"18487264628";
        _phoneLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _phoneLabel.font = [UIFont systemFontOfSize:12];
    }
    return _phoneLabel;
}
- (UILabel *)ownerNameLaben {
    if (!_ownerNameLaben) {
        _ownerNameLaben = [[UILabel alloc] init];
        _ownerNameLaben.text = @"慧摩尔";
        _ownerNameLaben.textColor = [UIColor colorWithHexString:@"#666666"];
        _ownerNameLaben.font = [UIFont systemFontOfSize:13];
    }
    return _ownerNameLaben;
}
- (UILabel *)ownerLabel {
    if (!_ownerLabel) {
        _ownerLabel = [[UILabel alloc] init];
        _ownerLabel.text = @"联系人：";
        _ownerLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _ownerLabel.font = [UIFont systemFontOfSize:14];
    }
    return _ownerLabel;
}
- (UIImageView *)markImageView {
    if (!_markImageView) {
        _markImageView = [[UIImageView alloc] init];
        _markImageView.image = [UIImage imageNamed:@"定位"];
    }
    return _markImageView;
}


@end
