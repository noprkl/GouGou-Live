//
//  ShareBtn.m
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define kImageRatio 0.8

#import "ShareBtn.h"



@implementation ShareBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}
- (void)awakeFromNib {
    
    [self setUP];
    
}
- (void)setUP {
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [self setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // UIimage
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = imageW * kImageRatio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // UILabel
    CGFloat labelX = 0;
    CGFloat labelY = imageH;
    CGFloat labelW = self.bounds.size.width;
    CGFloat labelH = imageW - imageW * kImageRatio;
    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}
@end
