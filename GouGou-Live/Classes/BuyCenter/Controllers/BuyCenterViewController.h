//
//  BuyCenterViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"
#import "SingleChatViewController.h"
#import "BuyCenterModel.h"
#import "ProtectProwerTableModel.h"

@interface BuyCenterViewController : BaseViewController
/** 删除订单 */
- (void)clickDeleteOrder:(BuyCenterModel *)model;
/** 尾金支付 */
- (void)clickPayBackMoney:(BuyCenterModel *)model;
/** 定金支付 */
- (void)clickPayFontMoney:(BuyCenterModel *)model;
/** 全款支付 */
- (void)clickPayAllMoney:(BuyCenterModel *)model;
/** 点击取消订单 */
- (void)clickCancleOrder:(BuyCenterModel *)model;
/** 点击不想买了 */
- (void)clickNotBuy:(BuyCenterModel *)model;
/** 点击申请维权调用 */
- (void)clickApplyProtectPower:(int)orderID;
/** 点击提醒发货 */
- (void)clickConsignment:(BuyCenterModel *)model;
@end
