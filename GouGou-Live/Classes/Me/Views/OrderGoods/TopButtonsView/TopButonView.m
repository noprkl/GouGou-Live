//
//  TopButonView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TopButonView.h"

@interface TopButonView  ()

/** 按钮title数组 */
@property (strong,nonatomic) NSArray *titleArray;
/** 未选中图片名数组 */
@property (strong,nonatomic) NSArray *unSelectedArray;
/** 选中状态 */
@property (strong,nonatomic) NSArray *selecedtArray;
/** 最后选中的按钮 */
@property (strong,nonatomic) UIButton *lastButton;

@end

@implementation TopButonView

- (NSArray *)titleArray {

    if (!_titleArray) {
        _titleArray = @[@"全部",@"待支付",@"代发货",@"待收货",@"待评价",@"维权"];
    }
    return _titleArray;
}

- (NSArray *)unSelectedArray {

    if (!_unSelectedArray) {
        _unSelectedArray = @[@"全部",@"待付款",@"待发货",@"收货",@"待评价",@"维权"];;
    }
    return _unSelectedArray;
}

- (NSArray *)selecedtArray {

    if (!_selecedtArray) {
        _selecedtArray = @[@"全部（点击）",@"待付款（点击）",@"待发货（点击）",@"收货（点击）",@"待评价（点击）",@"维权（点击）"];
    }
    return _selecedtArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addButtons];
    }
    return self;
}

- (void)addButtons {

    NSInteger btnNum = 6;
    
    CGFloat btnW = SCREEN_WIDTH / btnNum;
    CGFloat btnH = 88;
    
    for (NSInteger i = 0; i < btnNum; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 80 + i;
        button.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        // 正常状态
        
        [button setImage:[UIImage imageNamed:self.unSelectedArray[i]] forState:UIControlStateNormal];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 选中状态
        [button setImage:[UIImage imageNamed:self.selecedtArray[i]] forState:UIControlStateSelected];
        
        // 字体设置
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置图片和文字的位置
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 40, 18);
        
        button.titleEdgeInsets = UIEdgeInsetsMake(30, -40, 0, -16);
        
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.selected = YES;
            self.lastButton = button;
        }
        
        [self addSubview:button];
    }
}

- (void)clickBtn:(UIButton *)btn {
    
    
    if (_difStateBlock) {
        _difStateBlock(btn.tag);
    }
    
    if (self.lastButton == btn) {
        
        return;
    } else {
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffa11a"] forState:UIControlStateNormal];
        
        [self.lastButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        btn.selected = YES;
    }
    
    self.lastButton.selected = NO;
    
    self.lastButton = btn;

}

@end
