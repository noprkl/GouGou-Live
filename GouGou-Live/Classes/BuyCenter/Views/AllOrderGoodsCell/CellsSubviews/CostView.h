//
//  costView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostModel.h"

@interface CostView : UIView
/** 交易金额 */
@property (strong,nonatomic) NSString *moneyMessage;

/** 运费数 */
@property (strong,nonatomic) UILabel *freightMoney;
/** 定金 */
@property (strong,nonatomic) UILabel *fontMoney;
/** 尾款 */
@property (strong,nonatomic) UILabel *remainderMoeny;
/** 运费 */
@property (strong,nonatomic) UILabel *freightLabel;
/** 已付定金 */
@property (strong,nonatomic) UILabel *fontMoneyLabel;
/** 已付尾款 */
@property (strong,nonatomic) UILabel *remainderMoneylabel;

- (void)costWithFreightPrice:(NSString *)freghtPrice fontMoneyLabel:(NSString *)fontLabel fontMoney:(NSString *)fontMoney backMoneyLable:(NSString *)backLabel backMoney:(NSString *)backMoney;
///** 花费模型 */
//@property (strong,nonatomic) CostModel *costModel;

@end
