//
//  MyViewController.h
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

@interface MyViewController : BaseViewController
/** 是否认证 */
@property (assign,nonatomic) BOOL isCertitycate;
/** 接收未认证 */
@property (strong,nonatomic) UIViewController *promptVC;
/** 接收认证 */
@property (strong,nonatomic) UIViewController *certityVC;

@end
