//
//  SellerFunctionButtonView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDifFuncBtn)(NSString *btnTitle);

@interface SellerFunctionButtonView : UIView


@property(nonatomic, strong) NSArray *titleArray; /**< 按钮标题数组 */

/** 点击按钮回调 */
@property (strong,nonatomic) ClickDifFuncBtn clickBtnBlock;


@end
