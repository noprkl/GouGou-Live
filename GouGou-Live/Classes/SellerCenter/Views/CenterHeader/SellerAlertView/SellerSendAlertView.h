//
//  SellerSendAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBottomBottonBlovk)(NSString *shipStyle, NSString *shipOrder);
typedef void(^WhenAlertDismissBlock)();
@interface SellerSendAlertView : UIView

@property(nonatomic, strong) ClickBottomBottonBlovk commitBlock; /**< 点击提交按钮回调 */

@property (nonatomic, strong) WhenAlertDismissBlock dismissBlock; /**< 弹窗隐藏 */

@property(nonatomic, strong) UILabel *successNote; /**< 成功提示 */

@property (nonatomic, strong) NSString *orderID; /**< 订单编号 */

- (void)show;
- (void)dismiss;
@end
