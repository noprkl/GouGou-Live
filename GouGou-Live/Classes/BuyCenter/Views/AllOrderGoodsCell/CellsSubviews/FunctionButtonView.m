//
//  FunctionButtonView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FunctionButtonView.h"

@interface FunctionButtonView ()
/** 最后选中的按钮 */
@property (strong,nonatomic) UIButton *lastButton;

@property (nonatomic, strong) NSMutableArray * buttons;
@end

@implementation FunctionButtonView
- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray buttonNum:(NSInteger)buttonNum {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = 75;
        CGFloat btnH = 35;
        
        CGFloat offset =  btnW + kDogImageWidth;
        
        for (NSInteger i = 1; i <= buttonNum; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
//            button.tag = i + 100;
            
            [self.buttons addObject:button];
            
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            
            button.frame  = CGRectMake(SCREEN_WIDTH - i * offset, 5, btnW, btnH);
            
            [button setTitle:titleArray[i-1] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
            
            [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
            
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
        }
        
    }
    return self;
}

- (void)clickButton:(UIButton *)btn {

    if (_difFuncBlock) {
        _difFuncBlock(btn);

    }
    self.lastButton.selected = NO;
    self.lastButton.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.selected = YES;
    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    self.lastButton = btn;
}



@end
