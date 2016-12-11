//
//  SellerSendAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBottomBottonBlovk)(NSString *shipStyle, NSString *shipOrder);

@interface SellerSendAlertView : UIView

@property(nonatomic, strong) ClickBottomBottonBlovk commitBlock; /**< 点击提交按钮回调 */

@property(nonatomic, strong) UILabel *successNote; /**< 成功提示 */

- (void)show;
- (void)dismiss;
@end
