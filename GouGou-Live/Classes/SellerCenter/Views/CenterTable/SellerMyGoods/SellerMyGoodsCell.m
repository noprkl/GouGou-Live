//
//  SellerMyGoodsCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerMyGoodsCell.h"

@interface SellerMyGoodsCell ()


@property(nonatomic, strong) UIButton *selectBtn; /**< 选中按钮 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@property (strong, nonatomic)  UIImageView *dogImageView;/**< 狗狗图片*/
@property (strong, nonatomic)  UILabel *dogNameLabel;/**< 狗狗名字 */
@property(nonatomic, strong) UILabel *kindLabel; /**< 品种 */
@property (strong, nonatomic)  UILabel *dogKindLabel;/**< 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogAgeLabel;/**< 狗狗年龄*/

@property (strong, nonatomic)  UILabel *dogSizeLabel;/**< 狗狗体型*/

@property (strong, nonatomic)  UILabel *dogColorLabel;/**< 狗狗颜色*/

@property (strong, nonatomic)  UILabel *nowPriceLabel;/**< 狗狗价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;/**< 狗狗老价格*/

@property (strong, nonatomic)  UILabel *stateLabel;/**< 狗狗当前个数*/
@end

@implementation SellerMyGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.dogImageView];
        [self.contentView addSubview:self.dogNameLabel];
        [self.contentView addSubview:self.kindLabel];
        [self.contentView addSubview:self.dogKindLabel];
        [self.contentView addSubview:self.dogAgeLabel];
        [self.contentView addSubview:self.dogSizeLabel];
        [self.contentView addSubview:self.dogColorLabel];
        [self.contentView addSubview:self.nowPriceLabel];
        [self.contentView addSubview:self.oldPriceLabel];
        [self.contentView addSubview:self.stateLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.top.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 10));
    }];
    [self.dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.line.bottom).offset(10);
        make.size.equalTo(CGSizeMake(78, 78));
    }];
    [self.dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogImageView.top).offset(5);
        make.left.equalTo(self.dogImageView.right).offset(10);
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
        make.top.equalTo(self.dogNameLabel.bottom).offset(7);
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
        make.top.equalTo(self.dogAgeLabel.bottom).offset(0);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.oldPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nowPriceLabel.bottom);
        make.left.equalTo(self.dogImageView.right).offset(10);
    }];
    [self.stateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.oldPriceLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
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
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogNameLabel.font = [UIFont boldSystemFontOfSize:16];
        
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
        
        _oldPriceLabel.attributedText = [self getCenterLineWithString:@"¥ 2400"];
    }
    return _oldPriceLabel;
}
- (UILabel *)stateLabel {
    
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        
        _stateLabel.text = @"等待中";
        _stateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _stateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _stateLabel;
}
- (void)setDogCard:(NSArray *)dogCard {
    _dogCard = dogCard;
    
}
- (void)setCellState:(NSString *)cellState {
    _cellState = cellState;
    self.stateLabel.text = cellState;
}

- (NSAttributedString *)getCenterLineWithString:(NSString *)text {
    NSDictionary *attribtDic = @{
                                 NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                 };
    NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:text attributes:attribtDic];
    return attribut;
}
@end
