//
//  SellerWaitPayCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitPayCell.h"

@interface SellerWaitPayCell ()

@property(nonatomic, strong) UIView *spaceView; /**< 间隔 */

@property(nonatomic, strong) SellerNickNameView *nickView; /**< 昵称view */

@property(nonatomic, strong) SellerDogCardView *dogCardView; /**< 狗狗信息图片 */

@property(nonatomic, strong) SellerCostView *costView; /**< 花费 */

@property(nonatomic, strong) SellerFunctionButtonView *functionView; /**< 按钮 */

@property (nonatomic, assign) dispatch_source_t timeOut; /**< 定时器 */

@end

@implementation SellerWaitPayCell
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
- (void)setModel:(SellerOrderModel *)model {
    _model = model;
    
    self.nickView.nickName.text = model.userName;
    self.nickView.dateLabel.text = @"";
    
//    __block NSInteger timeout = [NSString getRemainTimeWithString:model.closeTime]; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                self.nickView.dateLabel.text = @"订单已关闭";
//            });
//        }else{
//            NSInteger days = (int)(timeout/(3600*24));
//            NSInteger hours = (int)((timeout-days*24*3600)/3600);
//            NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
//            NSInteger second = timeout-days*24*3600-hours*3600-minute*60;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                self.nickView.dateLabel.text = [NSString stringWithFormat:@"%ld天%ld时%ld分%ld秒", days, hours, minute, second];
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);

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
    
    self.costView.moneyMessage = [NSString stringWithFormat:@"%ld", [model.price integerValue] + [model.traficMoney integerValue]];
    self.costView.freightMoney = model.traficMoney;
    
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
//        _nickView.backgroundColor = [UIColor whiteColor];
        
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
