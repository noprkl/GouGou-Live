//
//  HaveNoneLiveView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  未搜到有直播的人

#import <UIKit/UIKit.h>


typedef void(^ClickBackBlock)();

@interface HaveNoneLiveView : UIView

@property (nonatomic, strong) ClickBackBlock backBlock; /**< 重新加载 */

@end
