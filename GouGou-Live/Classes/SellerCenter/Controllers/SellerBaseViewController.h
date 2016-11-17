//
//  SellerBaseViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  提出按钮点击方法 创建一个基类

#import "BaseViewController.h"
#import "SellerOrderDetailAdressViewController.h"
#import "SellerOrderDetailLogisticsInfoViewController.h"

@interface SellerBaseViewController : BaseViewController

/** cell上按钮点击方法 */
- (void)clickBtnActionWithBtnTitle:(NSString *)title;

@end
