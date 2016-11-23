//
//  LoginViewController+ThirdLogin.h
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//  第三方登录

#import "LoginViewController.h"

@interface LoginViewController (ThirdLogin)

+ (void)QQLogin;
+ (void)SinaLogin;
+ (void)WChatLogin;
@end
