//
//  APIConfig.h
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

/** 信息类服务器 */
#define SERVER_HOST @"http://gougou.itnuc.com/api/"

/** 图片服务器 */
#define IMAGE_HOST @"http://images.itnuc.com"



/** 登录接口 get */
#define API_Login @"UserService/login"

/** 快速登录 get */
#define API_LoginQuick @"UserService/loginQuick"

/** 注册接口 get */
#define API_Register @"UserService/register"

/** 验证码 */
#define API_Code @"UserService/sms"

/** 找回密码 get */
#define API_RetrivePwd @"UserService/retrivePwd"

/** 实名认证 post */
#define API_Authenticate  @"UserService/Authenticate"

/** 商家认证 */
#define API_MerchantAuth @"merchantAuth"

/** 钱包接口 */
#define API_UserAsset @"UserService/getUserAsset"

@end
