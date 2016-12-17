//
//  StateView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateView : UIView
/** 状态信息 */
@property (strong,nonatomic) NSString *stateMessage;
/** 时间信息 */
@property (strong,nonatomic) NSString *timeMessage;
@end
