//
//  MerhantComplaint.h
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickPhoneNumBlcok)();
typedef void(^ClickHAndinBlock)(UIButton *button);

@interface MerhantComplaint : UIView
/** 点击'电话号码'回调 */
@property (strong,nonatomic) ClickPhoneNumBlcok phoneNumBlock;
/** 点击'提交'回调 */
@property (strong,nonatomic) ClickHAndinBlock handinBlock;

@property (nonatomic, strong) NSString *phoneNumber; /**< 电话号码 */

@end
