//
//  WaitAllNickModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@interface WaitAllNickModel : BaseModel
/** 买家名称 */
@property (copy,nonatomic) NSString *merchantName;
/** 订单状态 */
@property (copy,nonatomic) NSString *status;
@end
