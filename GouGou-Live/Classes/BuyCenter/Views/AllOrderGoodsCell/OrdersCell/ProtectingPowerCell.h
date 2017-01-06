//
//  ProtectingPowerCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CopyOrderidProtectingBlock)();
@class ProtectProwerTableModel;

@interface ProtectingPowerCell : UITableViewCell
/** 订单模型 */
@property (strong,nonatomic) ProtectProwerTableModel *protectModel;

@property (nonatomic, strong) CopyOrderidProtectingBlock copyBlock; /**< 复制 */
@end
