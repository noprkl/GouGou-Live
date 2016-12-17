//
//  SellerOrderDetailAdressViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  

#import "BaseViewController.h"
#import "SellerOrderModel.h"

@interface SellerOrderDetailAdressViewController : BaseViewController

@property(nonatomic, strong) NSString *orderState; /**< 订单状态 */

@property(nonatomic, strong) NSArray *bottomBtns; /**< 底部按钮数组 */

@property(nonatomic, strong) SellerOrderModel *model; /**< 模型 */

@property(nonatomic, strong) NSString *orderID; /**< 订单id */

@end
