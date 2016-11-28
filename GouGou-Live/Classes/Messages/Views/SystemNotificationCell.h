//
//  SystemNotificationCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SystemPushMessageModel;

@interface SystemNotificationCell : UITableViewCell

@property(nonatomic, strong) SystemPushMessageModel *model; /**< 模型 */
- (CGFloat)getCellHeightWithModel:(SystemPushMessageModel *)model;
@end
