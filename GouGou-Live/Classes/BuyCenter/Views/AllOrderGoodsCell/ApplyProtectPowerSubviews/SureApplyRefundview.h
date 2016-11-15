//
//  SureApplyRefundview.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditTextfiledBlock)(UITextField *textfiled);

@interface SureApplyRefundview : UIView
/** 监听textfiled（退款金额） */
@property (strong,nonatomic) EditTextfiledBlock refundBlock;

@end
