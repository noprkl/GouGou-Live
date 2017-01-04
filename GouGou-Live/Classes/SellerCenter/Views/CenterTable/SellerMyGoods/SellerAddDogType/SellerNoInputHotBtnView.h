//
//  SellerNoInputHotBtnView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBtnBlock)(DogCategoryModel *btnTitle);

@interface SellerNoInputHotBtnView : UIView
/** 数据 */
@property (strong,nonatomic) NSArray *datalist;
- (CGFloat)getViewHeight:(NSArray *)datalist;

@property(nonatomic, strong) ClickBtnBlock clickBlcok; /**< 点击事件 */

@end
