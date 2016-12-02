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

- (void)costWithFreightPrice:(NSString *)freghtPrice fontMoneyLabel:(NSString *)fontLabel fontMoney:(NSString *)fontMoney backMoneyLable:(NSString *)backLabel backMoney:(NSString *)backMoney;
/** 花费模型 */
@property (strong,nonatomic) CostModel *costModel;

@end
