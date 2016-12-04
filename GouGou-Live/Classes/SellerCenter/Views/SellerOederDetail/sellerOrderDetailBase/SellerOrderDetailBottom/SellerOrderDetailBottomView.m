//
//  SellerOrderDetailBottomView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailBottomView.h"

@interface SellerOrderDetailBottomView ()

@property(nonatomic, strong) UIButton *lastButton; /**< 上一个按钮 */

@property(nonatomic, assign) NSInteger count; /**< 个数 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@end
@implementation SellerOrderDetailBottomView

- (void)setBtnTitles:(NSArray *)btnTitles {
    _btnTitles = btnTitles;
    self.count = btnTitles.count;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.line];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(1);
    }];
    
    CGFloat W = SCREEN_WIDTH / _count;
    CGFloat H = 48;
    CGFloat x = 0;
    CGFloat y = 1;
    
    for (NSInteger i = 0; i < _count; i ++) {
        x =  SCREEN_WIDTH - W * (_count - i);
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:self.btnTitles[i] forState:(UIControlStateNormal)];
      
        btn.frame = CGRectMake(x, y, W, H);
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];

        [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        btn.tag = 110 + i;
        if (i == _count - 1) {
            btn.selected = YES;
            self.lastButton = btn;
            [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        }
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
        [self addSubview:btn];
    }
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
- (void)clickBtnAction:(UIButton *)btn {
    NSInteger index = btn.tag - 110;

    if (_clickBlock) {
        _clickBlock(self.btnTitles[index]);
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
