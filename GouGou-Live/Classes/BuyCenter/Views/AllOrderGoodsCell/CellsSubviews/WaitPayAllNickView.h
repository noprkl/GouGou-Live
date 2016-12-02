//
//  WaitPayAllNickView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaitAllNickModel;

@interface WaitPayAllNickView : UIView
/** 订单状态信息 */
@property (strong,nonatomic) NSString *orderState;
/** 昵称model */
@property (strong,nonatomic) WaitAllNickModel *model;

@end
