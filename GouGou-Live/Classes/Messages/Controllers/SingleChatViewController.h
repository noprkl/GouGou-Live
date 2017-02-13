//
//  SingleChatViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//  单聊控制器 

#import "EaseMessageViewController.h"

@interface SingleChatViewController : EaseMessageViewController

@property (nonatomic, strong) NSString *chatID; /**< 聊天ID */


@property (nonatomic, strong) NSString *iconUrl; /**< 头像 */

@property (nonatomic, strong) NSString *nameStr; /**< 名字 */

@end
