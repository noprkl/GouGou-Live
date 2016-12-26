//
//  UserInfos.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UserInfos.h"

static NSString *IDKey = @"ID";
static NSString *userPsdKey = @"userPsd";
static NSString *usernicknameKey = @"usernickname";
static NSString *usernameKey = @"username";
static NSString *usertelKey = @"usertel";
static NSString *userimgurlKey = @"userimgurl";
static NSString *ismerchantKey = @"ismerchant";
static NSString *isrealKey = @"isreal";
static NSString *usermottoKey = @"usermotto";
static NSString *useralicodeKey = @"useralicode";
static NSString *userpaycodeKey = @"userpaycode";
static NSString *wxopenidKey = @"wxopenid";
static NSString *wbopenidKey = @"wbopenid";
static NSString *qqopenidKey = @"qqopenid";
static NSString *fansCountKey = @"fansCount";
static NSString *commentCountKey = @"commentCount";
static NSString *focusCountKey = @"focusCountKey";
static NSString *userAssetKey = @"userAsset";

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
        _userPsd = [[NSUserDefaults standardUserDefaults] objectForKey:userPsdKey];

        _usernickname = [[NSUserDefaults standardUserDefaults] objectForKey:usernicknameKey];
        _username = [[NSUserDefaults standardUserDefaults] objectForKey:usernameKey];
        _userimgurl = [[NSUserDefaults standardUserDefaults] objectForKey:userimgurlKey];
        _usertel = [[NSUserDefaults standardUserDefaults] objectForKey:usertelKey];
        _ismerchant = [[NSUserDefaults standardUserDefaults] objectForKey:ismerchantKey];
        _isreal = [[NSUserDefaults standardUserDefaults] objectForKey:isrealKey];
        _usermotto = [[NSUserDefaults standardUserDefaults] objectForKey:usermottoKey];
        _useralicode = [[NSUserDefaults standardUserDefaults] objectForKey:useralicodeKey];
        _userpaycode = [[NSUserDefaults standardUserDefaults] objectForKey:userpaycodeKey];
        _wxopenid = [[NSUserDefaults standardUserDefaults] objectForKey:wxopenidKey];
        _wbopenid = [[NSUserDefaults standardUserDefaults] objectForKey:wbopenidKey];
        _qqopenid = [[NSUserDefaults standardUserDefaults] objectForKey:qqopenidKey];
        
        _fansCount = (NSInteger)[[NSUserDefaults standardUserDefaults] valueForKey:fansCountKey];
        _commentCount = (NSInteger)[[NSUserDefaults standardUserDefaults] valueForKey:commentCountKey];
        _focusCount = (NSInteger)[[NSUserDefaults standardUserDefaults] valueForKey:focusCountKey];
        _userAsset = [[NSUserDefaults standardUserDefaults] objectForKey:userAssetKey];

        }
    return self;
}
+ (BOOL)getUser {
    
    if ([UserInfos sharedUser].usertel.length != 0) {
        
        return YES;
    }
    return NO;
}
+ (void)setUser {
    
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].ID forKey:IDKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].userPsd forKey:userPsdKey];

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].userimgurl forKey:userimgurlKey];

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].username  forKey:usernameKey];

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usermotto forKey:usermottoKey];
   
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usernickname forKey:usernicknameKey];

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].usertel forKey:usertelKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].useralicode forKey:useralicodeKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].userpaycode forKey:userpaycodeKey];

    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].isreal forKey:isrealKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].ismerchant forKey:ismerchantKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].wxopenid forKey:wxopenidKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].wbopenid forKey:wbopenidKey];
    [[NSUserDefaults standardUserDefaults] setObject:[UserInfos sharedUser].qqopenid forKey:qqopenidKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DLog(@"%@", paths);
    
//    [EMClient sharedClient].chatManager up
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
    if ([UserInfos sharedUser].useralicode != NULL) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:useralicodeKey];
    }
    if ([UserInfos sharedUser].userpaycode != NULL) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:userpaycodeKey];
    }
//    if ([UserInfos sharedUser].wxopenid != NULL) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:wxopenidKey];
//    }
//    if ([UserInfos sharedUser].wbopenid != NULL) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:wbopenidKey];
//    }
//    if ([UserInfos sharedUser].qqopenid != NULL) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:qqopenidKey];
//    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:ismerchantKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:isrealKey];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:IDKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userPsdKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
