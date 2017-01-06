//
//  WaitBackMoneyCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCenterModel.h"

@class NickNameModel;

typedef void(^CancelBackOrderBlock)();

@interface WaitBackMoneyCell : UITableViewCell
/** 订单模型 */
@property (strong,nonatomic) BuyCenterModel *centerModel;

@property (nonatomic, strong) CancelBackOrderBlock cancelBlock; /**< 倒计时结束 */

@end
