//
//  PushOrderMesageModel.h
//  GouGou-Live
//
//  Created by ma c on 17/1/12.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface PushOrderMesageModel : BaseModel

@property (nonatomic, strong) NSString *ID; /**< 订单id */
@property (copy, nonatomic) NSString *status; /**< 订单状态 */

@end
