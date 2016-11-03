//
//  DogPriceFilter.h
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectPriceRangeBlock)(NSString *minAge, NSString *maxAge);

@interface DogPriceFilter : UIView

/** 选取价格回调 */
@property (strong, nonatomic) SelectPriceRangeBlock priceRangeBlock;

/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;

- (void)show;
- (void)dismiss;
@end
