//
//  PayMentmodel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface PayMentmodel : BaseModel

@property (nonatomic, strong) NSString *ID; /**< 流水号 */

@property (nonatomic, strong) NSString *orderId; /**< 订单id */

@property (copy, nonatomic) NSString *payMethod; /**< 支付方式 */
@property (copy, nonatomic) NSString *type; /**< 订单类型 */
@property (nonatomic, strong) NSString *assetChangeTime; /**< 交易时间 */
@property (nonatomic, strong) NSString *assetChange; /**< 收入 */
@property (nonatomic, strong) NSString *nowAsset; /**< 余额 */
@property (nonatomic, strong) NSString *assetChangeType; /**< 交易类型 */
@end
