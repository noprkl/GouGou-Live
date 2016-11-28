//
//  BaseModel.m
//  GouGou-Live
//
//  Created by ma c on 16/11/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
// 驼峰
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    if ([propertyName isEqualToString:@"ID"]) {
        return @"ID";
    }else{
        return [propertyName mj_underlineFromCamel];
    }
}
// 关键词
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end
