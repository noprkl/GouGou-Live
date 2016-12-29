//
//  WaitFontMoneyCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  支付定金cell

#import "WaitFontMoneyCell.h"
#import "NicknameView.h"
//#import "DogCardView.h"
#import "SellerDogCardView.h"
#import "LogisticsInfoView.h"
#import "CostView.h"
#import "FunctionButtonView.h"

@interface WaitFontMoneyCell ()
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

@implementation WaitFontMoneyCell

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

#pragma mark - 模型数据
- (void)setCenterModel:(BuyCenterModel *)centerModel {
    
    _centerModel = centerModel;
        // 直接赋值
    // 昵称
    if (centerModel.merchantImg1.length != 0) {
        NSString *urlString1 = [IMAGE_HOST stringByAppendingString:centerModel.merchantImg1];
        [self.nickView.sellerIamge sd_setImageWithURL:[NSURL URLWithString:urlString1] placeholderImage:[UIImage imageNamed:@"主播头像"]];
    }
    self.nickView.nickName.text = centerModel.merchantName;
    self.nickView.stateLabe.text = @"待付定金";

   /*
    // 当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyddhhmmss"];
    // 当前时间转化为字符串
    NSString * dateString = [dateFormatter stringFromDate:date];
    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setDateFormat:@"yyddhhmmss"];
    NSDate *date1 = [formatterDate dateFromString:dateString];
    NSTimeInterval dateTime = [date1 timeIntervalSince1970];

    
//    // 获取时间差字符串
//    NSString * cutDownTime = [NSString dateTimeDifferenceWithStartTime:centerModel.creatTime endTime:dateString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyddhhmmss"];
    NSDate *cutDate = [formatter dateFromString:centerModel.creatTime];
    NSTimeInterval downTime = [cutDate timeIntervalSince1970];
    // 差值
    NSTimeInterval remainTime = downTime - dateTime;
    
    if (remainTime > 30 *60) {
        self.nickView.remainTimeLabel.text = @"";
    } else {
        int h = remainTime / 60 / 60;
        int m = remainTime / 60 / 60 / 24;
        if (h != 0) {
            [self.nickView.remainTimeLabel beginCountDownWithTimeInterval:h * 60 * 60];
        } else if (m != 0){
        
            [self.nickView.remainTimeLabel beginCountDownWithTimeInterval:m * 60];
        } else {
            self.nickView.remainTimeLabel.text = @"";
        }
    }
*/

    self.nickView.remainTimeLabel.text = [NSString stringFromDateString:centerModel.createTime];
    
    __block NSInteger timeout = [NSString getRemainTimeWithString:centerModel.closeTime]; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.nickView.remainTimeLabel.text = @"订单已关闭";
            });
        }else{
            NSInteger minutes = timeout / 60;
            NSInteger seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.nickView.remainTimeLabel.text = [NSString stringWithFormat:@"%ld分%ld秒", minutes, seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    

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
    
    // 付款状况（缺少运费）
    self.dogCardView.nowPriceLabel.text = centerModel.price;
    // 付款状况
    self.costView.fontMoneyLabel.text = @"";
    self.costView.fontMoney.text = @"";
    self.costView.remainderMoneylabel.text = @"待付定金:";
    self.costView.remainderMoeny.text = centerModel.productDeposit;
//    self.costView.totalMoney.text = centerModel.price;
    self.costView.totalMoney.text = centerModel.productDeposit;
    self.costView.freightMoney.text = [NSString stringWithFormat:@"￥%@)",centerModel.traficFee];

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
//        [_nickView setStateMessage:@"待付定金"];
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
        [_costView costWithFreightPrice:@"￥50）" fontMoneyLabel:@"定金:" fontMoney:@"￥500" backMoneyLable:@"尾款:" backMoney:@"￥950"];
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
