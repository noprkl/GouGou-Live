//
//  BuyerCloseOrderCell.h
//  GouGou-Live
//
//  Created by ma c on 16/12/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyCenterModel.h"

typedef void(^ClickBtnBlock)(NSString *btntitle);

@interface BuyerCloseOrderCell : UITableViewCell

@property(nonatomic, strong) NSString *orderState; /**< 订单状态 */

@property(nonatomic, strong) NSArray *costMessage; /**< 付款情况 */

@property(nonatomic, strong) ClickBtnBlock clickBtnBlock; /**< 按钮回调 */

@property(nonatomic, strong) BuyCenterModel *model; /**< 模型 */

@end