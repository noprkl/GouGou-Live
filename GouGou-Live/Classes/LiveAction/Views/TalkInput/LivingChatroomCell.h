//
//  LivingChatroomCell.h
//  GouGou-Live
//
//  Created by ma c on 17/1/2.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivingChatroomCell : UITableViewCell

@property (nonatomic, strong) EMMessage *message; /**< 消息 */

@property (nonatomic, strong) NSString *owner; /**< 拥有者 */

- (CGFloat)getCellHeight;
@end
