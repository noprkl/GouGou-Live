//
//  MediaStreamChatRoomVcViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/12/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EaseMessageViewController.h"

@interface MediaStreamChatRoomVcViewController : EaseMessageViewController
@property(nonatomic, strong) UITextField *textField; /**< 输入框 */

@property(nonatomic, strong) NSString *roomID; /**< 聊天房间id */
@end
