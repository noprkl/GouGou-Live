//
//  WaitPayAllNickView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WaitAllNickModel.h"

@interface WaitPayAllNickView : UIView
/** 间隔 */
@property (strong,nonatomic) UIView *spaceView;
/* 商家图片 */
@property (strong,nonatomic) UIImageView *sellerIamge;
/** 昵称 */
@property (strong,nonatomic) UILabel *nickName;
/** 状态 */
@property (strong,nonatomic) UILabel *stateLabe;

///** 订单状态信息 */
//@property (strong,nonatomic) NSString *orderState;
///** 昵称model */
//@property (strong,nonatomic) WaitAllNickModel *model;

@end
