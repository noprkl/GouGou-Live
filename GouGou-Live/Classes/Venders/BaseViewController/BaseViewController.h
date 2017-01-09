//
//  BaseViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HttpRequestSuccessBlock)(id successJson);
typedef void(^HttpRequestErrorBlock)(NSError *error);

@interface BaseViewController : UIViewController <TZImagePickerControllerDelegate>

/** get请求 */
- (void)getRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpRequestSuccessBlock)Success
                     error:(HttpRequestErrorBlock)Error;
/** post请求 */
- (void)postRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpRequestSuccessBlock)Success
                      error:(HttpRequestErrorBlock)Error;

// 提示字符
- (void)showAlert:(NSString *)string;
/** 指示器展示 */
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;
/** 指示器隐藏 */
- (void)hideHud;
- (void)setNavBarItem;

#pragma mark
#pragma mark - 分享
/** QQ分享 */
- (void)QQShare;
/** 新浪分享 */
- (void)SinaShare;
/** 微信分享 */
- (void)WChatShare;
/** 朋友圈分享 */
- (void)WechatTimeShare;
/** QQ空间分享 */
- (void)TencentShare;
/** 在线客服 */
- (void)clickServiceBtnAction;

/** 钱包支付 */
//- (void)walletPayWithOrderId:(int)orderID price:(int)price payPwd:(NSString *)payPwd states:(int)state;
///** 微信支付 */
//- (void)WeChatPayWithOrderID:(int)orderID totalFee:(int)fee mark:(NSString *)mark;
///** 支付宝支付 */
//- (void)aliPayWithOrderId:(int)orderID totalFee:(int)fee;

@end
