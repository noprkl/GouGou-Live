//
//  RegisteViewController.h
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisteViewController : BaseViewController

@property (nonatomic, strong) NSString *name; /**< openid */
@property (nonatomic, strong) NSString *nickName; /**< 昵称 */
@property (nonatomic, assign) NSInteger type; /**< 类型 */

@end
