//
//  SellerSendAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^ClickBottomBtnBlovk)(NSString *shipStyle, NSString *shipOrder);

@interface SellerSendAlertView : UIView

@property(nonatomic, strong) ClickBottomBtnBlovk commitBlock; /**< 点击提交按钮回调 */

- (void)show;
- (void)dismiss;
@end
