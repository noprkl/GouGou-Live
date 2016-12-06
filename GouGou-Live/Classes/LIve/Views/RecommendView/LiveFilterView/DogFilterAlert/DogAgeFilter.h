//
//  DogAgeFilter.h
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAgeRangeBlock)(DogCategoryModel *minModel, DogCategoryModel *maxModel);

@interface DogAgeFilter : UIView

/** 选取年龄回调 */
@property (strong, nonatomic) SelectAgeRangeBlock ageRangeBlock;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

- (void)show;
- (void)dismiss;
@end
