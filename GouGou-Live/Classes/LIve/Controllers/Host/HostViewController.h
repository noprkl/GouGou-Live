//
//  HostViewController.h
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ClickTypeCellBlock)(NSInteger index);

@interface HostViewController : BaseViewController

/** 点击cell回调 */
@property (strong,nonatomic) ClickTypeCellBlock typeBlock;

@end
