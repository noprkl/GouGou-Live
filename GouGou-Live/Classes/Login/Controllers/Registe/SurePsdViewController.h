//
//  SurePsdViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

@interface SurePsdViewController : BaseViewController

@property(nonatomic, strong) NSString *telNumber; /**< 手机号 */

@property(nonatomic, strong) NSString *codeNumber; /**< 验证码 */

@property (nonatomic, strong) NSString *name; /**< openid */

@property (nonatomic, assign) NSInteger type; /**< 类型 */

@end
