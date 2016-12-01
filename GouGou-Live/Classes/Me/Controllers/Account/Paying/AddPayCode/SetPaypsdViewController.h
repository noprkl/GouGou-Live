//
//  SetPaypsdViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/29.
//  Copyright © 2016年 LXq. All rights reserved.
//  设置支付密码

#import "BaseViewController.h"

@interface SetPaypsdViewController : BaseViewController

@property(nonatomic, strong) NSString *telNumber; /**< 手机号 */

@property(nonatomic, strong) NSString *codeNumber; /**< 验证码 */
@end
