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
@property (strong,nonatomic) NSArray *titles;
/** 未选中图片名数组 */
@property (strong,nonatomic) NSArray *unSelecteds;
/** 选中状态 */
@property (strong,nonatomic) NSArray *selecteds;

/** 最后选中的按钮 */
@property (strong,nonatomic) UIButton *lastButton;

@end

@implementation TopButonView
- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.titles = titleArray;
}
- (void)setSelecedtArray:(NSArray *)selecedtArray {
    _selecedtArray = selecedtArray;
    self.selecteds = selecedtArray;
}
- (void)setUnSelectedArray:(NSArray *)unSelectedArray {
    _unSelectedArray = unSelectedArray;
    self.unSelecteds = unSelectedArray;
}
- (NSArray *)titles {

    if (!_titles) {
        _titles = [NSArray array];
    }
    return _titles;
}

- (NSArray *)unSelecteds {

    if (!_unSelecteds) {
        _unSelecteds = [NSArray array];
    }
    return _unSelecteds;
}

- (NSArray *)selecteds {

    if (!_selecteds) {
        _selecteds = [NSArray array];
    }
    return _selecteds;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger btnNum = self.titleArray.count;
    
    CGFloat btnW = SCREEN_WIDTH / btnNum;
    CGFloat btnH = 88;
    
    for (NSInteger i = 0; i < btnNum; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = 80 + i;
        button.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        
        // 正常状态
        
        [button setImage:[UIImage imageNamed:self.unSelecteds[i]] forState:UIControlStateNormal];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        // 选中状态
        [button setImage:[UIImage imageNamed:self.selecteds[i]] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffa11a"] forState:UIControlStateSelected];
        
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
        _difStateBlock(btn);
    }
    
    if (self.lastButton == btn) {
        
        return;
    } else {
        

        btn.selected = YES;
    }
    
    self.lastButton.selected = NO;
    
    self.lastButton = btn;

}

@end
