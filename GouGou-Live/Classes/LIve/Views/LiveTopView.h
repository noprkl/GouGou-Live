//
//  LiveTopView.h
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LiveTopBlock)(NSInteger btnTag);

@interface LiveTopView : UIView

/** 重写view初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles tapView:(LiveTopBlock)tapBlock;

/** 滑动时btn变化 */
- (void)scrolling:(NSInteger)btnTag;
@end
