//
//  TopButonView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickDifStateBlock)(UIButton * btn);

@interface TopButonView : UIView

/** 点击按钮回调 */
@property (strong,nonatomic) ClickDifStateBlock difStateBlock;

/** 按钮title数组 */
@property (strong,nonatomic) NSArray *titleArray;

/** 未选中图片名数组 */
@property (strong,nonatomic) NSArray *unSelectedArray;

/** 选中状态 */
@property (strong,nonatomic) NSArray *selecedtArray;
@end
