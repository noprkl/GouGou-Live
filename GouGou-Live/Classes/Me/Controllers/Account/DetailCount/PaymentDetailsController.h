//
//  PaymentDetailsController.h
//  GouGou-Live
//
//  Created by ma c on 16/12/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

@interface PaymentDetailsController : BaseViewController
@property (copy, nonatomic) NSString *payment; /**< 支付方式  */
@property (copy, nonatomic) NSString *balance; /**< 余额 */
@property (copy, nonatomic) NSString *type; /**< 交易类型 */
@property (copy, nonatomic) NSString *payTime; /**< 交易时间 */
@end
