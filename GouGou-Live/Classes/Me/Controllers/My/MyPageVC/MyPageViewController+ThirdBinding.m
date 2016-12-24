//
//  MyPageViewController+ThirdBinding.m
//  GouGou-Live
//
//  Created by ma c on 16/12/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyPageViewController+ThirdBinding.h"
#import <UMSocialCore/UMSocialCore.h>
#import "HTTPTool.h"
#import "NSString+MD5Code.h"

@implementation MyPageViewController (ThirdBinding)
+ (void)WChatLogin {
    if (![[UserInfos sharedUser].wxopenid isEqual:[NSNull null]] && ![[UserInfos sharedUser].wxopenid isEqualToString:@""]) {
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
            DLog(@"%@", authresponse.uid);
            
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
    if (![[UserInfos sharedUser].qqopenid isEqual:[NSNull null]] && ![[UserInfos sharedUser].qqopenid isEqualToString:@""]) {
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
            DLog(@"%@", authresponse.uid);
            
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
    if (![[UserInfos sharedUser].wbopenid isEqual:[NSNull null]] && ![[UserInfos sharedUser].wbopenid isEqualToString:@""]) {
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
            DLog(@"%@", authresponse.uid);
            NSDictionary *dict = @{
                                   @"type":@"3",
                                   @"name":authresponse.uid,
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue])
                                   };
            DLog(@"%@", dict);
            // 绑定新浪
            [HTTPTool getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
        }];
        
    }
}
@end
