//
//  ExperienceProblem.h
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickHAndinBlock)(UIButton *button);
typedef void(^ClickProblemBtnBlock)(NSString *problem);
@interface ExperienceProblem : UIView

@property (copy, nonatomic) NSString *textViewText; /**< textView文字信息 */
/** 点击'提交'回调 */
@property (strong,nonatomic) ClickHAndinBlock handinBlock;
/** 点击'问题'回调 */
@property (strong,nonatomic) ClickProblemBtnBlock problemBlock;

/** 存放问题按钮数组 */
@property (strong,nonatomic) NSMutableArray *buttonsArray;

@end
