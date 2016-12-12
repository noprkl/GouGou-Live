//
//  LivingViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

@interface LivingViewController : BaseViewController

/** 直播播放地址 */
@property (strong,nonatomic) NSString *liveID;

@property (nonatomic, assign) BOOL isDogCard; /**< 点击狗狗开案进入 */

@end
