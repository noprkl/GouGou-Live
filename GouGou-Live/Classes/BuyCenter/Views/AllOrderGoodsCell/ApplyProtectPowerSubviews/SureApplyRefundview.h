//
//  SureApplyRefundview.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditTextfiledBlock)(NSString *money);

typedef void(^SwitchOPenBlock)(BOOL isMoney);
typedef void(^EditDescBlock)(NSString *descContent);

@interface SureApplyRefundview : UIView
/** 监听textfiled（退款金额） */
@property (strong,nonatomic) EditTextfiledBlock refundBlock;
/** 监听秒速内容 */
@property (strong,nonatomic) EditDescBlock descBlock;

/** 点击'开关'回调 */
@property (strong,nonatomic) SwitchOPenBlock openBlock;

@property (nonatomic, strong) NSString *realMoney; /**< 实际金额 */

@end
