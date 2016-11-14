//
//  UserInfos.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UserInfos.h"

static NSString *IDKey = @"ID";
static NSString *usernicknameKey = @"usernickname";
static NSString *usernameKey = @"username";
static NSString *usertelKey = @"usertel";
static NSString *userimgurlKey = @"userimgurl";
static NSString *ismerchantKey = @"ismerchant";
static NSString *isrealKey = @"isreal";
static NSString *isLoginKey = @"isLogin";
static NSString *usermottoKey = @"usermotto";
@implementation UserInfos

+ (instancetype)sharedUser {
    
    static UserInfos *_user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[UserInfos alloc] init];
    });
    return _user;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _ID = [[NSUserDefaults standardUserDefaults] objectForKey:IDKey];
        _usernickname = [[NSUserDefaults standardUserDefaults] objectForKey:usernicknameKey];
        _username = [[NSUserDefaults standardUserDefaults] objectForKey:usernameKey];
        _userimgurl = [[NSUserDefaults standardUserDefaults] objectForKey:userimgurlKey];
        _usertel = [[NSUserDefaults standardUserDefaults] objectForKey:usertelKey];
        _ismerchant = [[NSUserDefaults standardUserDefaults] objectForKey:ismerchantKey];
        _isreal = [[NSUserDefaults standardUserDefaults] objectForKey:isrealKey];
        _isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:isLoginKey];
        _usermotto = [[NSUserDefaults standardUserDefaults] objectForKey:usermottoKey];
        }
    return self;
}
+ (void)setUser {
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].ID forKey:IDKey];
//    if ([UserInfos sharedUser].userimgurl != NULL) {
//        [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].userimgurl forKey:userimgurlKey];
//    }

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].userimgurl forKey:userimgurlKey];
//    if ([UserInfos sharedUser].username != NULL) {
//        [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].username forKey:usernameKey];
//    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].username  forKey:usernameKey];
//    if ([UserInfos sharedUser].usermotto != NULL) {
//        [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usermotto forKey:usermottoKey];
//    }
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usermotto forKey:usermottoKey];
   
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usernickname forKey:usernicknameKey];

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usertel forKey:usertelKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].isreal forKey:isrealKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].ismerchant forKey:ismerchantKey];
    [[NSUserDefaults standardUserDefaults] setObject:@([UserInfos sharedUser].isLogin) forKey:isLoginKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getUser {
    
    if ([UserInfos sharedUser].isLogin == YES) {
        
        return YES;
    }
    return NO;
}
+ (void)removeUser {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:usertelKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:usernicknameKey];
    if ([UserInfos sharedUser].userimgurl != NULL) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:userimgurlKey];
    }
    
    if ([UserInfos sharedUser].username != NULL) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:usernameKey];
    }
    if ([UserInfos sharedUser].usermotto != NULL) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:usermottoKey];
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ismerchantKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:isrealKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:IDKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
