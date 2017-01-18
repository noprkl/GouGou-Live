//
//  SellerCostView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerCostView.h"

@interface SellerCostView  ()

/** 合计 */
@property (strong,nonatomic) UILabel *totalLabel;
/** 总钱数 */
@property (strong,nonatomic) UILabel *totalMoney;
/** 运费 */
@property (strong,nonatomic) UILabel *freightLabel;
///** 已付定金 */
//@property (strong,nonatomic) UILabel *fontMoneyLabel;
///** 定金 */
//@property (strong,nonatomic) UILabel *fontMoney;
///** 已付尾款 */
//@property (strong,nonatomic) UILabel *remainderMoneylabel;
///** 尾款 */
//@property (strong,nonatomic) UILabel *remainderMoeny;

@property (nonatomic, strong) UILabel *firstCostLabel; /**< 第一个付款情况 */
@property (nonatomic, strong) UILabel *secondCostLabel; /**< 第二个付款情况 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@end

@implementation SellerCostView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:self.totalLabel];
        [self addSubview:self.totalMoney];
        [self addSubview:self.freightLabel];
//        [self addSubview:self.fontMoneyLabel];
//        [self addSubview:self.fontMoney];
//        [self addSubview:self.remainderMoneylabel];
//        [self addSubview:self.remainderMoeny];
        [self addSubview:self.firstCostLabel];
        [self addSubview:self.secondCostLabel];
        
        [self addSubview:self.line];
    }
    return self;
}
-(void)setMoneyMessage:(NSString *)moneyMessage {
    _moneyMessage = moneyMessage;
    self.totalMoney.text = moneyMessage;
}
- (void)setMessages:(NSArray *)messages {
    _messages = messages;
    DLog(@"%@", messages);
//    for (NSInteger i = 0; i < self.messages.count; i++) {
//        NSString *costMessage = self.messages[self.messages.count - 1 - i];
//    }
    if (self.messages.count == 0) {
        self.firstCostLabel.text = @" ";
        self.secondCostLabel.text = @" ";
    }
    if (self.messages.count == 1) {
        self.firstCostLabel.text = self.messages[0];
        self.secondCostLabel.text = @" ";
    }
    if (self.messages.count == 2) {
        self.firstCostLabel.text = self.messages[0];
        self.secondCostLabel.text = self.messages[1];
    }

//    CGFloat W = 0;
//    CGFloat H = 44;
//    CGFloat y = 0;
//    
//    // 间隔
//    CGFloat offset = kDogImageWidth / 2;
//    
//    for (NSInteger i = 0; i < self.messages.count; i++) {
//        
//        NSString *labelStr = self.messages[self.messages.count - 1 - i];
//        
//        UILabel * label = [[UILabel alloc] init];
//        NSDictionary *dict = @{
//                               NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],
//                               NSFontAttributeName:[UIFont systemFontOfSize:14]
//                               };
//        label.attributedText = [[NSAttributedString alloc] initWithString:labelStr attributes:dict];
//        
//        CGFloat labelW = [labelStr boundingRectWithSize:CGSizeMake(MAXFLOAT, H) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil].size.width;
//        
//        W += labelW + offset;
//        
//        label.frame  = CGRectMake(SCREEN_WIDTH - W , y, labelW, H);
//        [self addSubview:label];
//    }
}
- (void)setFreightMoney:(NSString *)freightMoney {
    _freightMoney = freightMoney;
    self.freightLabel.text = [NSString stringWithFormat:@"(含运费:￥%@)", freightMoney];
    
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    
    [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(5);
        
    }];
    
    [_totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.totalLabel.right).offset(5);
        make.centerY.equalTo(weakself.totalLabel.centerY);
        
    }];
    
    [_freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.totalLabel.bottom).offset(5);
    }];
    
    [_firstCostLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(44);
        make.centerY.equalTo(self.centerY);
    }];
    [_secondCostLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.firstCostLabel.left).offset(-5);
        make.height.equalTo(44);
        make.centerY.equalTo(self.centerY);
    }];
   
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.bottom);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
    }];
}

#pragma mark
#pragma mark - 懒加载
-(UILabel *)totalLabel {
    
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.text = @"合计:";
        _totalLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _totalLabel.font = [UIFont systemFontOfSize:14];
    }
    return _totalLabel;
}

-(UILabel *)totalMoney {
    
    if (!_totalMoney) {
        _totalMoney = [[UILabel alloc] init];
        _totalMoney.text = @"￥1450";
        _totalMoney.textColor = [UIColor colorWithHexString:@"#000000"];
        _totalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _totalMoney;
}

-(UILabel *)freightLabel {
    
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        _freightLabel.text = @"(含运费:￥50)";
        _freightLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _freightLabel.font = [UIFont systemFontOfSize:12];
    }
    return _freightLabel;
}
- (UILabel *)firstCostLabel {
    if (!_firstCostLabel) {
        _firstCostLabel = [[UILabel alloc] init];
        _firstCostLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _firstCostLabel.font = [UIFont systemFontOfSize:14];
    }
    return _firstCostLabel;
}
- (UILabel *)secondCostLabel {
    if (!_secondCostLabel) {
        _secondCostLabel = [[UILabel alloc] init];
        _secondCostLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _secondCostLabel.font = [UIFont systemFontOfSize:14];
    }
    return _secondCostLabel;
}
//-(UILabel *)fontMoneyLabel {
//    
//    if (!_fontMoneyLabel) {
//        _fontMoneyLabel = [[UILabel alloc] init];
//        _fontMoneyLabel.text = @"已付定金:";
//        _fontMoneyLabel.textColor = [UIColor colorWithHexString:@"#333333"];
//        _fontMoneyLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _fontMoneyLabel;
//}
//
//-(UILabel *)fontMoney {
//    
//    if (!_fontMoney) {
//        _fontMoney = [[UILabel alloc] init];
//        _fontMoney.text = @"￥500";
//        _fontMoney.textColor = [UIColor colorWithHexString:@"#000000"];
//        _fontMoney.font = [UIFont systemFontOfSize:16];
//    }
//    return _fontMoney;
//}
//
//-(UILabel *)remainderMoneylabel {
//    
//    if (!_remainderMoneylabel) {
//        _remainderMoneylabel = [[UILabel alloc] init];
//        _remainderMoneylabel.text = @"已付尾款:";
//        _remainderMoneylabel.textColor = [UIColor colorWithHexString:@"#333333"];
//        _remainderMoneylabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _remainderMoneylabel;
//}
//
//-(UILabel *)remainderMoeny {
//    
//    if (!_remainderMoeny) {
//        _remainderMoeny = [[UILabel alloc] init];
//        _remainderMoeny.text = @"￥950";
//        _remainderMoeny.textColor = [UIColor colorWithHexString:@"#000000"];
//        _remainderMoeny.font = [UIFont systemFontOfSize:16];
//    }
//    return _remainderMoeny;
//}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
@end
