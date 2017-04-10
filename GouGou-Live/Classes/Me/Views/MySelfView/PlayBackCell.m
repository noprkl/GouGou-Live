//
//  PlayBackCell.m
//  GouGou-Live
//
//  Created by ma c on 16/12/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PlayBackCell.h"


@interface PlayBackCell ()

@property(nonatomic, strong) UIImageView *dogImageView; /**< 狗图片 */

@property(nonatomic, strong) UIButton *watchCount; /**< 观看人数图标 */

@property(nonatomic, strong) UIView *dogMessageView; /**< view */

@property(nonatomic, strong) UILabel *dogDescLabel; /**< 介绍 */

@property(nonatomic, strong) UILabel *showLabel; /**< 展示 */

@property(nonatomic, strong) UILabel *showCountLabel; /**< 展示数 */

@property(nonatomic, strong) UILabel *onSailLabel; /**< 出售 */

@property(nonatomic, strong) UILabel *onSailCountLabel; /**< 出售数 */

//@property (nonatomic, strong) UIView *spaceView; /**< 空格 */

@end

@implementation PlayBackCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.dogImageView];
        [self.contentView addSubview:self.watchCount];
        
        [self.contentView addSubview:self.dogMessageView];
        
        [self.dogMessageView addSubview:self.dogDescLabel];
        [self.dogMessageView addSubview:self.showLabel];
        [self.dogMessageView addSubview:self.showCountLabel];
        [self.dogMessageView addSubview:self.onSailLabel];
        [self.dogMessageView addSubview:self.onSailCountLabel];
//        [self.contentView addSubview:self.spaceView];
    }
    return self;
}

- (void)setDogCardModel:(PlayBackModel *)dogCardModel {
    _dogCardModel = dogCardModel;
    if (dogCardModel.cover != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:dogCardModel.cover];
        [self.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"banner"]];
    }else{
        self.dogImageView.image = [UIImage imageNamed:@"banner"];
    }
    [self.watchCount setTitle:dogCardModel.viewNum forState:(UIControlStateNormal)];
    
    self.dogDescLabel.text = dogCardModel.name;
    self.showCountLabel.text = [@(dogCardModel.pNum) stringValue];
    self.onSailCountLabel.text = [@(dogCardModel.pNum - dogCardModel.num) stringValue];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.dogImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(PlayBackHeight - 10);
    }];
    [self.watchCount makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(63, 22));
    }];
    [self.dogMessageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.dogImageView.bottom);
        make.height.equalTo(22);
    }];
    [self.dogDescLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dogMessageView.left).offset(10);
        make.centerY.equalTo(self.dogMessageView.centerY);
    }];
    
    [self.onSailCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogMessageView.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.onSailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogMessageView.centerY);
        make.right.equalTo(self.onSailCountLabel.left).offset(-5);
    }];
    [self.showCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogMessageView.centerY);
        make.right.equalTo(self.onSailLabel.left).offset(-10);
    }];
    [self.showLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogMessageView.centerY);
        make.right.equalTo(self.showCountLabel.left).offset(-5);
    }];
//    [self.spaceView makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.left.right.equalTo(self);
//        make.top.equalTo(self.dogImageView.bottom);
//    }];
}
- (UIImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[UIImageView alloc] init];
        _dogImageView.image = [UIImage imageNamed:@"banner"];
        _dogImageView.userInteractionEnabled = YES;
    }
    return _dogImageView;
}
- (UIButton *)watchCount {
    if (!_watchCount) {
        _watchCount = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_watchCount setTitle:@"1993" forState:(UIControlStateNormal)];
        
        _watchCount.titleLabel.font = [UIFont systemFontOfSize:16];
        [_watchCount setTitleColor:[UIColor colorWithHexString:@"#ffa11a"] forState:(UIControlStateNormal)];
        _watchCount.enabled = NO;
        
        _watchCount.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        _watchCount.alpha = 0.6;
        [_watchCount setImage:[UIImage imageNamed:@"联系人"] forState:(UIControlStateNormal)];
        [_watchCount setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        
        _watchCount.layer.cornerRadius = 5;
        _watchCount.layer.masksToBounds = YES;
    }
    return _watchCount;
}
- (UIView *)dogMessageView {
    if (!_dogMessageView) {
        _dogMessageView = [[UIView alloc] init];
        _dogMessageView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        _dogMessageView.alpha = 0.4;
    }
    return _dogMessageView;
}
- (UILabel *)dogDescLabel {
    if (!_dogDescLabel) {
        _dogDescLabel = [[UILabel alloc] init];
        _dogDescLabel.font = [UIFont systemFontOfSize:12];
        _dogDescLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _dogDescLabel;
}
- (UILabel *)showLabel {
    if (!_showLabel) {
        _showLabel = [[UILabel alloc] init];
        _showLabel.text = @"展";
        _showLabel.font = [UIFont systemFontOfSize:12];
        _showLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _showLabel;
}
- (UILabel *)showCountLabel {
    if (!_showCountLabel) {
        _showCountLabel = [[UILabel alloc] init];
        _showCountLabel.font = [UIFont systemFontOfSize:12];
        _showCountLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        
    }
    return _showCountLabel;
}
- (UILabel *)onSailLabel {
    if (!_onSailLabel) {
        _onSailLabel = [[UILabel alloc] init];
        _onSailLabel.text = @"售";
        _onSailLabel.font = [UIFont systemFontOfSize:12];
        _onSailLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _onSailLabel;
}
- (UILabel *)onSailCountLabel {
    if (!_onSailCountLabel) {
        _onSailCountLabel = [[UILabel alloc] init];
        _onSailCountLabel.font = [UIFont systemFontOfSize:12];
        _onSailCountLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _onSailCountLabel;
}
@end
