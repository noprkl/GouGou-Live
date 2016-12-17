//
//  SellerProtectPowerStateView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerProtectPowerStateView : UIView

@property(nonatomic, strong) NSString *stateMessage; /**< 状态信息 */

@property(nonatomic, strong) NSString *noteStr; /**< 提示文字 */

@property (nonatomic, strong) NSString *closeTime; /**< 订单关闭时间 */

@end
