//
//  LiveTopView.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveTopView.h"

@interface LiveTopView ()

/** 线 */
@property (strong, nonatomic) UIView *lineView;

/** 按钮数组 */
@property (strong, nonatomic) NSMutableArray *buttons;

/** block */
@property (strong, nonatomic) LiveTopBlock tapBlock;
@end

@implementation LiveTopView
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles tapView:(LiveTopBlock)tapBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tapBlock = tapBlock;
        
        // YYKit
        CGFloat btnWid = self.frame.size.width / titles.count;
        
        CGFloat btnHig = self.frame.size.height;
        
        for (NSInteger i = 0; i < titles.count; i ++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.buttons addObject:button];
            
            button.tag = i;
            
            // button标题
            NSString *title = titles[i];
            
            [button setTintColor:[UIColor whiteColor]];
            button.titleLabel.font = [UIFont systemFontOfSize:19];
            [button setTitle:title forState:UIControlStateNormal];
            
            
            
            button.frame = CGRectMake(i * btnWid, 0, btnWid, btnHig);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:button];
            
            
            if (i == 1) {
                
                // 添加下划线
                // 下划线宽度 = 按钮文字宽度
                // 下划线中心点x = 按钮中心点x (竖直方向)
                
                CGFloat h = 2;
                CGFloat y = 36;
                
                // 先计算文字宽度 给label赋值
                [button.titleLabel sizeToFit];
                
                UIView *lineView = [[UIView alloc] init];
                [self addSubview:lineView];
                
                [lineView makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(button.titleLabel.centerX);
                    make.top.equalTo(y);
                    make.size.equalTo(CGSizeMake(button.titleLabel.frame.size.width, h));
                }];
                
                lineView.backgroundColor = [UIColor whiteColor];
                
                self.lineView = lineView;
                
                
         
            }
            
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)button {
    
    self.tapBlock(button.tag);
    
    [self scrolling:button.tag];
    
}
- (void)scrolling:(NSInteger)btnTag
{
    UIButton *button = self.buttons[btnTag];
    
    //线的动画
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.lineView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(36);
            make.size.equalTo(CGSizeMake(button.titleLabel.frame.size.width, 2));
            make.centerX.equalTo(button.centerX);
        }];
        
    }];
}
@end
