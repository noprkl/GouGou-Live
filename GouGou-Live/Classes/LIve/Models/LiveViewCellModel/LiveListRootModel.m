//
//  LiveListRootModel.m
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveListRootModel.h"
#import "LiveRootStreamModel.h"

@implementation LiveListRootModel
+ (NSDictionary *)mj_objectClassInArray{
    
    NSDictionary *dict = @{
                           @"info":@"LiveRootStreamModel"
                           };
    return dict;
}

@end
