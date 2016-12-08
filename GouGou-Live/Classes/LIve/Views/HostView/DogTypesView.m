//
//  DogTypesView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogTypesView.h"

@interface DogTypesView ()
///** 易驯养 */
//@property (strong,nonatomic) UIButton *easyBtn;
///** 不掉毛 */
//@property (strong,nonatomic) UIButton *noDropFurBtn;
///** 忠诚 */
//@property (strong,nonatomic) UIButton *faithBtn;
///** 可爱 */
//@property (strong,nonatomic) UIButton *lovelyBtn;
///** 更多印象 */
//@property (strong,nonatomic) UIButton *moreImpressBtn;
/** buttons数组 */
@property (strong,nonatomic) NSMutableArray *buttonsArray;

/** 数据 */
@property (strong,nonatomic) NSArray *datalist;

/** 上一个按钮 */
@property (strong,nonatomic) UIButton *lastBtn;


@end

@implementation DogTypesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addbuttons];
        
    }
    return self;
}

- (void)addbuttons {
    
    NSInteger cols = 5;
//    CGFloat btnW = 63;

    CGFloat btnW = (SCREEN_WIDTH - (cols + 1) * kDogImageWidth)/cols;
    CGFloat btnH = 25;
    CGFloat margin = kDogImageWidth;
    CGFloat btnY = kDogImageWidth;
    CGFloat boardMargin = (SCREEN_WIDTH - cols * btnW - (cols- 1)* margin)/2;
    
    for (NSInteger i = 0; i < cols; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        if (i == 0) {
            btn.frame = CGRectMake(boardMargin, btnY, btnW, btnH);
        }
        
        btn.frame = CGRectMake(boardMargin + (margin + btnW)*i, btnY, btnW, btnH);
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        btn.tag = i + 30;
        
        [btn setTitle:self.datalist[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];

        btn.titleLabel.font = [UIFont systemFontOfSize:14];
      
        [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

        [btn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
        
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.buttonsArray addObject:btn];
        [self addSubview:btn];
        
    }
}
- (NSArray *)datalist {
    
    if (!_datalist) {
        _datalist = @[@"易驯养",@"忠诚",@"不掉毛",@"可爱",@"更多印象"];
    }
    return _datalist;
}
- (void)clickBtnAction:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

    if (_btnBlock) {

        _btnBlock(button);
    }
}
- (void)btnHighlightColor:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
}


@end

