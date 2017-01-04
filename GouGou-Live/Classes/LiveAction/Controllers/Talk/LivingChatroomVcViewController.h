//
//  LivingChatroomVcViewController.h
//  GouGou-Live
//
//  Created by ma c on 17/1/2.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BaseViewController.h"

@interface LivingChatroomVcViewController : BaseViewController

@property(nonatomic, strong) NSString *roomID; /**< 聊天房间id */

@property (nonatomic, strong) NSString *liverid; /**< 创建者id */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end
