//
//  NicknameView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NickNameModel.h"

@interface NicknameView : UIView
/** 订单状态信息 */
@property (strong,nonatomic) NSString *stateMessage;
/** 昵称model */
@property (strong,nonatomic) NickNameModel *model;

@end
