//
//  LiveListRootModel.m
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveListRootModel.h"
#import "LiveListRespModel.h"
#import "LiveListStreamModel.h"

@implementation LiveListRootModel

+ (NSDictionary *)mj_objectClassInArray{
    
    NSDictionary *dict = @{
                           @"resp":@"LiveListRespModel",
                           @"steam":@"LiveListStreamModel"
                           };
    return dict;
}
@end
