//
//  TalkingViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EaseMessageViewController.h"
#import "TalkingView.h"

@interface TalkingViewController : EaseMessageViewController

@property(nonatomic, strong) UITextField *textField; /**< 输入框 */

@property(nonatomic, strong) NSString *roomID; /**< 聊天房间id */

@property (nonatomic, strong) NSString *liverid; /**< 主播id */

@property (nonatomic, assign) BOOL ishidText; /**< 隐藏 */

@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入框 */
@property (nonatomic, assign) BOOL isNotification; /**< 是否监听 */
@end
