//
//  CreateLiveViewController+ThirdShare.h
//  GouGou-Live
//
//  Created by ma c on 16/12/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CreateLiveViewController.h"
#import "LiveListStreamModel.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

typedef void(^ShareScuccess)();

@interface CreateLiveViewController (ThirdShare)
#pragma mark - 分享
/** QQ分享 */
+ (void)QQShare:(NSString *)liveUrl success:(ShareScuccess)success;
/** 新浪分享 */
+ (void)SinaShare:(NSString *)liveUrl success:(ShareScuccess)success;
/** 微信分享 */
+ (void)WChatShare:(NSString *)liveUrl success:(ShareScuccess)success;
/** 朋友圈分享 */
+ (void)WechatTimeShare:(NSString *)liveUrl success:(ShareScuccess)success;
/** QQ空间分享 */
+ (void)TencentShare:(NSString *)liveUrl success:(ShareScuccess)success;

@end
