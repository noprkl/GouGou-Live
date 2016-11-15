//
//  SellerMyLiveCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerMyLiveCell.h"

@interface SellerMyLiveCell ()

/** 头像 */
@property (strong,nonatomic) UIImageView *photoImage;
/** 商家名称 */
@property (strong,nonatomic) UILabel *businessName;
/** 认证商家 */
@property (strong,nonatomic) UILabel *certifiedBusiness;
/** 狗狗截图 */
@property (strong,nonatomic) UIImageView *dogImage;
/** 结束文字 */
@property (strong,nonatomic) UILabel *overLabel;
/** 狗狗信息蒙版 */
@property (strong,nonatomic) UIView *hudView;
/** 狗狗介绍 */
@property (strong,nonatomic) UILabel *descLabel;
/** 销售情况 */
@property (strong,nonatomic) UILabel *sellLabel;

@property(nonatomic, strong) UILabel *showLabel; /**< 展示情况 */

/** 日期时间 */
@property (strong,nonatomic) UILabel *dataLabel;
/** 间隔 */
@property (strong,nonatomic) UIView *spaceView;

@end

@implementation SellerMyLiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.photoImage];
        [self.contentView addSubview:self.businessName];
        [self.contentView addSubview:self.certifiedBusiness];
        [self.contentView addSubview:self.dogImage];
        [self.contentView addSubview:self.overLabel];
        [self.contentView addSubview:self.hudView];
        
        [self.hudView addSubview:self.descLabel];
        [self.hudView addSubview:self.sellLabel];
        [self.hudView addSubview:self.showLabel];
        
        [self.contentView addSubview:self.dataLabel];
        [self.contentView addSubview:self.spaceView];
        
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(7);
        
    }];
    
    [_businessName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.photoImage.right).offset(10);
        make.centerY.equalTo(weakself.photoImage.centerY);
        
    }];
    
    [_certifiedBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.businessName.right).offset(10);
        make.centerY.equalTo(weakself.photoImage.centerY);
        make.size.equalTo(CGSizeMake(70, 22));
        
    }];
    [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.photoImage.centerY);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    [_dogImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.top).offset(44);
        make.left.equalTo(weakself.left);
        make.height.equalTo(175);
    }];
    
    [_overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(54);
        make.left.equalTo(weakself.left).offset(290);
        make.size.equalTo(CGSizeMake(70, 20));
        
    }];
    
    [_hudView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself);
        make.top.equalTo(weakself.top).offset(186);
        make.height.equalTo(33);
        
    }];
    
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.hudView.left).offset(10);
        make.centerY.equalTo(weakself.hudView.centerY);
    }];
    
    [_sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.hudView.centerY);
    }];
    
    [_showLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.sellLabel.centerY);
        make.right.equalTo(weakself.sellLabel.left).offset(-5);
    }];
    
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakself);
        make.top.equalTo(weakself.hudView.bottom);
        make.height.equalTo(10);
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (UIImageView *)photoImage {
    
    if (!_photoImage) {
        _photoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"主播头像"]];
        _photoImage.layer.cornerRadius = 16;
        _photoImage.layer.masksToBounds = YES;
        
    }
    return _photoImage;
}

- (UILabel *)businessName {
    
    if (!_businessName) {
        _businessName = [[UILabel alloc] init];
        _businessName.text = @"陈家狗狗培育中心";
        _businessName.textColor = [UIColor colorWithHexString:@"#000000"];
        _businessName.font = [UIFont systemFontOfSize:14];
    }
    return _businessName;
}

- (UILabel *)certifiedBusiness {
    
    if (!_certifiedBusiness) {
        _certifiedBusiness = [[UILabel alloc] init];
        _certifiedBusiness.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _certifiedBusiness.text = @"认证商家";
        _certifiedBusiness.layer.cornerRadius = 5;
        _certifiedBusiness.layer.masksToBounds = YES;
        _certifiedBusiness.textAlignment = NSTextAlignmentCenter;
        _certifiedBusiness.backgroundColor = [UIColor orangeColor];
        _certifiedBusiness.font = [UIFont systemFontOfSize:14];
    }
    return _certifiedBusiness;
}

- (UIImageView *)dogImage {
    
    _dogImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"直播图"]];
    
    return _dogImage;
}

- (UIView *)hudView {
    
    if (!_hudView) {
        _hudView = [[UIView alloc] init];
        _hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
    }
    return _hudView;
}

-(UILabel *)overLabel {
    
    if (!_overLabel) {
        _overLabel = [[UILabel alloc] init];
        _overLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _overLabel.layer.cornerRadius = 5;
        _overLabel.layer.masksToBounds = YES;
        _overLabel.text = @"已结束";
        _overLabel.textAlignment = NSTextAlignmentCenter;
        _overLabel.textColor  = [UIColor colorWithHexString:@"#ffffff"];
        _overLabel.font = [UIFont systemFontOfSize:12];
    }
    return _overLabel;
}
- (UILabel *)descLabel {
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"一窝纯种拉布拉多出售";
        _descLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _descLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descLabel;
}
- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _showLabel.text = @"展播8";
        _showLabel.font = [UIFont systemFontOfSize:12];
    }
    return _showLabel;
}
- (UILabel *)sellLabel {
    
    if (!_sellLabel) {
        _sellLabel = [[UILabel alloc] init];
        _sellLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _sellLabel.text = @"出售6";
        _sellLabel.font = [UIFont systemFontOfSize:12];
    }
    return _sellLabel;
}

- (UILabel *)dataLabel {
    
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        
        _dataLabel.text = [format stringFromDate:date];
        
        _dataLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dataLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dataLabel;
}

- (UIView *)spaceView {
    
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _spaceView;
}

- (void)deleteButton:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    } else {
        btn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
