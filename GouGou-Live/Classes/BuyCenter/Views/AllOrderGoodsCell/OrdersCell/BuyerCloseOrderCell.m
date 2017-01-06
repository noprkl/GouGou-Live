//
//  BuyerCloseOrderCell.m
//  GouGou-Live
//
//  Created by ma c on 16/12/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BuyerCloseOrderCell.h"
#import "SellerNickNameView.h"
#import "SellerDogCardView.h"
#import "SellerCostView.h"

@interface BuyerCloseOrderCell ()

@property(nonatomic, strong) UIView *spaceView; /**< 间隔 */

@property(nonatomic, strong) SellerNickNameView *nickView; /**< 昵称view */

@property(nonatomic, strong) SellerDogCardView *dogCardView; /**< 狗狗信息图片 */

@property(nonatomic, strong) SellerCostView *costView; /**< 花费 */

@property (nonatomic, strong) UIButton *deleOrder; /**< 删除订单 */

@end

@implementation BuyerCloseOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.spaceView];
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.costView];
         [self.contentView addSubview:self.deleOrder];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setOrderState:(NSString *)orderState {
    _orderState = orderState;
    self.nickView.stateMessage = orderState;
}
- (void)setCostMessage:(NSArray *)costMessage {
    _costMessage = costMessage;
    self.costView.messages = costMessage;
}
- (void)setModel:(BuyCenterModel *)model {
    _model = model;
    
    self.nickView.nickName.text = model.merchantName;
    self.nickView.stateMessage = @"交易关闭";

    if (model.pathSmall != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathSmall];
        [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    
    self.dogCardView.dogNameLabel.text = model.name;
    self.dogCardView.dogKindLabel.text = model.kindName;
    self.dogCardView.dogAgeLabel.text = model.ageName;
    self.dogCardView.dogSizeLabel.text = model.sizeName;
    self.dogCardView.dogColorLabel.text = model.colorName;
    self.dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:model.priceOld];
    self.dogCardView.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];
    self.costView.moneyMessage = [NSString stringWithFormat:@"%.2lf", [model.price floatValue] + [model.traficMoney floatValue]];
    self.costView.freightMoney = model.traficMoney;
}
- (void)clickDeleButtonAction:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
    if (_deleBlock) {
        _deleBlock();
    }
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.spaceView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.width.equalTo(self);
        make.height.equalTo(10);
    }];
    
    [self.nickView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    
    [self.dogCardView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(100);
    }];
    
    [self.costView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogCardView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.deleOrder makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(75, 35));
        make.top.equalTo(self.costView.bottom).offset(10);
    }];

}
#pragma mark
#pragma mark - 懒加载
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _spaceView;
}
- (SellerNickNameView *)nickView {
    if (!_nickView) {
        _nickView = [[SellerNickNameView alloc] init];
        _nickView.dateIsHid = YES;
    }
    return _nickView;
}
- (SellerDogCardView *)dogCardView {
    if (!_dogCardView) {
        _dogCardView = [[SellerDogCardView alloc] init];
    }
    return _dogCardView;
}
- (SellerCostView *)costView {
    if (!_costView) {
        _costView = [[SellerCostView alloc] init];
    }
    return _costView;
}
- (UIButton *)deleOrder {
    if (!_deleOrder) {
        _deleOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _deleOrder.layer.cornerRadius = 5;
        _deleOrder.layer.masksToBounds = YES;
        _deleOrder.layer.borderWidth = 1;
        _deleOrder.titleLabel.font = [UIFont systemFontOfSize:13];
        _deleOrder.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        [_deleOrder setTitle:@"删除订单" forState:(UIControlStateNormal)];
        [_deleOrder setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:(UIControlStateNormal)];
        [_deleOrder setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateSelected)];
        
        [_deleOrder addTarget:self action:@selector(clickDeleButtonAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _deleOrder;
}

@end
