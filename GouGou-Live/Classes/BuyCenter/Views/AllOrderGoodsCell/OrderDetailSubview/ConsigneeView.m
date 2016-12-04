//
//  ConsigneeView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//  联系人信息

#import "ConsigneeView.h"

@interface ConsigneeView  ()
/** 定位图片 */
@property (strong,nonatomic) UIImageView *locationImage;
/** 收货人 */
@property (strong,nonatomic) UILabel *consignee;
/** 用户名 */
@property (strong,nonatomic) UILabel *userName;
/** 电话号码 */
@property (strong,nonatomic) UILabel *phoneNum;
/** 默认 */
@property (strong,nonatomic) UILabel *acquiesceLabel;
/** 详细地址 */
@property (strong,nonatomic) UILabel *detailAddress;
/** 地址 */
@property (strong,nonatomic) UILabel *addressLabel;

@end

@implementation ConsigneeView

- (void)setBuyUserName:(NSString *)buyUserName {

    _buyUserName = buyUserName;
    self.userName.text = buyUserName;
}

- (void)setBuyUserTel:(NSString *)buyUserTel {
    
    _buyUserTel = buyUserTel;
    self.phoneNum.text = buyUserTel;
}

- (void)setRecevieAddress:(NSString *)recevieAddress {

    _recevieAddress = recevieAddress;
    
    recevieAddress = [NSString stringWithFormat:@"%@,%@,%@",self.recevieProvince,self.recevieCity,self.recevieDistrict];
    
    self.addressLabel.text = recevieAddress;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.locationImage];
        [self addSubview:self.consignee];
        [self addSubview:self.userName];
        [self addSubview:self.phoneNum];
        [self addSubview:self.acquiesceLabel];
        [self addSubview:self.detailAddress];
        [self addSubview:self.addressLabel];
        
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.centerY);
        make.left.equalTo(weakself.left).offset(10);
        
    }];
    
    [_consignee mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(20);
        make.left.equalTo(weakself.locationImage.right).offset(10);
    
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.consignee.right).offset(10);
        make.centerY.equalTo(weakself.consignee.centerY);
    }];
    
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakself.consignee.centerY);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    [_acquiesceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.consignee.left);
        make.top.equalTo(weakself.consignee.bottom).offset(20);
        
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.acquiesceLabel.right).offset(10);
        make.centerY.equalTo(weakself.acquiesceLabel.centerY);
        
    }];
    
    [_detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.addressLabel.right).offset(10);
        make.centerY.equalTo(weakself.acquiesceLabel.centerY);
        
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)locationImage {

    if (!_locationImage) {
        _locationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位"]];
    }
    return _locationImage;
}

- (UILabel *)consignee {

    if (!_consignee) {
        _consignee = [[UILabel alloc] init];
        _consignee.text = @"联系人:";
        _consignee.textColor = [UIColor colorWithHexString:@"#333333"];
        _consignee.font = [UIFont systemFontOfSize:16];
    }
    return _consignee;
}

- (UILabel *)userName {

    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.text = @"收货人";
        _userName.textColor = [UIColor colorWithHexString:@"#333333"];
        _userName.font = [UIFont systemFontOfSize:14];

    }
    return _userName;
}

- (UILabel *)phoneNum {
    
    if (!_phoneNum) {
        _phoneNum = [[UILabel alloc] init];
        _phoneNum.text = @"18801613542";
        _phoneNum.textColor = [UIColor colorWithHexString:@"#666666"];
        _phoneNum.font = [UIFont systemFontOfSize:12];
        
    }
    return _phoneNum;
}

- (UILabel *)acquiesceLabel {
    
    if (!_acquiesceLabel) {
        _acquiesceLabel = [[UILabel alloc] init];
        _acquiesceLabel.text = @"默认";
        _acquiesceLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _acquiesceLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _acquiesceLabel;
}

- (UILabel *)addressLabel {
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"地址:";
        _addressLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _addressLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _addressLabel;
}

- (UILabel *)detailAddress {
    
    if (!_detailAddress) {
        _detailAddress = [[UILabel alloc] init];
        _detailAddress.text = @"北京市朝阳区将台道";
        _detailAddress.textColor = [UIColor colorWithHexString:@"#666666"];
        _detailAddress.font = [UIFont systemFontOfSize:14];
        
    }
    return _detailAddress;
}

@end
