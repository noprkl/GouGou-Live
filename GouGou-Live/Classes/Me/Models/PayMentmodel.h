//
//  PayMentmodel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface PayMentmodel : BaseModel
@property (copy, nonatomic) NSString *payMent; /**< 支付方式 */
@property (copy, nonatomic) NSString *type; /**< 订单类型 */

@end
