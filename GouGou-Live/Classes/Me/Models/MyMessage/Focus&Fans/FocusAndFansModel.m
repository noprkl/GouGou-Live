//
//  FocusAndFansModel.m
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FocusAndFansModel.h"

static NSString *userNickName = @"userNickName";
static NSString *userMotto = @"userMotto";
static NSString *userImgUrl = @"userImgUrl";
static NSString *userFanId = @"userFanId";
@implementation FocusAndFansModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userNickName forKey:userNickName];
    [aCoder encodeObject:self.userMotto forKey:userNickName];
    [aCoder encodeObject:self.userImgUrl forKey:userImgUrl];
    [aCoder encodeInteger:self.userFanId forKey:userFanId];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userFanId = [aDecoder decodeIntegerForKey:userFanId];
        self.userImgUrl = [aDecoder decodeObjectForKey:userFanId];
        self.userMotto = [aDecoder decodeObjectForKey:userMotto];
        self.userNickName = [aDecoder decodeObjectForKey:userNickName];
    }
    return self;
}
@end
