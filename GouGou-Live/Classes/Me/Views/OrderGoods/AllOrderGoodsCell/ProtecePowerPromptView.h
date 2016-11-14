//
//  ProtecePowerPromptView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CilckSureApplyBtnBlock)(UIButton *button);

@interface ProtecePowerPromptView : UIView
/** 点击确定按钮回调 */
@property (strong,nonatomic) CilckSureApplyBtnBlock sureApplyBtnBlock;

@property(nonatomic, strong) NSString *message; /**< 提示信息 */

- (void)show;
- (void)dismiss;
@end
