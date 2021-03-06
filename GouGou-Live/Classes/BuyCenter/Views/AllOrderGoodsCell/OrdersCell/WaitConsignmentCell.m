//
//  WaitConsignmentCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  代发货cell

#import "WaitConsignmentCell.h"

#import "NicknameView.h"
#import "CostView.h"
#import "SellerDogCardView.h"

@interface WaitConsignmentCell ()
/** 昵称View */
@property (strong,nonatomic) NicknameView *nickView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview1;
/** 狗狗卡片 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 横线 */
@property (strong,nonatomic) UIView *lineview2;
/** 花费 */
@property (strong,nonatomic) CostView *costView;
@end

@implementation WaitConsignmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.lineview1];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.costView];
        [self.contentView addSubview:self.lineview2];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
#pragma mark - 模型
- (void)setCenterModel:(BuyCenterModel *)centerModel {

    // 直接赋值
    // 昵称
    if (centerModel.userImgUrl.length != 0) {
        NSString *urlString1 = [IMAGE_HOST stringByAppendingString:centerModel.userImgUrl];
        [self.nickView.sellerIamge sd_setImageWithURL:[NSURL URLWithString:urlString1] placeholderImage:[UIImage imageNamed:@"主播头像"]];
    }
    self.nickView.nickName.text = centerModel.userName;
    self.nickView.stateLabe.text = @"待发货";
    
    // 狗狗详情
    if (centerModel.pathSmall.length != 0) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:centerModel.pathSmall];
        [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    self.dogCardView.dogNameLabel.text = centerModel.name;
    self.dogCardView.dogAgeLabel.text = centerModel.ageName;
    self.dogCardView.dogSizeLabel.text = centerModel.sizeName;
    self.dogCardView.dogColorLabel.text = centerModel.colorName;
    self.dogCardView.dogKindLabel.text = centerModel.kindName;
    self.dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:centerModel.priceOld];
    self.dogCardView.nowPriceLabel.text = centerModel.price;
   
    // 付款状况
    // 总价价格
    self.costView.moneyMessage = [NSString stringWithFormat:@"%.2lf", [centerModel.productRealBalance floatValue] + [centerModel.productRealDeposit floatValue] + [centerModel.productRealPrice floatValue] + [centerModel.traficFee floatValue]];

    // 运费
    self.costView.freightMoney.text = [NSString stringWithFormat:@"￥%@)",centerModel.traficFee];
    // 付款状况
    // 实付款
    if (centerModel.productRealPrice.length != 0) {// 全款支付
        // 定金
        self.costView.fontMoneyLabel.text = @"";
        self.costView.fontMoney.text = @"";
        
        // 实付
        self.costView.remainderMoneylabel.text = @"已付全款:";
        if (centerModel.productRealPrice.length != 0) {
            self.costView.remainderMoeny.text = centerModel.productRealPrice;
        }else{
            self.costView.remainderMoeny.text = @"0";
        }
    }else{
        // 定金
        if (centerModel.productRealDeposit.length != 0) {
            //尾款
            if (centerModel.productRealBalance.length != 0) {
                // 定金
                self.costView.fontMoneyLabel.text = @"已付定金:";
                if (centerModel.productRealDeposit.length != 0) {
                    self.costView.fontMoney.text = centerModel.productRealDeposit;
                }else{
                    self.costView.fontMoney.text = @"0";
                }
                
                
                // 实付
                self.costView.remainderMoneylabel.text = @"已付尾款:";
                self.costView.remainderMoeny.text = centerModel.productRealBalance.length !=0 ? centerModel.productRealBalance:@"0";
            }else{
                //尾款
                if (centerModel.productRealBalance.length != 0) {
                    // 定金
                    self.costView.fontMoneyLabel.text = @"";
                    self.costView.fontMoney.text = @"";
                    
                    // 实付
                    self.costView.remainderMoneylabel.text = @"已付定金:";
                    self.costView.remainderMoeny.text = centerModel.productRealDeposit.length != 0 ? centerModel.productRealDeposit:@"0";
                }
            }
        }
    }
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

- (NicknameView *)nickView {
    
    if (!_nickView) {
        _nickView = [[NicknameView alloc] init];
        [_nickView setStateMessage:@"待发货"];
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
