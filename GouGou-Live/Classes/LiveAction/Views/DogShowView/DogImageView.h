//
//  DogImageView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DogImageView : UIView

//- (instancetype)initWithFrame:(CGRect)frame dogImages:(NSArray *)images;

/** 图片数组 */

- (CGFloat)getCellHeightWithImages:(NSArray *)images;
@end
