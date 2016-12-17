//
//  SellerChangeShipCostView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBottomBtnBlovk)(NSString *newPrice);

@interface SellerChangeShipCostView : UIView

@property(nonatomic, strong) ClickBottomBtnBlovk commitBlock; /**< 点击提交按钮回调 */
@property (nonatomic, strong) NSString *orderID; /**< 订单编号 */

- (void)show;
- (void)dismiss;
@end
