//
//  DogTypesView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogTypesView.h"
#import "MoreImpressionModel.h"

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
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}
- (void)setImpressionArr:(NSArray *)impressionArr {
    _impressionArr = impressionArr;
    NSInteger cols = impressionArr.count;
    self.contentSize = CGSizeMake(70 * cols + 35, 0);
    self.contentOffset = CGPointMake(0, 0);
    CGFloat space = 5;
    
//    CGFloat btnW = (SCREEN_WIDTH - (cols + 1) * space)/cols;
    CGFloat btnW = 70;
    
    CGFloat btnH = 30;
    CGFloat margin = space;
    CGFloat btnY = self.frame.size.height / 2 - btnH / 2;
    
//    CGFloat boardMargin = (SCREEN_WIDTH - cols * btnW - (cols- 1)* margin)/2;
    
    
    for (NSInteger i = 0; i < cols; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        btn.tag = i + 30;
        MoreImpressionModel *model = self.impressionArr[i];
        
        [btn setTitle:model.name forState:UIControlStateNormal];
        
        
        if (i == 0) {
            btn.frame = CGRectMake(space, btnY, btnW, btnH);
        } else {
            btn.frame = CGRectMake(space + (margin + btnW)*i, btnY, btnW, btnH);
        }
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        
        [btn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
        
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buttonsArray addObject:btn];
        [self addSubview:btn];
    }
}
- (void)clickBtnAction:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

    MoreImpressionModel *model = self.impressionArr[button.tag - 30];
    if (_btnBlock) {

        _btnBlock(model);
    }
}
- (void)btnHighlightColor:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
}


@end

