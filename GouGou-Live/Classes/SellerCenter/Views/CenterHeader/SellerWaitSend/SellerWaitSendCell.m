//
//  SellerWaitSendCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitSendCell.h"

@interface SellerWaitSendCell ()

@property(nonatomic, strong) UIView *spaceView; /**< 间隔 */

@property(nonatomic, strong) SellerNickNameView *nickView; /**< 昵称view */

@property(nonatomic, strong) SellerDogCardView *dogCardView; /**< 狗狗信息图片 */

@property(nonatomic, strong) SellerCostView *costView; /**< 花费 */

@property(nonatomic, strong) SellerFunctionButtonView *functionView; /**< 按钮 */

@end

@implementation SellerWaitSendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.spaceView];
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.costView];
        [self.contentView addSubview:self.functionView];
    }
    return self;
}
- (void)setBtnTitles:(NSArray *)btnTitles {
    _btnTitles = btnTitles;
    self.functionView.titleArray = btnTitles;
}
- (void)setOrderState:(NSString *)orderState {
    _orderState = orderState;
    self.nickView.stateMessage = orderState;
}
- (void)setCostMessage:(NSArray *)costMessage {
    _costMessage = costMessage;
    self.costView.messages = costMessage;
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
    [self.functionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.costView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    
}

- (void)setModel:(SellerOrderModel *)model {
    _model = model;
    
    self.nickView.nickName.text = model.userName;
    self.nickView.dateLabel.text = @"";
    
    if (model.pathSmall != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathSmall];
        [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    
    self.dogCardView.dogNameLabel.text = model.name;
    self.dogCardView.dogKindLabel.text = model.kindName;
    self.dogCardView.dogAgeLabel.text = model.ageName;
    self.dogCardView.dogSizeLabel.text = model.sizeName;
    self.dogCardView.dogColorLabel.text = model.colorName;
    self.dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:[NSString stringWithFormat:@"￥%@", model.priceOld]];
    self.dogCardView.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", model.price];

    self.costView.moneyMessage = [NSString stringWithFormat:@"￥%.2lf", [model.productRealBalance floatValue] + [model.productRealDeposit floatValue] + [model.productRealPrice floatValue] + [model.traficFee floatValue]];
    if (model.traficFee.length == 0) {
        self.costView.freightMoney = @"0";
    }else{
        self.costView.freightMoney = model.traficFee;
    }
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
- (SellerFunctionButtonView *)functionView {
    if (!_functionView) {
        _functionView = [[SellerFunctionButtonView alloc] init];
        _functionView.titleArray = @[@"联系买家", @"发货"];
        __weak typeof(self) weakSelf = self;
        _functionView.clickBtnBlock = ^(NSString *btnTitle){
            
            // 点击按钮回调
            if (weakSelf.clickBtnBlock) {
                weakSelf.clickBtnBlock(btnTitle);
            }
        };
    }
    return _functionView;
}

@end
