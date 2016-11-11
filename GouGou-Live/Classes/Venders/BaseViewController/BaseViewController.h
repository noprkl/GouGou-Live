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

@interface BaseViewController : UIViewController

- (void)QQLogin;
- (void)WXLogin;
- (void)SinaLogin;

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
- (void)postJsonRequestWithPath:(NSString *)path
                         params:(NSString *)params
                        success:(HttpRequestSuccessBlock)returnSuccess
                          error:(HttpRequestErrorBlock)returnError;
#pragma mark
#pragma mark - 图片
/** get请求 */
- (void)getImageRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpRequestSuccessBlock)Success
                     error:(HttpRequestErrorBlock)Error;
/** post请求 */
- (void)postImageRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpRequestSuccessBlock)Success
                      error:(HttpRequestErrorBlock)Error;

// 提示字符
- (void)showAlert:(NSString *)string;
- (void)setNavBarItem;
@end
