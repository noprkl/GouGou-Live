//
//  TimePickerView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedTimeBlock)(NSString *timeString);

@interface TimePickerView : UIView
/** 时间标题 */
@property (strong,nonatomic) NSString *timeLabel;
/** 小时 */
@property (strong,nonatomic) NSArray *hourTime;
/** 分钟 */
@property (strong,nonatomic) NSArray *secondTime;

@property(nonatomic, strong) SelectedTimeBlock timeBlock; /**< 选中回调 */

- (void)show;
- (void)dismiss;
@end
