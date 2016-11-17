//
//  SellerCostView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerCostView : UIView

/** 交易金额 */
@property (strong,nonatomic) NSString *moneyMessage;

@property(nonatomic, strong) NSArray *messages; /**< 花费信息 */

@end
