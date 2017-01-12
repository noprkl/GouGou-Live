//
//  SellerFunctionButtonView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerFunctionButtonView.h"

@interface SellerFunctionButtonView ()

/** 最后选中的按钮 */
@property (strong,nonatomic) UIButton *lastButton;

@end

@implementation SellerFunctionButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnW = 75;
    CGFloat btnH = 35;
    
    CGFloat offset =  btnW + kDogImageWidth;
    if (self.titleArray.count != 0) {
        
    }
    
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        
        button.tag = 100 + i;
        
        button.frame  = CGRectMake(SCREEN_WIDTH - (self.titleArray.count - i) * offset, 5, btnW, btnH);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];

        [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(clickbuttonDown:) forControlEvents:(UIControlEventTouchDown)];
//        if (i == 0) {
//            button.selected = YES;
//            [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
//            self.lastButton = button;
//        }
        [self addSubview:button];
    }
}

- (void)clickButton:(UIButton *)btn {

    if (_clickBtnBlock) {
        _clickBtnBlock(self.titleArray[btn.tag - 100]);

    }
//    self.lastButton.selected = NO;
    
//    self.lastButton.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
//    [self.lastButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.selected = YES;
    [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.lastButton = btn;
}

- (void)clickbuttonDown:(UIButton *)btn {
    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
}
@end
