//
//  SellerAcceptRateCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAcceptRateCell.h"
#import "AcceptRateBuyerView.h"
#import "AcceptRateDogCardView.h"
#import "DogImageView.h"
#import "StartSourceView.h"

@interface SellerAcceptRateCell ()

@property(nonatomic, strong) UIView *line; /**< 线 */

@property(nonatomic, strong) AcceptRateBuyerView *buyerView; /**< 购买的人 */

@property(nonatomic, strong) AcceptRateDogCardView *dogCardView; /**< 狗狗卡片 */

@property(nonatomic, strong) DogImageView *dogImageView; /**< 狗狗图片 */

@property(nonatomic, strong) UILabel *pleaseLabel; /**< 满意度 */

@property(nonatomic, strong) StartSourceView *startView; /**< 星星个数 */

@end
@implementation SellerAcceptRateCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.buyerView];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.dogImageView];
        [self.contentView addSubview:self.pleaseLabel];
        [self.contentView addSubview:self.startView];
        
    }
    return self;
}
// 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.top);
        make.height.equalTo(10);
    }];
    [self.buyerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.line.bottom);
        make.height.equalTo(65);
    }];
    [self.dogCardView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.buyerView.bottom).offset(10);
        make.height.equalTo(78);
    }];
    
    
    CGFloat height = [_dogImageView getCellHeightWithImages:self.images];

    [self.dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.top.equalTo(self.dogCardView.bottom).offset(10);
        make.height.equalTo(height);
    }];
    [self.startView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-10);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(100, 15));
    }];
    [self.pleaseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.startView.centerY);
        make.right.equalTo(self.startView.left).offset(-10);
    }];

}
- (void)setImages:(NSArray *)images {
    _images = images;

    
//    [self.dogImageView remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.width.equalTo(self);
//        make.bottom.equalTo(self.bottom).offset(- 30);
//        make.height.equalTo(height);
//    }];
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
- (AcceptRateBuyerView *)buyerView {
    if (!_buyerView) {
        _buyerView = [[AcceptRateBuyerView alloc] init];
    }
    return _buyerView;
}
- (AcceptRateDogCardView *)dogCardView {
    if (!_dogCardView) {
        _dogCardView = [[AcceptRateDogCardView alloc] init];
        _dogCardView.backgroundColor = [UIColor whiteColor];
    }
    return _dogCardView;
}
- (DogImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[DogImageView alloc] init];
    }
    return _dogImageView;
}
- (UILabel *)pleaseLabel {
    if (!_pleaseLabel) {
        _pleaseLabel = [[UILabel alloc] init];
        _pleaseLabel.text = @"满意度";
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
