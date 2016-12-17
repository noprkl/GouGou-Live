//
//  FunctionButtonView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDiffentFuncBtn)(UIButton *btn);

@interface FunctionButtonView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray buttonNum:(NSInteger)buttonNum;

/** 点击按钮回调 */
@property (strong,nonatomic) ClickDiffentFuncBtn difFuncBlock;

@end
