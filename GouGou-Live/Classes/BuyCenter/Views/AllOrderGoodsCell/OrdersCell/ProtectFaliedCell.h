//
//  ProtectFaliedCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProtectProwerTableModel;
typedef void(^CopyOrderidFailBlock)();
@interface ProtectFaliedCell : UITableViewCell
/** 订单模型 */
@property (strong,nonatomic) ProtectProwerTableModel *protectModel;

@property (nonatomic, strong) CopyOrderidFailBlock copyBlock; /**< 复制 */

@end
