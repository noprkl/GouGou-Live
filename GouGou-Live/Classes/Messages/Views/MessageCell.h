//
//  MessageCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) id<IConversationModel> model;

@property (nonatomic) BOOL showAvatar;//default is "YES"

@property(nonatomic, assign) BOOL isFocus; /**< 关注与否 */

@property(nonatomic, strong) NSDictionary *listInfo; /**< 列表信息 */

@end
