//
//  WaitFontMoneyCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCenterModel.h"

typedef void(^CancelFontOrderBlock)();
@interface WaitFontMoneyCell : UITableViewCell

/** 订单模型 */
@property (strong,nonatomic) BuyCenterModel *centerModel;

@property (nonatomic, strong) CancelFontOrderBlock cancelBlock; /**< 倒计时结束 */

@end
