//
//  LiveViewCellModel.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveViewCellModel.h"
#import "LiveListStreamModel.h"

@implementation LiveViewCellModel
+ (NSDictionary *)mj_objectClassInArray{
    
    NSDictionary *dict = @{
                           @"info":@"LiveListDogInfoModel"
                           };
    return dict;
}

@end
