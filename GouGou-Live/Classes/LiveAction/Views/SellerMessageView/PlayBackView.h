//
//  PlayBackView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickPlayBackBtnBlcok)(UIControl *control);

@interface PlayBackView : UIView

- (instancetype)initWithFrame:(CGRect)frame withPlayBackMessage:(NSArray *)playbackMessages clickPlaybackBtn:(ClickPlayBackBtnBlcok)playbackBlock;

@end
