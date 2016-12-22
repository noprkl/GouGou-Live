//
//  DogDetailModel.m
//  GouGou-Live
//
//  Created by ma c on 16/12/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogDetailModel.h"

@implementation DogDetailModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"color":@"DogCategoryModel",
             @"kind":@"DogCategoryModel",
             @"size":@"DogCategoryModel"
             };
}
@end
