//
//  CountDownLabel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownLabel : UILabel

/// 根据传入的时间计算和当前时间的进行比较，开始倒计时
- (void)setupCountDownWithTargetTime:(NSDate *)targetTime;

/// 根据传入的具体秒数，开始倒计时
- (void)beginCountDownWithTimeInterval:(NSTimeInterval)timerInterval;

/// 根据传入的两个时间差，开始倒计时
- (void)beginCountDownFromTime:(NSDate *)fromDate toTime:(NSDate *)toDate;
@end
