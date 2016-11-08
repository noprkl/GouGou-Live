//
//  UserInfos.h
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//  存储用户信息的单例

#import <Foundation/Foundation.h>

@interface UserInfos : NSObject

@property(nonatomic, assign) BOOL isLogin; /**< 是否登录 */

//+ (instancetype)shareUserInfo;

@end
