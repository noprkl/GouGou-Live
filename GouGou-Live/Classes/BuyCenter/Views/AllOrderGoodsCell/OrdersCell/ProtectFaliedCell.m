//
//  ProtectFaliedCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//   维权失败cell

#import "ProtectFaliedCell.h"

#import "WaitPayAllNickView.h"
#import "SellerDogCardView.h"
#import "LogisticsInfoView.h"
#import "CostView.h"

#import "ProtectProwerTableModel.h"


@interface ProtectFaliedCell ()
/** 昵称View */
@property (strong,nonatomic) WaitPayAllNickView *nickView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview1;
/** 狗狗卡片 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 物流信息 */
@property (strong,nonatomic) LogisticsInfoView *logisticView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview2;
/** 花费 */
@property (strong,nonatomic) CostView *costView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview3;

@end

@implementation ProtectFaliedCell
#pragma mark - 模型
- (void)setProtectModel:(ProtectProwerTableModel *)protectModel {
    
    _protectModel = protectModel;
    // 直接赋值
    // 昵称
    if (protectModel.userImgUrl.length != 0) {
        NSString *urlString1 = [IMAGE_HOST stringByAppendingString:protectModel.userImgUrl];
        [self.nickView.sellerIamge sd_setImageWithURL:[NSURL URLWithString:urlString1] placeholderImage:[UIImage imageNamed:@"主播头像"]];
    }

    self.nickView.nickName.text = protectModel.merchantName;
    self.nickView.stateLabe.text = @"维权失败";
    
    // 狗狗详情
    if (protectModel.pathSmall.length != 0) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:protectModel.pathSmall];
        [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    self.dogCardView.dogNameLabel.text = protectModel.name;
    self.dogCardView.dogAgeLabel.text = protectModel.ageName;
    self.dogCardView.dogSizeLabel.text = protectModel.sizeName;
    self.dogCardView.dogColorLabel.text = protectModel.colorName;
    self.dogCardView.dogKindLabel.text = protectModel.kindName;
    self.dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:protectModel.priceOld];
    self.dogCardView.nowPriceLabel.text = protectModel.price;

    // 花费状况
    // 总计
    self.costView.moneyMessage = [NSString stringWithFormat:@"%.2lf", [protectModel.price floatValue] + [protectModel.traficRealFee floatValue]];
    // 运费
    self.costView.freightMoney.text = [NSString stringWithFormat:@"￥%@)",protectModel.traficRealFee];
    
    // 实付款
    if (self.protectModel.productRealPrice.length != 0) {// 全款支付
        // 定金
        self.costView.fontMoneyLabel.text = @"";
        self.costView.fontMoney.text = @"";
        
        // 实付
        self.costView.remainderMoneylabel.text = @"已付全款";
        self.costView.remainderMoeny.text = self.protectModel.productRealPrice!=0 ? self.protectModel.productRealPrice:@"0";
    }else{
        // 定金
        if (self.protectModel.productRealDeposit.length != 0) {
            //尾款
            if (self.protectModel.productRealBalance.length != 0) {
                // 定金
                self.costView.fontMoneyLabel.text = @"已付定金";
                self.costView.fontMoney.text = self.protectModel.productRealDeposit.length !=0 ? self.protectModel.productRealDeposit:@"0";
                
                // 实付
                self.costView.remainderMoneylabel.text = @"已付尾款";
                self.costView.remainderMoeny.text = self.protectModel.productRealBalance.length != 0 ? self.protectModel.productRealBalance:@"0";
            }else{
                //尾款
                if (self.protectModel.productRealBalance.length != 0) {
                    // 定金
                    self.costView.fontMoneyLabel.text = @"";
                    self.costView.fontMoney.text = @"";
                    
                    // 实付
                    self.costView.remainderMoneylabel.text = @"已付定金";
                    self.costView.remainderMoeny.text = self.protectModel.productRealDeposit!=0 ?self.protectModel.productRealDeposit:@"0";
                }
            }
        }
    }
    self.logisticView.orderCode = protectModel.ID;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.lineview1];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.logisticView];
        [self.contentView addSubview:self.lineview2];
        [self.contentView addSubview:self.costView];
        [self.contentView addSubview:self.lineview3];
        self.selectionStyle = UITableViewCellSelectionStyleNone;        
    }
    return self;
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

    
    [_logisticView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.dogCardView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(88);
        
    }];
    
    [_lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.logisticView.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
        
    }];
    
    [_costView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.lineview2.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(44);
    }];
    
    [_lineview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
//        [_nickView setOrderState:@"维权成功"];
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

- (LogisticsInfoView *)logisticView {
    
    if (!_logisticView) {
        _logisticView = [[LogisticsInfoView alloc] init];
        __weak typeof(self) weakSelf = self;
        _logisticView.copyBlock = ^(){
            if (weakSelf.copyBlock) {
                weakSelf.copyBlock();
            }
        };
    }
    return _logisticView;
}

- (UIView *)lineview3 {
    
    if (!_lineview3) {
        _lineview3 = [[UIView alloc] init];
        _lineview3.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineview3;
}

- (CostView *)costView {
    
    if (!_costView) {
        _costView = [[CostView alloc] init];
        [_costView costWithFreightPrice:@"￥50）" fontMoneyLabel:nil fontMoney:nil backMoneyLable:@"已付全款:" backMoney:@"￥1450"];
    }
    return _costView;
}

@end
