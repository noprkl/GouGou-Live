//
//  PromptView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlayingPasswardBlock)(UITextField *textfiled);

typedef void(^ClickSureButtonBlock)(NSString *text);
typedef void(^ClickForgrtBtnBlock)();
typedef void(^clickCancelBtnBlock)();

@interface PromptView : UIView

/** 监听密码输入block */
@property (strong, nonatomic) PlayingPasswardBlock playpsdBlock;

/** 监听确定按钮block */
@property (strong,nonatomic) ClickSureButtonBlock clickSureBtnBlock;

@property(nonatomic, strong) ClickForgrtBtnBlock forgetBlock; /**< 忘记密码回调 */

@property(nonatomic, strong) clickCancelBtnBlock cancelBlock; /**< 取消按钮回调 */


@property(nonatomic, strong) NSString *title; /**< 提示 */

@property(nonatomic, strong) NSString *noteStr; /**< 返回提示 */
@property(nonatomic, assign) BOOL hidNote; /**< 隐藏提示 */

@property(nonatomic, assign) BOOL hidForGet; /**< 隐藏忘记密码 */
@property(nonatomic, strong) NSString *placeHolder; /**< 占位符 */

- (void)show;
- (void)dismiss;

@end
