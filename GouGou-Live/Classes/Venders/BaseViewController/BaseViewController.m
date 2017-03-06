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
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import "HUDView.h"

@interface BaseViewController ()<MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) MBProgressHUD *hud; /**< 指示器 */

@property (nonatomic, strong) HUDView *hudView; /**< 指示器 */

@end

@implementation BaseViewController
#pragma mark
#pragma mark - 网络请求
/** get信息请求 */
- (void)getRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpRequestSuccessBlock)Success
                     error:(HttpRequestErrorBlock)Error {
//    [self showHudInView:self.view hint:@"加载中.."];
    [HTTPTool getRequestWithPath:path
                          params:params
                         success:^(id successJson) {
                             Success(successJson);
                         } error:^(NSError *error) {
                             DLog(@"请求异常");
                             Error(error);
                             [self hideHud];
    }];
}

/** post信息请求 */
- (void)postRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpRequestSuccessBlock)Success
                      error:(HttpRequestErrorBlock)Error {
//    [self showHudInView:self.view hint:@"加载中.."];
    [HTTPTool postRequestWithPath:path
                           params:params
                          success:^(id successJson) {
                              Success(successJson);
                          }
                            error:^(NSError *error) {
                                DLog(@"请求异常");
                                [self hideHud];
                                Error(error);
    }];
}
#pragma mark
#pragma mark - 指示器
- (void)showAlert:(NSString *)string{
    [self showHint:string yOffset:-200];
}

// 显示
//- (void)showHudInView:(UIView *)view hint:(NSString *)hint {
////    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
////    DLog(@"%@", NSStringFromCGRect(view.frame));
////    
////    hud.labelText = hint;
////    [view addSubview:hud];
////    [hud show:YES];
////    self.hud = hud;
//    
//    
//    HUDView *hudView = [[HUDView alloc] init];
//    self.hudView = hudView;
//    hudView.alertStr = hint;
//    [hudView show];
//    // 20自动消失
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hideHud];
//    });
//    
//}
// 隐藏
//- (void)hideHud {
//    [self.hud hide:YES];
//    [self.hud removeFromSuperview];
//    [self.hudView dismiss];
//}
//- (MBProgressHUD *)hud {
//    if (!_hud) {
//        _hud = [[MBProgressHUD alloc] initWithView:self.view];
//        DLog(@"%f--%f", SCREEN_HEIGHT, SCREEN_WIDTH);
//    }
//    return _hud;
//}
#pragma mark
#pragma mark - 第三方分享
/** QQ分享 */
- (void)QQShare {
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
        }
    }];
}
/** 新浪分享 */
- (void)SinaShare {
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
        }
    }];
}
/** 微信分享 */
- (void)WChatShare {
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
        }
    }];
}
/** 朋友圈分享 */
- (void)WechatTimeShare {
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
        }
    }];
}
/** QQ空间分享 */
- (void)TencentShare {
    
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
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
/** 在线客服 */
- (void)clickServiceBtnAction {
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://18401703756"]];
    
    if ([MFMessageComposeViewController canSendText]) {// 判断是否支持发送短信
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init]; //autorelease];
        
        controller.recipients = [NSArray arrayWithObject:SMSPhone];
        controller.body = @"";
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:^{
            
        }];
        //修改短信界面标题
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"短信发送"];
    }else{
        [self showAlert:@"不支持发送短信"];
    }
}
#pragma mark
#pragma mark - 短信发送协议
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:NO completion:^{
        
    }];//关键的一句   不能为YES
    
    switch ( result ) {
            
        case MessageComposeResultCancelled:
            
            [self showAlert:@"取消发送"];
            break;
        case MessageComposeResultFailed:// send failed
            [self showAlert:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self showAlert:@"发送成功"];
            break;
        default:
            break;
    }
}

// 支持旋转的方向 只允许竖屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
