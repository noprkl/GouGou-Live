//
//  DogMarkView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DogMarkView : UIView

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)marks;
- (void)creatDogMarksWithMark:(NSArray *)marks;
@end
