//
//  PayBackMoneyViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  尾款待支付详情

#import "BuyCenterViewController.h"
@class OrderDetailModel;

@interface PayBackMoneyViewController : BuyCenterViewController
/** 订单详情模型 */
@property (strong,nonatomic) OrderDetailModel *detailModel;

@end
