//
//  SuggestButtonView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SuggestButtonView.h"

@interface SuggestButtonView ()
/** 最后选中的按钮 */
@property (strong,nonatomic) UIButton *lastButton;

@property (nonatomic, strong) NSMutableArray * buttons;

@end

@implementation SuggestButtonView
- (NSMutableArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArray {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = SCREEN_WIDTH / titleArray.count;
        CGFloat btnH = 44;
        
        for (NSInteger i = 0; i < titleArray.count; i++) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.tag = i + 500;
            
            [self.buttons addObject:button];
            
            button.frame  = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            
            [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
            
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            
            if (i == 0) {
                button.selected = YES;
                self.isComplain = YES;
                self.lastButton = button;
                [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
                self.lastButton = button;
            }
          
            
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
        }
        
    }
    return self;
}

- (void)clickButton:(UIButton *)btn {
    
    btn.selected = YES;
    
    if (_difFuncBlock) {
        _difFuncBlock(btn);
        
    }
    self.lastButton.selected = NO;
    self.lastButton.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.lastButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    btn.selected = YES;
    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    self.lastButton = btn;
}


@end
