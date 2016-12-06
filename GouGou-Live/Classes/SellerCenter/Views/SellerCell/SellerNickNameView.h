//
//  SellerNickNameView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerNickNameView : UIView

/** 昵称 */
@property (strong,nonatomic) UILabel *nickName;

@property(nonatomic, strong) UILabel *dateLabel; /**< 时间 */

/** 订单状态信息 */
@property (strong,nonatomic) NSString *stateMessage;

@property(nonatomic, assign) BOOL dateIsHid; /**< 时间隐藏 */

@end
