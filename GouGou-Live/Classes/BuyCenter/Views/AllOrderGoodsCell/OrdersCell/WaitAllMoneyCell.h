//
//  WaitAllMoneyCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCenterModel.h"

typedef void(^CancelAllOrderBlock)();

@interface WaitAllMoneyCell : UITableViewCell

@property (copy, nonatomic) BuyCenterModel *centerModel; /**< 模型 */

@property (nonatomic, strong) CancelAllOrderBlock cancelBlock; /**< <#注释#> */

@end
