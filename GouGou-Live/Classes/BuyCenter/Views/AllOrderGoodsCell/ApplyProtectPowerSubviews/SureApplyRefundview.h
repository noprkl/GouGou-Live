//
//  SureApplyRefundview.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditTextfiledBlock)(UITextField *textfiled);

typedef void(^SwitchOPenBlock)(UISwitch *swich);

@interface SureApplyRefundview : UIView
/** 监听textfiled（退款金额） */
@property (strong,nonatomic) EditTextfiledBlock refundBlock;
/** 点击'开关'回调 */
@property (strong,nonatomic) SwitchOPenBlock openBlock;
@property (copy, nonatomic) NSString *textViewText; /**< textView描述 */
@property (copy, nonatomic) NSString *moneyTextfiel; /**< 退款金额 */


@end
