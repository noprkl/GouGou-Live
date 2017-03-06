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
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"狗狗直播" descr:@"发现身边的那个它" thumImage:[UIImage imageNamed:@"shareIcon"]];
    //设置网页地址
    shareObject.webpageUrl = ShareAdress;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

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
    messageObject.text = [NSString stringWithFormat:@"狗狗直播，发现身边的那个它\n%@", ShareAdress];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"shareIcon"];
    [shareObject setShareImage:@"http://images.itnuc.com/product/ce331707a0c56ca8a2bd64df7b37b237.jpeg"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
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
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"狗狗直播" descr:@"发现身边的那个它" thumImage:[UIImage imageNamed:@"shareIcon"]];
    //设置网页地址
    shareObject.webpageUrl = ShareAdress;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    
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
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"狗狗直播" descr:@"发现身边的那个它" thumImage:[UIImage imageNamed:@"shareIcon"]];
    //设置网页地址
    shareObject.webpageUrl = ShareAdress;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    
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
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"狗狗直播" descr:@"发现身边的那个它" thumImage:[UIImage imageNamed:@"shareIcon"]];
    //设置网页地址
    shareObject.webpageUrl = ShareAdress;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    
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
