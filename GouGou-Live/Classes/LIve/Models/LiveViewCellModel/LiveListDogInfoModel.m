//
//  LiveListDogInfoModel.m
//  GouGou-Live
//
//  Created by ma c on 16/12/12.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveListDogInfoModel.h"

@implementation LiveListDogInfoModel
// 驼峰
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    if ([propertyName isEqualToString:@"impresssionId"]) {
        return @"impresssionId";
    }else if ([propertyName isEqualToString:@"ID"]){
        return @"ID";
    }else{
        return [propertyName mj_underlineFromCamel];
    }
}
@end
