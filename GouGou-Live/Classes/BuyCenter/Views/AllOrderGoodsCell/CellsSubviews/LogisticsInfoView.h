//
//  LogisticsInfoView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CopyOrderIDBlock)();
@interface LogisticsInfoView : UIView

@property (nonatomic, strong) NSString *orderCode; /**< 订单编号 */
@property (nonatomic, strong) NSString *orderStyle; /**< 运货方式 */

@property (nonatomic, strong) CopyOrderIDBlock copyBlock; /**< 复制 */

@end
