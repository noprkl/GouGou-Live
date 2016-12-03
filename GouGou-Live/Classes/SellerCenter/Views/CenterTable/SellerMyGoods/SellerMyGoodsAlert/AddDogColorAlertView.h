//
//  AddDogColorAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//  狗狗颜色弹窗

#import <UIKit/UIKit.h>


typedef void(^SelectColocrRangeBlock)(DogCategoryModel *color);

@interface AddDogColorAlertView : UIView

/** 选取颜色回调 */
@property (strong, nonatomic) SelectColocrRangeBlock colorBlock;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

- (void)show;
- (void)dismiss;
@end
