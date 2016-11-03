//
//  BuyRuleAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSureBtnBlock)();

@interface BuyRuleAlertView : UIView


@property(nonatomic, strong) ClickSureBtnBlock sureBlock; /**< 确定回调 */

- (void)show;

@end
