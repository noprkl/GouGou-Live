//
//  ShareAlertView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define kCol 4

#import "ShareAlertView.h"
#import "ShareBtn.h"
#import "ShareBtnModel.h"


@interface ShareAlertView ()
/** 按钮数组 */
@property (strong, nonatomic) NSMutableArray *btnArr;

/** block */
@property (strong, nonatomic) MainTopBlock tapBlock;

/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

@property(nonatomic, assign) CGFloat height; /**< 高度 */

@end

@implementation ShareAlertView

- (instancetype)initWithFrame:(CGRect)frame alertModels:(NSArray *)btnModelPlist tapView:(MainTopBlock)tapBlock colCount:(int)colCount
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];

        // 高度
        if (colCount == kCol) {
            _height = 147;
        }else if (colCount > kCol) {
            _height = 75;
        }
        self.tapBlock = tapBlock;
        
        int cols = colCount;
        int col = 0;
        int row = 0;
        
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat W = 60;
        CGFloat H = 50;
        
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cols * W) / (cols+1);
        CGFloat oriY = 5;
        
        for (int i = 0; i < btnModelPlist.count; i ++) {
            
            ShareBtnModel *model = btnModelPlist[i];
            
            ShareBtn *button = [ShareBtn buttonWithType:(UIButtonTypeCustom)];
            
            col = i % cols;
            row = i / cols;
            x = col * (W + margin) + margin;
            y = row * (H + margin) + oriY;
            button.frame = CGRectMake(x, y, W, H);
            
            button.tag = i + 20;
            
            NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:model.title attributes:@{NSForegroundColorAttributeName :[UIColor colorWithHexString:@"#999999"]}];
            [button setAttributedTitle:attribute forState:(UIControlStateNormal)];

            [button setImage:model.icon forState:(UIControlStateNormal)];
            
            [button addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self addSubview:button];
            
            [self.btnArr addObject:button];
        }
        
    }
    return self;
}
- (NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (void)clickBtn:(UIButton *)btn{
  
    if (_tapBlock) {
        _tapBlock(btn.tag);
        [self dismiss];
    }
}
#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer
{
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}

- (void)show
{
    _isDismiss = NO;
    
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - _height, SCREEN_WIDTH, _height);
    self.frame = rect;
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss
{
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn
{
    _isDismiss = YES;
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}
@end
