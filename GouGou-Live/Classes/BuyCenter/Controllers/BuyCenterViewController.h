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
/** 根据支付状态请求支付金额 进行支付*/
- (void)payMoneyWithOrderID:(NSString *)orderID payStyle:(NSString *)payStyle;
/** 点击取消订单 */
- (void)clickCancleOrder:(BuyCenterModel *)model;
/** 点击不想买了 */
- (void)clickNotBuy:(BuyCenterModel *)model;
/** 点击申请维权调用 */
- (void)clickApplyProtectPower:(NSString *)orderID;
/** 点击提醒发货 */
- (void)clickConsignment:(BuyCenterModel *)model;
@end
