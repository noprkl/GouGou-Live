//
//  SellerProtectPowerCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerProtectPowerCell.h"

@interface SellerProtectPowerCell ()

@property(nonatomic, strong) UIView *spaceView; /**< 间隔 */

@property(nonatomic, strong) SellerNickNameView *nickView; /**< 昵称view */

@property(nonatomic, strong) SellerDogCardView *dogCardView; /**< 狗狗信息图片 */

@property(nonatomic, strong) SellerLogisticsInfoView *logisticsView; /**< 物流信息 */

@property(nonatomic, strong) SellerCostView *costView; /**< 花费 */

@property(nonatomic, strong) SellerFunctionButtonView *functionView; /**< 按钮 */

@end

@implementation SellerProtectPowerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.spaceView];
        [self.contentView addSubview:self.nickView];
        [self.contentView addSubview:self.dogCardView];
        [self.contentView addSubview:self.logisticsView];
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
- (void)setModel:(SellerProtectModel *)model {
    _model = model;
    
    self.nickView.nickName.text = model.userNickName;
    self.nickView.dateLabel.text = @"14分59秒";
    if ([model.status intValue] == 1) {
        self.nickView.stateMessage = @"维权中";
    }else  if ([model.status intValue] == 2) {
        self.nickView.stateMessage = @"维权成功";
    }else  if ([model.status intValue] == 3) {
        self.nickView.stateMessage = @"维权失败";
    }
    
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
    
    self.logisticsView.transformNumber = model.ID;
    
    self.costView.moneyMessage = model.price;
   
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
    
    [self.logisticsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dogCardView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(88);
    }];
    
    [self.costView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logisticsView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.functionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.costView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
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
- (SellerLogisticsInfoView *)logisticsView {
    if (!_logisticsView) {
        _logisticsView = [[SellerLogisticsInfoView alloc] init];

        __weak typeof(self) weakSelf = self;
        _logisticsView.editBlock = ^(){
            if (weakSelf.editBlock) {
                weakSelf.editBlock();
            }
        };
    }
    return _logisticsView;
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
        _functionView.titleArray = @[@"在线客服", @"查看详情"];
       
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
