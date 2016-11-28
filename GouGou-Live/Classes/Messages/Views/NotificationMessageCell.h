//
//  NotificationMessageCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SystemPushMessageModel;
@interface NotificationMessageCell : UITableViewCell

@property(nonatomic, strong) SystemPushMessageModel *model; /**< 模型 */

@property(nonatomic, assign) NSInteger unReadCount; /**< 未读 */

@end
