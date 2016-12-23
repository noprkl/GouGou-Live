//
//  CreateLiveViewController+ThirdShare.m
//  GouGou-Live
//
//  Created by ma c on 16/12/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CreateLiveViewController+ThirdShare.h"
#import "MediaStreamingVc.h"
@implementation CreateLiveViewController (ThirdShare)
#pragma mark - 第三方分享
/** QQ分享 */
+ (void)QQShare:(NSString *)liveUrl success:(ShareScuccess)success {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"\n狗狗直播，狗狗直播，狗狗直播\n%@", liveUrl];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************QQ分享 fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
            if (success) {
                success();
            }
        }
    }];
}
/** 新浪分享 */
+ (void)SinaShare:(NSString *)liveUrl success:(ShareScuccess)success {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"\n狗狗直播，狗狗直播，狗狗直播\n%@", liveUrl];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************新浪分享 fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
            if (success) {
                success();
            }
        }
    }];
}
/** 微信分享 */
+ (void)WChatShare:(NSString *)liveUrl success:(ShareScuccess)success {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"\n狗狗直播，狗狗直播，狗狗直播\n%@", liveUrl];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************微信分享 fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
            if (success) {
                success();
            }
        }
    }];
}
/** 朋友圈分享 */
+ (void)WechatTimeShare:(NSString *)liveUrl success:(ShareScuccess)success {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"\n狗狗直播，狗狗直播，狗狗直播\n%@", liveUrl];
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************朋友圈分享 fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
            if (success) {
                success();
            }
        }
    }];
}
/** QQ空间分享 */
+ (void)TencentShare:(NSString *)liveUrl success:(ShareScuccess)success {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = [NSString stringWithFormat:@"\n狗狗直播，狗狗直播，狗狗直播\n%@", liveUrl];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************QQ空间 fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
            if (success) {
                success();
            }
        }
    }];
}
@end
