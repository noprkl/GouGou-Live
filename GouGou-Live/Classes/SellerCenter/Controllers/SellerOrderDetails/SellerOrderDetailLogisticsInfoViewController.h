//
//  SellerOrderDetailLogisticsInfoViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  

#import "BaseViewController.h"
#import "SellerOrderModel.h"

@interface SellerOrderDetailLogisticsInfoViewController : BaseViewController

@property(nonatomic, strong) NSString *orderState; /**< 订单状态 */

@property(nonatomic, strong) NSString *orderID; /**< 订单id */

@end
