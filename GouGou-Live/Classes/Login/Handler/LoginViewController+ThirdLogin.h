//
//  LoginViewController+ThirdLogin.h
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//  第三方登录

#import "LoginViewController.h"

typedef void(^LoginSuccessBlock)(id success);
typedef void(^LoginUnBindingBlock)();
@interface LoginViewController (ThirdLogin)

+ (void)QQLogin:(LoginSuccessBlock)success unBinding:(LoginUnBindingBlock)unBinding;
+ (void)SinaLogin:(LoginSuccessBlock)success unBinding:(LoginUnBindingBlock)unBinding;
+ (void)WChatLogin:(LoginSuccessBlock)success unBinding:(LoginUnBindingBlock)unBinding;
@end
