//
//  PayMoneyPrompt.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSizeCellBlock)(NSString *payWays);
typedef void(^ClickBottomBtnBlovk)(NSString *string);
@interface PayMoneyPrompt : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickSizeCellBlock payCellBlock;

@property(nonatomic, strong) ClickBottomBtnBlovk bottomBlock; /**< 点击底部按钮回调 */

@property(nonatomic, strong) NSArray *dataArr; /**< 选择数组 */


@property(nonatomic, strong) NSString *payMoney; /**< 支付钱数 */

- (void)show;
- (void)dismiss;


@end
