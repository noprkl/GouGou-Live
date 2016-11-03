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


@property(nonatomic, strong) UIButton *lastBtn; /**< 上一个点击的btn */
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
            
            // 正常
            NSDictionary *normalAttributeDict = @{
                                           NSForegroundColorAttributeName:[[UIColor colorWithHexString:@"#ffffff"] colorWithAlphaComponent:0.8],
                                           NSFontAttributeName:[UIFont systemFontOfSize:18]
                                           };
            NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:title attributes:normalAttributeDict];
            
            [button setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];

            // 选中
            NSDictionary *selectAttributeDict = @{
                                                  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                  };
            NSAttributedString *selectAttribute = [[NSAttributedString alloc] initWithString:title attributes:selectAttributeDict];
            
            [button setAttributedTitle:selectAttribute forState:(UIControlStateSelected)];
            
            button.frame = CGRectMake(i * btnWid, 0, btnWid, btnHig);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
            
            [self addSubview:button];
            if (i == 1) {
                button.selected = YES;
                self.lastBtn = button;
            }
            
            if (i == 1) {
                
                // 添加下划线
                // 下划线宽度 = 按钮文字宽度
                // 下划线中心点x = 按钮中心点x (竖直方向)
                
                // 先计算文字宽度 给label赋值
                [button.titleLabel sizeToFit];
                
                UIView *lineView = [[UIView alloc] init];
                [self addSubview:lineView];
                
                [lineView makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(button.titleLabel.centerX);
                    make.bottom.equalTo(self.bottom);
                    make.size.equalTo(CGSizeMake(50, 2));
                }];
                
                lineView.backgroundColor = [UIColor whiteColor];
                
                self.lineView = lineView;
            }
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)button {
    button.selected = YES;
    self.lastBtn.selected = NO;
    self.lastBtn = button;
    
    
    self.tapBlock(button.tag);
    
    [self scrolling:button.tag];
    
}
- (void)scrolling:(NSInteger)btnTag
{
    UIButton *button = self.buttons[btnTag];
    
    //线的动画
    [UIView animateWithDuration:2 animations:^{
        
        [self.lineView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottom);
            make.size.equalTo(CGSizeMake(50, 2));
            make.centerX.equalTo(button.centerX);
        }];
        
    }];
}
@end
