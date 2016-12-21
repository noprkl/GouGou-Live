//
//  SellerCloseCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerBaseCell.h"

typedef void(^ClickDeleBtnBlock)();

@interface SellerCloseCell : SellerBaseCell

@property(nonatomic, strong) NSString *orderState; /**< 订单状态 */

@property(nonatomic, strong) NSArray *costMessage; /**< 付款情况 */

@property(nonatomic, strong) ClickDeleBtnBlock deleBlock; /**< 删除回调 */

@property(nonatomic, strong) SellerOrderModel *model; /**< 模型 */

@end
