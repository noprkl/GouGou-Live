//
//  BottomButtonView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BottomButtonView.h"

@interface BottomButtonView ()
/** 最后选中的按钮 */
@property (strong,nonatomic) UIButton *lastButton;

@property (nonatomic, strong) NSMutableArray * buttons;
@end

@implementation BottomButtonView
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
            
            //            button.tag = i + 100;
            
            [self.buttons addObject:button];
            
//            button.layer.cornerRadius = 5;
//            button.layer.masksToBounds = YES;
//            button.layer.borderWidth = 0.5;
//            button.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
            
            
            button.frame  = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            
            [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
            
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            if (i == 0) {
                button.selected = YES;
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
