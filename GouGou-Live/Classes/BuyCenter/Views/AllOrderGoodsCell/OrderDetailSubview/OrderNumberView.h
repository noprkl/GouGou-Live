//
//  OrderNumberView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNumberView : UIView
@property (copy, nonatomic) NSString *buyUserId;  /** 买家流水号 */
@property (copy, nonatomic) NSString *createTimes; /**< 创建时间 */
@property (copy, nonatomic) NSString *depositTimes; /**< 定金支付时间 */
@property (copy, nonatomic) NSString *balanceTimes; /**< 尾款支付时间 */
@property (copy, nonatomic) NSString *deliveryTimes; /**< 发货时间 */
@end
