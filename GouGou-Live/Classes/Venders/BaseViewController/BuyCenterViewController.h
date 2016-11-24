//
//  BuyCenterViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"
#import "SingleChatViewController.h"

@interface BuyCenterViewController : BaseViewController
/** 删除订单 */
- (void)clickDeleteOrder;
/** 尾金支付 */
- (void)clickPayBackMoney;
/** 定金支付 */
- (void)clickPayFontMoney;
/** 全款支付 */
- (void)clickPayAllMoney;
/** 点击取消订单 */
- (void)clickCancleOrder;
/** 点击不想买了 */
- (void)clickNotBuy;
/** 点击申请维权调用 */
- (void)clickApplyProtectPower;
/** 点击提醒发货 */
- (void)clickConsignment;
@end
