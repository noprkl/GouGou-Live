//
//  PayingMoney.h
//  GouGou-Live
//
//  Created by ma c on 16/11/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayingMoney : UIView
/** 实付定金 */
@property (copy,nonatomic) NSString *productRealDeposit;
/** 实付尾款 */
@property (copy,nonatomic) NSString *realLalance;

/** 全款数 */
@property (strong,nonatomic) NSString *totalMoney;

@end
