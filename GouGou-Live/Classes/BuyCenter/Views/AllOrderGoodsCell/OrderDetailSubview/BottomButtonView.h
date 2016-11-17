//
//  BottomButtonView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickDifFuncBtn)(UIButton *btn);
@interface BottomButtonView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray;

/** 点击按钮回调 */
@property (strong,nonatomic) ClickDifFuncBtn difFuncBlock;

@end
