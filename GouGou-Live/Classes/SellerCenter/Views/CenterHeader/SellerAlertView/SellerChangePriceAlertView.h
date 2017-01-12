//
//  SellerChangePriceAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBottomBtnBlovk)(NSString *newPrice);

@interface SellerChangePriceAlertView : UIView

@property(nonatomic, strong) ClickBottomBtnBlovk commitBlock; /**< 点击提交按钮回调 */

@property (nonatomic, strong) NSString *orderID; /**< 订单编号 */
@property (nonatomic, strong) NSString *realMoneyNote; /**< 需要付的款项 */
@property (nonatomic, strong) NSString *realMoney; /**< 需要付的款项 */

@property (nonatomic, strong) NSString *changeStyle; /**< 修改类型 */
@property (nonatomic, strong) NSString *placeHolder; /**< 修改的类型 */

@property (nonatomic, strong) NSString *price; /**< 商品的价格 */
@property (nonatomic, strong) NSString *oldPrice; /**< 商品的老价格 */

- (void)show;
- (void)dismiss;
@end
