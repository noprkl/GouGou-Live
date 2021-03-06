//
//  SellerWaitPayCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerBaseCell.h"

typedef void(^ClickBtnBlock)(NSString *btntitle);

@interface SellerWaitPayCell : SellerBaseCell

@property(nonatomic, strong) NSArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSString *orderState; /**< 订单状态 */

@property(nonatomic, strong) NSArray *costMessage; /**< 付款情况 */

@property(nonatomic, strong) ClickBtnBlock clickBtnBlock; /**< 按钮回调 */


@property(nonatomic, strong) SellerOrderModel *model; /**< 订单模型 */

@end
