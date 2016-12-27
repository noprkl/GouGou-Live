//
//  LivingViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//  直播

#import "BaseViewController.h"

@interface LivingViewController : BaseViewController

@property (strong,nonatomic) NSString *liveID; /**< 直播播放地址 */
@property (nonatomic, strong) NSString *liverId; /**< 主播id */
@property (nonatomic, strong) NSString *liverIcon; /**< 主播头像 */
@property (nonatomic, strong) NSString *liverName; /**< 主播名字 */
@property (nonatomic, strong) NSString *watchCount; /**< 观看人数 */
@property (nonatomic, strong) NSString *chatRoomID; /**< 聊天室id */

@property (nonatomic, strong) NSArray *doginfos; /**< 该主播商品所有数据 */
@property (nonatomic, assign) BOOL isDogCard; /**< 点击狗狗开案进入 */
@property (nonatomic, strong) NSString *state; /**< 直播状态 */

@property (nonatomic, assign) BOOL isLandscape; /**< 是否为横屏 */

/** 是否选中 */
@property (assign,nonatomic) BOOL isSelectCollectBtn;

@end
