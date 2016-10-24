//
//  LiveTopView.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveTopView.h"

@interface LiveTopView ()


/** 点击回调 */
@property (strong, nonatomic) LiveTopBlock topBlock;
@end

@implementation LiveTopView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles tapView:(LiveTopBlock)tapBlock{

    
    if (self = [super initWithFrame:frame]) {
        
        self.topBlock = tapBlock;
        
        CGFloat width = self.frame.size.width / titles.count;
        CGFloat hight = self.frame.size.height;
        CGFloat x = 0;

        for (NSInteger i = 0; i < titles.count; i ++) {
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            
            if (i > 0) {
                x = i * width + (i *10);
            }else{
                x = i * width;
            }
            btn.frame = CGRectMake(x, 0, width, hight);
            
            [btn setTitle:titles[i] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchDown)];
            
            btn.backgroundColor = [UIColor cyanColor];
            btn.tag = i;
            
            [self addSubview:btn];

        }
        
    }
    return self;
}
- (void)clickBtnAction:(UIButton *)btn{

    if (_topBlock) {
        _topBlock(btn.tag);
    }
    
}


@end
