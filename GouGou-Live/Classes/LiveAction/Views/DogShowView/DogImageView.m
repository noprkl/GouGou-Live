//
//  DogImageView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogImageView.h"

@interface DogImageView ()

/** y值 */
@property (assign, nonatomic) CGFloat maxY;
@end

@implementation DogImageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (CGFloat)getCellHeightWithImages:(NSArray *)images {    
    int cols = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat WH = 0;
    if (images.count == 1) {
        cols = 2;
        
    } else if (images.count == 2){
        cols = 2;
        
    }else if (images.count == 3){
        cols = 3;
        
    }else if (images.count == 4){
        cols = 2;
        
    }else if (images.count >= 5){
        cols = 3;
    }
    
    WH = (SCREEN_WIDTH - (cols + 1) * kDogImageWidth) / cols;
    
    // 行列数
    int row = 0;
    int col = 0;
    
    for (NSInteger i = 0; i < images.count; i ++) {
        
        NSString *imageName = images[i];
        UIImageView *imageView = [[UIImageView alloc] init];
       
        // 图片
        NSString *urlString = [IMAGE_HOST stringByAppendingString:imageName];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
//        imageView.image = [UIImage imageNamed:imageName];

        col = i % cols;
        row = (int)i / cols;
        
        x = col * (WH + kDogImageWidth) + kDogImageWidth;
        y = row * (WH + kDogImageWidth) + kDogImageWidth;
        imageView.frame = CGRectMake(x, y, WH, WH);
        
        if (i == images.count - 1) {
            _maxY = CGRectGetMaxY(imageView.frame);
        }
        [self addSubview:imageView];
    }
    
    return _maxY;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}
@end
