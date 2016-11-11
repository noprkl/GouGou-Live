//
//  UserInfos.h
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//  存储用户信息的单例

#import <Foundation/Foundation.h>

@interface UserInfos : NSObject

@property(nonatomic, copy) NSString *ID; /**< 用户id */

@property(nonatomic, copy) NSString *usernickname; /**< 用户昵称 */

@property(nonatomic, strong) NSString *username; /**< 用户名*/

@property(nonatomic, copy) NSString *usertel; /**< 用户手机号 */

@property(nonatomic, copy) NSString *userimgurl; /**< 用户头像 */

@property(nonatomic, strong) NSString *usermotto; /**< 用户签名 */

@property(nonatomic, copy) NSString *ismerchant; /**< 是否商家验证 */

@property(nonatomic, copy) NSString *isreal; /**< 是否进行实名认证 */

@property(nonatomic, assign) BOOL isLogin; /**< 是否登录 */

+ (instancetype)sharedUser;

+ (void)setUser;

+ (BOOL)getUser;

+ (void)removeUser;
@end
