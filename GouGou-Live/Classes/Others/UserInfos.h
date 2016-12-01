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

@property(nonatomic, strong) NSString *userPsd; /**< 用户密码 */

@property(nonatomic, copy) NSString *usernickname; /**< 用户昵称 */

@property(nonatomic, strong) NSString *username; /**< 用户名*/

@property(nonatomic, copy) NSString *usertel; /**< 用户手机号 */

@property(nonatomic, copy) NSString *userimgurl; /**< 用户头像 */

@property(nonatomic, strong) NSString *usermotto; /**< 用户签名 */

@property(nonatomic, strong) NSString *ismerchant; /**< 商家验证 1：非商家 2：商家 3：审核中 4: 审核失败 */

@property(nonatomic, strong) NSString *isreal; /**< 实名认证 1.未认证 2.审核 3.已认证 4.认证失败 */

@property(nonatomic, strong) NSString *userpaycode; /**< 支付密码 */

+ (instancetype)sharedUser;

+ (void)setUser;

+ (BOOL)getUser;

+ (void)removeUser;
@end
