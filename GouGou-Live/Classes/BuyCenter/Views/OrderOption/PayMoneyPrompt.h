//
//  PayMoneyPrompt.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickPromptCellBlock)(NSString *payWays);
typedef void(^ClickPromptBtnBlock)(NSString *string);

@interface PayMoneyPrompt : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickPromptCellBlock payCellBlock;

@property(nonatomic, strong) ClickPromptBtnBlock bottomBlock; /**< 点击底部按钮回调 */

@property(nonatomic, strong) NSArray *dataArr; /**< 选择数组 */


@property(nonatomic, strong) NSString *payMoney; /**< 支付钱数 */

- (void)show;
- (void)dismiss;


@end
