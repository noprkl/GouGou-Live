//
//  LivingShowDogCell.m
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LivingShowDogCell.h"

@interface LivingShowDogCell ()

/** 狗狗图片*/
@property (strong, nonatomic)  UIImageView *dogImageView;
/** 狗狗名字 */
@property (strong, nonatomic)  UILabel *dogNameLabel;
/** 品种 */
@property(nonatomic, strong) UILabel *kindLabel;
/** 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogKindLabel;
/** 狗狗年龄*/
@property (strong, nonatomic)  UILabel *dogAgeLabel;
/** 狗狗体型*/
@property (strong, nonatomic)  UILabel *dogSizeLabel;
/** 狗狗颜色*/
@property (strong, nonatomic)  UILabel *dogColorLabel;
/** 狗狗价格*/
@property (strong, nonatomic)  UILabel *nowPriceLabel;
/** 狗狗老价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;

@end

@implementation LivingShowDogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.dogImageView];
        [self.contentView addSubview:self.dogNameLabel];
        [self.contentView addSubview:self.kindLabel];
        [self.contentView addSubview:self.dogKindLabel];
        [self.contentView addSubview:self.dogAgeLabel];
        [self.contentView addSubview:self.dogSizeLabel];
        [self.contentView addSubview:self.dogColorLabel];
        [self.contentView addSubview:self.nowPriceLabel];
        [self.contentView addSubview:self.oldPriceLabel];
    }
    return self;
}
- (void)setModel:(DogDetailInfoModel *)model {
    _model = model;
    NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathSmall];
    [self.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    self.dogNameLabel.text = model.name;
    self.dogKindLabel.text = model.kindName;
    self.dogAgeLabel.text = model.ageName;
    self.dogSizeLabel.text = model.sizeName;
    self.dogColorLabel.text = model.colorName;
    self.oldPriceLabel.text = model.priceOld;
    self.nowPriceLabel.text = model.price;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.centerY).offset(-5);
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        make.height.equalTo(_dogImageView.width);
    }];
    [_dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.dogImageView.right).offset(10);
    }];
    [_kindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.dogNameLabel.bottom);
        make.left.equalTo(weakself.dogNameLabel.right).offset(10);
    }];
    
    [_dogKindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.dogNameLabel.bottom);
        make.left.equalTo(weakself.kindLabel.right).offset(10);
    }];
    
    [_dogAgeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.dogNameLabel.bottom).offset(5);
        make.left.equalTo(weakself.dogImageView.right).offset(10);
    }];
    [_dogSizeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.dogAgeLabel.centerY);
        make.left.equalTo(weakself.dogAgeLabel.right).offset(10);
    }];
    [_dogColorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.dogAgeLabel.centerY);
        make.left.equalTo(weakself.dogSizeLabel.right).offset(10);
    }];
    [_nowPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.dogAgeLabel.bottom).offset(5);
        make.left.equalTo(weakself.dogImageView.right).offset(10);
    }];
    [_oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.nowPriceLabel.bottom).offset(5);
        make.left.equalTo(weakself.nowPriceLabel.right).offset(10);
    }];
}

#pragma mark
#pragma mark - 懒加载
- (UIImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[UIImageView alloc] init];
        _dogImageView.image = [UIImage imageNamed:@"组-7"];
        _dogImageView.layer.cornerRadius = 10;
        _dogImageView.layer.masksToBounds = YES;
    }
    return _dogImageView;
}
- (UILabel *)dogNameLabel {
    if (!_dogNameLabel) {
        _dogNameLabel = [[UILabel alloc] init];
        _dogNameLabel.text = @"小黑";
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogNameLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _dogNameLabel;
}
- (UILabel *)kindLabel {
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        
        _kindLabel.text = @"品种";
        _kindLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _kindLabel.font = [UIFont systemFontOfSize:12];
    }
    return _kindLabel;
}
- (UILabel *)dogKindLabel {
    if (!_dogKindLabel) {
        _dogKindLabel = [[UILabel alloc] init];
        
        _dogKindLabel.text = @"拉布拉多";
        _dogKindLabel.textColor = [UIColor colorWithHexString:@"#333333"];
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

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
@end
