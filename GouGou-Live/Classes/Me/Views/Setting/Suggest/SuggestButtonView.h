//
//  SuggestButtonView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickDifFuncBtn)(UIButton *btn);
@interface SuggestButtonView : UIView

/** 点击按钮回调 */
@property (strong,nonatomic) ClickDifFuncBtn difFuncBlock;
/** 哪个按钮 */
@property (assign,nonatomic) BOOL isComplain;
- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray;
@end
