//
//  NicknameView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NickNameModel.h"
#import "CountDownLabel.h"


@interface NicknameView : UIView
/** 间隔 */
@property (strong,nonatomic) UIView *spaceView;
/** 买家 */
@property (strong,nonatomic) UIImageView *sellerIamge;
/** 昵称 */
@property (strong,nonatomic) UILabel *nickName;
/** 剩余时间 */
@property (strong,nonatomic) CountDownLabel *remainTimeLabel;
/** 状态 */
@property (strong,nonatomic) UILabel *stateLabe;

///** 昵称model */
//@property (strong,nonatomic) NickNameModel *model;

@property (copy,nonatomic) NSString *stateMessage;  /**< 订单状态信息 */
//@property (copy, nonatomic) NSString *merchantName; /**< 商家名称 */
//@property (copy, nonatomic) NSString *merchantImagl; /**< 商家图片 */

@end
