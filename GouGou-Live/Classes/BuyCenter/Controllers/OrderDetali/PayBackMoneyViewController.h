//
//  PayBackMoneyViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  尾款待支付详情

#import "BuyCenterViewController.h"

@class BuyCenterModel;

@interface PayBackMoneyViewController : BuyCenterViewController
//** 订单ID */
@property (strong,nonatomic) NSString *orderID;

@end
