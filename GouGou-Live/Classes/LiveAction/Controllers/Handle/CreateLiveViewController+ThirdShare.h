//
//  CreateLiveViewController+ThirdShare.h
//  GouGou-Live
//
//  Created by ma c on 16/12/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CreateLiveViewController.h"

@interface CreateLiveViewController (ThirdShare)
#pragma mark - 分享
/** QQ分享 */
+ (void)QQShare:(NSString *)liveUrl;
/** 新浪分享 */
+ (void)SinaShare:(NSString *)liveUrl;
/** 微信分享 */
+ (void)WChatShare:(NSString *)liveUrl;
/** 朋友圈分享 */
+ (void)WechatTimeShare:(NSString *)liveUrl;
/** QQ空间分享 */
+ (void)TencentShare:(NSString *)liveUrl;

@end
