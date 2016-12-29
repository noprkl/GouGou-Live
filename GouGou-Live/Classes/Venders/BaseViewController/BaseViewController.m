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
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
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
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
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
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
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
    //设置文本
    messageObject.text = @"狗狗直播，狗狗直播，狗狗直播";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Qzone messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            DLog(@"************QQ空间 fail with error %@*********",error);
        }else{
            DLog(@"response data is %@",data);
        }
    }];
}

/** 钱包支付 2定金 3全款 */
//- (void)walletPayWithOrderId:(int)orderID price:(int)price payPwd:(NSString *)payPwd states:(int)state {
//    NSDictionary *dict = @{
//                           @"user_id":@([[UserInfos sharedUser].ID intValue]),
//                           @"order_id":@(orderID),
//                           @"user_price":@(price),
//                           @"user_pwd":payPwd,
//                           @"status":@(state)
//                           };
//    [self postRequestWithPath:API_Wallet params:dict success:^(id successJson) {
//        DLog(@"%@", successJson);
//    } error:^(NSError *error) {
//        DLog(@"%@", error);
//    }];
//}
//
///** 微信支付 */
//- (void)WeChatPayWithOrderID:(int)orderID totalFee:(int)fee mark:(NSString *)mark {
//    // /gougou.itnuc.com/weixinpay/wxapi.php?order=wx12345678&total_fee=1&mark=testpya
//
//    NSDictionary *dict = @{
//                           @"order":@(orderID),
//                           @"total_fee":@(fee),
//                           @"mark":mark
//                           };
//    DLog(@"%@", dict);
//    [self getRequestWithPath:@"weixinpay/wxapi.php" params:dict success:^(id successJson) {
//        DLog(@"%@", successJson);
//        PayReq * req = [[PayReq alloc] init];
//        req.partnerId = [successJson objectForKey:@"partnerid"];
//        req.prepayId = [successJson objectForKey:@"prepayid"];
//        req.nonceStr = [successJson objectForKey:@"noncestr"];
//        NSNumber *timeStamp = [successJson objectForKey:@"timestamp"];
//        req.timeStamp = [timeStamp intValue];
//        
//        req.package = [successJson objectForKey:@"package"];
//        req.sign = [successJson objectForKey:@"sign"];
//        req.openID = [successJson objectForKey:@"appid"];
//        
//        DLog(@"sign:%@, openID:%@, partnerId:%@, prepayId:%@, nonceStr:%@, timeStamp:%u, package:%@", req.sign, req.openID, req.partnerId, req.prepayId, req.nonceStr, req.timeStamp, req.package);
//        
//        BOOL flag = [WXApi sendReq:req];
//        if (flag) {
//            DLog(@"支付成功");
//        }else{
//            DLog(@"支付失败");
//        }
//        
//    } error:^(NSError *error) {
//        DLog(@"%@", error);
//    }];
//}
///** 支付宝支付 */
//- (void)aliPayWithOrderId:(int)orderID totalFee:(int)fee {
//    //htp://gougou.itnuc.com/appalipay/signatures_url.php?id=111111111111&total_fee=1
//        NSDictionary *dit = @{
//                              @"id":@(orderID),
//                              @"total_fee":@(fee)
//                              };
//        [self getRequestWithPath:@"appalipay/signatures_url.php" params:dit success:^(id successJson) {
//            DLog(@"%@", successJson);
//            [self showAlert:successJson[@"msg"]];
//            [self aliPayWithOrderString:successJson[@"data"]];
//        } error:^(NSError *error) {
//            DLog(@"%@", error);
//        }];
//}
//- (void)aliPayWithOrderString:(NSString *)orderStr {
//    if (orderStr != nil) {
//        
//        NSString *appScheme = @"ap2016112203105439";
//        
//        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            DLog(@"reslut = %@",resultDic);
//        }];
//    }
//}
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
