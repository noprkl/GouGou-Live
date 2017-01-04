//
//  LoginViewController+ThirdLogin.m
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LoginViewController+ThirdLogin.h"
#import <UMSocialCore/UMSocialCore.h>
#import "HTTPTool.h"
#import "UIView+Toast.h"

@implementation LoginViewController (ThirdLogin)
+ (void)WChatLogin:(LoginSuccessBlock)success unBinding:(LoginUnBindingBlock)unBinding{
    if (![[UserInfos sharedUser].wxopenid isEqual:[NSNull null]] && ![[UserInfos sharedUser].wxopenid isEqualToString:@""]) {
                NSDictionary *dict = @{
                                       @"type":@"1",
                                       @"name":[UserInfos sharedUser].wxopenid
                                       };
        [HTTPTool getRequestWithPath:API_Login_binding params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
             success(successJson);
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }else{
               unBinding();
    }
}
+ (void)QQLogin:(LoginSuccessBlock)success unBinding:(LoginUnBindingBlock)unBinding{
    if (![[UserInfos sharedUser].qqopenid isEqual:[NSNull null]] && ![[UserInfos sharedUser].qqopenid isEqualToString:@""]) {
        NSDictionary *dict = @{
                               @"type":@"2",
                               @"name":[UserInfos sharedUser].qqopenid
                               };
        [HTTPTool getRequestWithPath:API_Login_binding params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            success(successJson);
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];

    }else{
                   unBinding();
    }
}
+ (void)SinaLogin:(LoginSuccessBlock)success unBinding:(LoginUnBindingBlock)unBinding{
    
    if (![[UserInfos sharedUser].wbopenid isEqual:[NSNull null]] && ![[UserInfos sharedUser].wbopenid isEqualToString:@""]) {
        NSDictionary *dict = @{
                               @"type":@"3",
                               @"name":[UserInfos sharedUser].wbopenid
                               };
        [HTTPTool getRequestWithPath:API_Login_binding params:dict success:^(id successJson) {
            success(successJson);
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];

    }else{
        unBinding();
    }
}
// 设置个人信息
- (void)saveUserWithID:(NSString *)ID
              user_pwd:(NSString *)user_pwd
          user_img_url:(NSString *)user_img_url
             user_name:(NSString *)user_name
        user_nick_name:(NSString *)user_nick_name
              user_tel:(NSString *)user_tel
           is_merchant:(NSString *)is_merchant
               is_real:(NSString *)is_real
            user_motto:(NSString *)user_motto
         user_pay_code:(NSString *)user_pay_code
         user_ali_code:(NSString *)user_ali_code
            qq_open_id:(NSString *)qq_open_id
            wx_open_id:(NSString *)wx_open_id
            wb_open_id:(NSString *)wb_open_id
           user_status:(NSString *)user_status

{
    [UserInfos sharedUser].userimgurl = ![user_img_url isEqual:[NSNull null]] ?user_img_url:@"";
    [UserInfos sharedUser].username = ![user_name isEqual:[NSNull null]] ?user_name:@"";
    [UserInfos sharedUser].usernickname = ![user_nick_name isEqual:[NSNull null]] ?user_nick_name:@"";
    [UserInfos sharedUser].usermotto = ![user_motto isEqual:[NSNull null]] ? user_motto:@"";
    [UserInfos sharedUser].useralicode = ![user_ali_code isEqual:[NSNull null]] ? user_ali_code:@"";
    [UserInfos sharedUser].userpaycode = ![user_pay_code isEqual:[NSNull null]] ? user_pay_code:@"";
    
    [UserInfos sharedUser].wxopenid = ![wx_open_id isEqual:[NSNull null]] ? wx_open_id:@"";
    [UserInfos sharedUser].wbopenid = ![wb_open_id isEqual:[NSNull null]] ? wb_open_id:@"";
    [UserInfos sharedUser].qqopenid = ![qq_open_id isEqual:[NSNull null]] ? qq_open_id:@"";
    
    [UserInfos sharedUser].isreal = is_real;
    [UserInfos sharedUser].ismerchant = is_merchant;
    [UserInfos sharedUser].ID = ID;
    [UserInfos sharedUser].userPsd = user_pwd;
    [UserInfos sharedUser].usertel = user_tel;
    
    
    [UserInfos setUser];
}

@end
