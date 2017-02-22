//
//  DogCardView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogCardView.h"

@interface DogCardView ()


@property (nonatomic, strong) UIImageView *backImgView; /**< 背景 */

@property (strong, nonatomic)  UIImageView *dogImageView;/**< 狗狗图片*/
@property (strong, nonatomic)  UILabel *dogNameLabel;/**< 狗狗名字 */
@property(nonatomic, strong) UILabel *kindLabel; /**< 品种 */
@property (strong, nonatomic)  UILabel *dogKindLabel;/**< 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogAgeLabel;/**< 狗狗年龄*/

@property (strong, nonatomic)  UILabel *dogSizeLabel;/**< 狗狗体型*/

@property (strong, nonatomic)  UILabel *dogColorLabel;/**< 狗狗颜色*/

@property (strong, nonatomic)  UILabel *nowPriceLabel;/**< 狗狗价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;/**< 狗狗老价格*/

@property (strong, nonatomic)  UILabel *currentIndexLabel;/**< 狗狗当前个数*/


@end

@implementation DogCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImgView];
        [self addSubview:self.dogImageView];
        [self addSubview:self.dogNameLabel];
        [self addSubview:self.kindLabel];
        [self addSubview:self.dogKindLabel];
        [self addSubview:self.dogAgeLabel];
        [self addSubview:self.dogSizeLabel];
        [self addSubview:self.dogColorLabel];
        [self addSubview:self.nowPriceLabel];
        [self addSubview:self.oldPriceLabel];
        [self addSubview:self.currentIndexLabel];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backImgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.backImgView.left).offset(10);
//        make.top.equalTo(self.backImgView.top).offset(10);
        make.size.equalTo(CGSizeMake(90, 90));
    }];
    [self.dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImgView.top).offset(10);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.kindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dogNameLabel.bottom);
        make.left.equalTo(self.dogNameLabel.right).offset(8);
    }];
    
    [self.dogKindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.dogNameLabel.bottom);
        make.left.equalTo(self.kindLabel.right).offset(8);
    }];
    
    [self.dogAgeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogNameLabel.bottom).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(10);
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
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nowPriceLabel.bottom).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.currentIndexLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.oldPriceLabel.centerY);
        make.right.equalTo(self.backImgView.right).offset(-20);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)backImgView {
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"狗狗卡牌背景"]];
    }
    return _backImgView;
}
- (UIImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[UIImageView alloc] init];

//        _dogImageView.layer.cornerRadius = 5;
//        _dogImageView.layer.masksToBounds = YES;
    }
    return _dogImageView;
}
- (UILabel *)dogNameLabel {
    if (!_dogNameLabel) {
        _dogNameLabel = [[UILabel alloc] init];
        
        _dogNameLabel.text = @"豆豆";
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
        _oldPriceLabel.hidden = YES;
        _oldPriceLabel.text = @"¥ 2400";
        _oldPriceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _oldPriceLabel.font = [UIFont systemFontOfSize:12];

    }
    return _oldPriceLabel;
}
- (UILabel *)currentIndexLabel {

    if (!_currentIndexLabel) {
        _currentIndexLabel = [[UILabel alloc] init];
        
        _currentIndexLabel.text = @"1/5";
        _currentIndexLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _currentIndexLabel.font = [UIFont systemFontOfSize:12];
    }
    return _currentIndexLabel;
}

- (void)setDogInfo:(LiveListDogInfoModel *)dogInfo {
    _dogInfo = dogInfo;
    self.dogAgeLabel.text = dogInfo.agename;
    if (dogInfo.pathSmall != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:dogInfo.pathSmall];
        [self.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    
    self.dogNameLabel.text = dogInfo.name;
    self.dogKindLabel.text = dogInfo.kindname;
    self.dogAgeLabel.text = dogInfo.agename;
    self.dogSizeLabel.text = dogInfo.sizename;
    self.dogColorLabel.text = dogInfo.colorname;
    self.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:[NSString stringWithFormat:@"￥%@", dogInfo.priceOld]];
    self.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", dogInfo.price];
    
}
- (void)setMessage:(NSString *)message {
    _message = message;
    self.currentIndexLabel.text = message;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.backImgView.image = [UIImage imageNamed:imageName];
}
@end
