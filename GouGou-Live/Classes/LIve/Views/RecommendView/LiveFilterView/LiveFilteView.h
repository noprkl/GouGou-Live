//
//  LiveFilteView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSizeBlock)();
typedef void(^ClickAgeBlock)();
typedef void(^ClickPriceBlock)();

@interface LiveFilteView : UIView

/** 体型筛选 */
@property (strong, nonatomic) ClickSizeBlock sizeBlock;
/** 年龄筛选 */
@property (strong, nonatomic) ClickAgeBlock ageBlock;
/** 价格筛选 */
@property (strong, nonatomic) ClickPriceBlock priceBlock;
@end
