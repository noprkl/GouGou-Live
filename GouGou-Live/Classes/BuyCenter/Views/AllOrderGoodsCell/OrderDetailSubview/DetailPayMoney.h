//
//  DetailPayMoney.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPayMoney : UIView
/**< 尾款 */
@property (copy, nonatomic) NSString *balance;
/**< 实付款 */
@property (copy, nonatomic) NSString *realMoney;
/** 尾款 */
@property (strong,nonatomic) NSString *needBackMessage;
/** 定金 */
@property (strong,nonatomic) NSString *fontMoneyMessage;
@end
