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

@implementation LoginViewController (ThirdLogin)
+ (void)WChatLogin {
    if (![[UserInfos sharedUser].wxopenid isEqual:[NSNull null]]) {
                NSDictionary *dict = @{
                                       @"type":@"1",
                                       @"name":[UserInfos sharedUser].wxopenid
                                       };
        [HTTPTool getRequestWithPath:API_Login_binding params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }else{
        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            //        [self.tableView reloadData];
            UMSocialAuthResponse *authresponse = result;
//            NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
            NSDictionary *dict = @{
                                   @"type":@"1",
                                   @"name":authresponse.uid,
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue])
                                   };
            [HTTPTool getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }];
        
    }
}
+ (void)QQLogin {
    if (![[UserInfos sharedUser].qqopenid isEqual:[NSNull null]]) {
        NSDictionary *dict = @{
                               @"type":@"2",
                               @"name":[UserInfos sharedUser].qqopenid
                               };
        [HTTPTool getRequestWithPath:API_Login_binding params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];

    }else{
        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
            //        [self.tableView reloadData];
            UMSocialAuthResponse *authresponse = result;
//            NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
            // 绑定QQ
            NSDictionary *dict = @{
                                   @"type":@"2",
                                   @"name":authresponse.uid,
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue])
                                   };
            [HTTPTool getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }];
    
    }
}
+ (void)SinaLogin {
    if (![[UserInfos sharedUser].wbopenid isEqual:[NSNull null]]) {
        NSDictionary *dict = @{
                               @"type":@"3",
                               @"name":[UserInfos sharedUser].wbopenid
                               };
        [HTTPTool getRequestWithPath:API_Login_binding params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];

    }else{
        [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
            //        [self.tableView reloadData];
            UMSocialAuthResponse *authresponse = result;
//            NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
            NSDictionary *dict = @{
                                   @"type":@"3",
                                   @"name":authresponse.uid,
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue])
                                   };
            // 绑定新浪
            [HTTPTool getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
        }];
    
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
