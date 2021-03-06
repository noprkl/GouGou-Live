//
//  PlayBackViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/12/25.
//  Copyright © 2016年 LXq. All rights reserved.
//  回放

#import "BaseViewController.h"

@interface PlayBackViewController : BaseViewController

@property (strong,nonatomic) NSString *liveID; /**< 直播播放地址 */
@property (nonatomic, strong) NSString *liverId; /**< 主播id */
@property (nonatomic, strong) NSString *liverIcon; /**< 主播头像 */
@property (nonatomic, strong) NSString *liverName; /**< 主播名字 */
@property (nonatomic, strong) NSString *watchCount; /**< 观看人数 */
@property (nonatomic, strong) NSString *chatRoomID; /**< 聊天室id */

@property (nonatomic, assign) BOOL isDogCard; /**< 点击狗狗开案进入 */
@property (nonatomic, strong) NSString *state; /**< 直播状态 */

@property (nonatomic, assign) BOOL isLandscape; /**< 是否为横屏 */
@end
