//
//  StartSourceView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "StartSourceView.h"

@interface StartSourceView ()

@end

@implementation StartSourceView

- (void)setStartCount:(NSInteger)startCount {
    _startCount = startCount;
    
    UIImage *yellowImage = [UIImage imageNamed:@"星星黄"];
    UIImage *whiteImage = [UIImage imageNamed:@"星星白"];
    CGFloat WH = yellowImage.size.width;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = kDogImageWidth / 2;
    
    
    for (NSInteger i = 0; i < startCount; i ++) {
        if (i == 0) {
            x = 0;
        }
        x = i * (WH + margin);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = yellowImage;
        imageView.frame = CGRectMake(x, y, WH, WH);
        [self addSubview:imageView];
    }
    for (NSInteger i = startCount; i < 5; i ++) {
        x = i * (WH + margin);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = whiteImage;
        imageView.frame = CGRectMake(x, y, WH, WH);
        [self addSubview:imageView];
    }
}
@end
