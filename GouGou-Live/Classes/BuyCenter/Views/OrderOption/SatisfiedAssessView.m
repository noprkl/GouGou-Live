//
//  SatisfiedAssessView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SatisfiedAssessView.h"

@interface SatisfiedAssessView ()
/** 交易满意度 */
@property (strong,nonatomic) UILabel *satisfiledLabel;
/** 星星 */
@property (strong,nonatomic) UIButton *starBtn;
/** 存放星星的数组 */
@property (strong,nonatomic) NSMutableArray *startArray;
@end

@implementation SatisfiedAssessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.satisfiledLabel];
        [self creatStarBtn];
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_satisfiledLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10)
        ;
        make.centerY.equalTo(weakself.centerY);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)satisfiledLabel {

    if (!_satisfiledLabel) {
        _satisfiledLabel = [[UILabel alloc] init];
        _satisfiledLabel.text = @"交易满意度";
        _satisfiledLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _satisfiledLabel.font = [UIFont systemFontOfSize:14];
    }
    return _satisfiledLabel;
}
#pragma mark - 创建星星
- (void)creatStarBtn {

    CGFloat btnX = 90;
    CGFloat btnW = 15;
    CGFloat BtnH = btnW;
    CGFloat btnY = 15;
    for (NSInteger i = 0; i < 5; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(btnX + i * btnW, btnY, btnW, BtnH);
        
        [button setImage:[UIImage imageNamed:@"星星白"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"星星黄"] forState:UIControlStateSelected];
        
        [self.startArray addObject:button];
        
        [button addTarget:self action:@selector(clickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
    }
    
}
- (void)clickStartBtn:(UIButton *)button {

    for (UIButton *btn in self.startArray) {
        
        if (button.selected) {
         button.selected = !button.selected;
            if (btn.frame.origin.x < button.frame.origin.x) {
                
                btn.selected = YES;
                [button setImage:[UIImage imageNamed:@"星星黄"] forState:UIControlStateSelected];
                btn.userInteractionEnabled = NO;
            } 
        }
    }

}
@end
