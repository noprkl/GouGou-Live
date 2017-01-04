//
//  SearchLiveKindBtnView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/30.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define Cols 5
#import "SearchLiveKindBtnView.h"
#import "LiveHotSearchModel.h"

@interface SearchLiveKindBtnView ()

/** 上一个按钮 */
@property (strong,nonatomic) UIButton *lastBtn;

@end


@implementation SearchLiveKindBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 按钮总数
    NSInteger count = self.datalist.count;
    // 当前行数
    NSInteger row = 0;
    // 当前列数
    NSInteger col = 0;
    
    // xy 初始位置
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    CGFloat btnH = 25;
    
    // 边框
    CGFloat bordW = 1;
    // 间距
    CGFloat btnW = (SCREEN_WIDTH - ((Cols + 1) * kDogImageWidth + bordW)) / Cols;
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        row = i / Cols;
        col = i % Cols;
        
        btnX = (btnW + kDogImageWidth + bordW * 2) * col +kDogImageWidth;
        btnY = (btnH + kDogImageWidth + bordW * 2) * row + kDogImageWidth;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = bordW;
        btn.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        LiveHotSearchModel *model = self.datalist[i];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        
        [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}
- (CGFloat)getViewHeight:(NSArray *)datalist {
    
    if (datalist.count % Cols == 0) {
        return (datalist.count / Cols) *(kDogImageWidth + 25) + kDogImageWidth;
    }else{
        return (datalist.count / Cols + 1) *(kDogImageWidth + 25) + kDogImageWidth;
    }
}
- (void)setDatalist:(NSArray *)datalist {
    _datalist = datalist;
}
- (void)clickBtnAction:(UIButton *)button {
    [self.lastBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    
    [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
    self.lastBtn = button;
    
    if (_clickBlcok) {
        _clickBlcok([button currentTitle]);
    }
}


@end
