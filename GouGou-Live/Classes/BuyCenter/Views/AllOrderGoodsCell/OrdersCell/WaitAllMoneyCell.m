//
//  WaitAllMoneyCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  代付全款cell

#import "WaitAllMoneyCell.h"

#import "WaitPayAllNickView.h"
#import "SellerDogCardView.h"
#import "LogisticsInfoView.h"
#import "CostView.h"
#import "WaitAllNickModel.h"

@interface WaitAllMoneyCell ()
/** 昵称View */
@property (strong,nonatomic) WaitPayAllNickView *nickView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview1;
/** 狗狗卡片 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 花费 */
@property (strong,nonatomic) CostView *costView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview2;

@end

@implementation WaitAllMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.lineview1];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.costView];
        [self.contentView addSubview:self.lineview2];
        
    }
    return self;
}

#pragma mark - 模型数据
- (void)setCenterModel:(BuyCenterModel *)centerModel {
    
    _centerModel = centerModel;
    /*
    self.nickView.model.merchantName = centerModel.merchantName;
    self.nickView.model.status = centerModel.status;
    self.nickView.model.merchantImgl = centerModel.merchantImgl;
    
    self.dogCardView.dogCardModel.sizeName = centerModel.sizeName;
    self.dogCardView.dogCardModel.colorName = centerModel.colorName;
    self.dogCardView.dogCardModel.ageName = centerModel.ageName;
    self.dogCardView.dogCardModel.name = centerModel.name;
    self.dogCardView.dogCardModel.pathSmall = centerModel.pathSmall;
    self.dogCardView.dogCardModel.priceOld = centerModel.priceOld;
    self.dogCardView.dogCardModel.price = centerModel.price;
    self.dogCardView.dogCardModel.kindName = centerModel.kindName;
    
    self.costView.costModel.productRealDeposit = centerModel.productRealDeposit;
    self.costView.costModel.balance = centerModel.balance;
    */
    // 直接赋值
    NSString *urlString1 = [IMAGE_HOST stringByAppendingString:centerModel.merchantImgl];
    [self.nickView.sellerIamge sd_setImageWithURL:[NSURL URLWithString:urlString1] placeholderImage:[UIImage imageNamed:@"主播头像"]];

    self.nickView.sellerIamge.image = [UIImage imageNamed:centerModel.merchantImgl];
    self.nickView.nickName.text = centerModel.merchantName;
    self.nickView.stateLabe.text = centerModel.status;
    
    NSString *urlString = [IMAGE_HOST stringByAppendingString:centerModel.pathSmall];
    [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
//    self.dogCardView.dogImageView.image = [UIImage imageNamed:centerModel.pathSmall];
    self.dogCardView.dogNameLabel.text = centerModel.name;
    self.dogCardView.dogAgeLabel.text = centerModel.ageName;
    self.dogCardView.dogSizeLabel.text = centerModel.sizeName;
    self.dogCardView.dogColorLabel.text = centerModel.colorName;
    self.dogCardView.dogKindLabel.text = centerModel.kindName;
    self.dogCardView.oldPriceLabel.text = centerModel.priceOld;
    self.dogCardView.nowPriceLabel.text = centerModel.price;
    
    self.costView.fontMoney.text = centerModel.productRealDeposit;
    self.costView.remainderMoeny.text = centerModel.balance;
    self.costView.totalMoney.text = [NSString stringWithFormat:@"%ld",([centerModel.productRealDeposit integerValue] +[centerModel.balance integerValue])];
     
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    
    
    [_nickView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(weakself);
        make.height.equalTo(54);
        
    }];
    
    [_lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.nickView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
    [_dogCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineview1.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(110);
        
    }];
    
    [_costView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.dogCardView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(44);
    }];
    
    [_lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.costView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
}

#pragma mark
#pragma mark - 懒加载

- (WaitPayAllNickView *)nickView {
    
    if (!_nickView) {
        _nickView = [[WaitPayAllNickView alloc] init];
//        [_nickView setOrderState:@"待付全款"];
    }
    return _nickView;
}

- (UIView *)lineview1 {
    
    if (!_lineview1) {
        _lineview1 = [[UIView alloc] init];
        _lineview1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview1;
}

- (SellerDogCardView *)dogCardView {
    
    if (!_dogCardView) {
        _dogCardView = [[SellerDogCardView alloc] init];
    }
    return _dogCardView;
}

- (UIView *)lineview2 {
    
    if (!_lineview2) {
        _lineview2 = [[UIView alloc] init];
        _lineview2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview2;
}

- (CostView *)costView {
    
    if (!_costView) {
        _costView = [[CostView alloc] init];
//        [_costView costWithFreightPrice:@"￥50）" fontMoneyLabel:nil fontMoney:nil backMoneyLable:@"全款:" backMoney:@"￥1450"];
    }
    return _costView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
