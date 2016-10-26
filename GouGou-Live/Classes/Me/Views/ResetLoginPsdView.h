//
//  ResetLoginPsdView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString *(^ViewTitleLabelBlock)();

typedef NSString *(^TextFieldBlock)(NSString *text);

typedef void(^DeleteBtnBlock)();

typedef void(^SureBtnBlock)();

@interface ResetLoginPsdView : UIView

/** view名字回调 */
@property (strong, nonatomic) ViewTitleLabelBlock titltBlock;
/** textField回调 */
@property (strong, nonatomic) TextFieldBlock textBlock;
/** 删除按钮回调 */
@property (strong, nonatomic) DeleteBtnBlock deleBlock;
/** 确定按钮 */
@property (strong, nonatomic) SureBtnBlock sureBlock;

//- (instancetype)initWithFrame:(CGRect)frame title:(ViewTitleLabelBlock)titleBlock textField:(TextFieldBlock)textField deleBtn:(DeleteBtnBlock)deleteBlock sureBtn:(SureBtnBlock)sureBlock;
- (void)show;
- (void)dismiss;
@end
