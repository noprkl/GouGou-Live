//
//  DogTypesView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreImpressionModel.h"
typedef void(^ClickBtnBlock)(MoreImpressionModel *model);

@interface DogTypesView : UIView

/** 点击Button回调方法 */
@property (copy,nonatomic) ClickBtnBlock btnBlock;

@property (copy, nonatomic) NSArray *impressionArr; /**< 印象数组 */

@end
