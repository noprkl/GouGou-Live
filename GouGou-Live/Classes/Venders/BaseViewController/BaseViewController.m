//
//  BaseViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"
#import "HTTPTool.h"
#import "HttpImageTool.h"
#import "UIView+Toast.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
#pragma mark
#pragma mark - 网络请求
/** get信息请求 */
- (void)getRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpRequestSuccessBlock)Success
                     error:(HttpRequestErrorBlock)Error {
    [HTTPTool getRequestWithPath:path
                          params:params
                         success:^(id successJson) {
                             Success(successJson);
                         } error:^(NSError *error) {
                             Error(error);
    }];
}

/** post信息请求 */
- (void)postRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpRequestSuccessBlock)Success
                      error:(HttpRequestErrorBlock)Error {
    [HTTPTool postRequestWithPath:path
                           params:params
                          success:^(id successJson) {
                              Success(successJson);
                          }
                            error:^(NSError *error) {
                                Error(error);
    }];
}
- (void)postJsonRequestWithPath:(NSString *)path
                         params:(NSString *)params
                        success:(HttpRequestSuccessBlock)returnSuccess
                          error:(HttpRequestErrorBlock)returnError{
    [HTTPTool postJsonRequestWithPath:path params:params success:^(id   successJson) {
        returnSuccess(successJson);
    } error:^(NSError *error) {
        returnError(error);
    }];
}

- (void)showAlert:(NSString *)string{
    [self.view makeToast:string duration:2 position:@"center"];
}

#pragma mark
#pragma mark - 第三方分享
/** QQ分享 */
- (void)QQShare {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_QQ messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}
/** 新浪分享 */
- (void)SinaShare {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}
/** 微信分享 */
- (void)WChatShare {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}
/** 朋友圈分享 */
- (void)MomentShare {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatTimeLine messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}
/** QQ空间分享 */
- (void)TencentShare {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
