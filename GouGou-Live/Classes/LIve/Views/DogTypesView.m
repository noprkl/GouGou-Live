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
    NSInteger btnW = 63;
    NSInteger btnH = 25;
    NSInteger margin = 10;
    NSInteger btnY = 10;
    NSInteger boardMargin = (self.frame.size.width - cols * btnW - (cols- 1)* margin)/2;
    
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
        btn.tag = i + 100 ;
        [btn setTitle:self.datalist[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
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
   
    if (self.btnBlock) {
        self.btnBlock(button);
    }
   
    
        if(self.lastBtn == button) {
            //上次点击过的按钮，不做处理
        } else{
            //本次点击的按钮设为设置颜色
            [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
            //将上次点击过的按钮设为黑色
            [self.lastBtn setBackgroundColor:[UIColor whiteColor]];
        }
        _lastBtn = button;
    
}


@end

