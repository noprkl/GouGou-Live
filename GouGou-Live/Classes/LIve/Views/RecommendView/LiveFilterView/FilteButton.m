//
//  FilteButton.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FilteButton.h"

@implementation FilteButton
//
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        
//        //设置图片显示的样式
//        self.imageView.contentMode = UIViewContentModeLeft;
//
//        self.titleLabel.textAlignment = NSTextAlignmentRight;
//    }
//    return self;
//}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = self.bounds.size.width / 2;
    CGFloat labelH = self.bounds.size.height;

    return CGRectMake(labelX, labelY, labelW, labelH);

}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    UIImage *image = [UIImage imageNamed:@"矩形-33"];
    
    CGFloat imageX = self.bounds.size.width / 2 + 5;
    CGFloat imageY = self.bounds.size.height / 2;
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}
//- (void)awakeFromNib {
//    
//    [self setUP];
//    
//}
- (void)setUP {
    
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.imageView.contentMode = UIViewContentModeLeft;
    [self setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    // UILabel
//    CGFloat labelX = 0;
//    CGFloat labelY = 0;
//    CGFloat labelW = self.bounds.size.width / 2;
//    CGFloat labelH = self.bounds.size.height;
//    self.titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
//
//    // UIimage
//    CGFloat imageX = labelW + 5;
//    CGFloat imageY = 0;
//    CGFloat imageW = self.bounds.size.width / 2 - 5;
//    CGFloat imageH = labelH;
//    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
//
//}

@end
