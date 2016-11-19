//
//  SellerMyGoodsTopView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerMyGoodsTopView.h"


@interface SellerMyGoodsTopView ()

/** 全部 */
@property (strong, nonatomic) UIButton *allMessageBtn;

/** 收入 */
@property (strong, nonatomic) UIButton *waitSellBtn;

/** 支出 */
@property (strong, nonatomic) UIButton *soldBtn;

/** 交易中 */
@property (strong, nonatomic) UIButton *reviewBtn;

/** 上一个按钮 */
@property (strong, nonatomic) UIButton *lastBtn;

@end

@implementation SellerMyGoodsTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBtn:self.allMessageBtn title:@"全部"];
        
        [self setBtn:self.waitSellBtn title:@"待售"];
        
        [self setBtn:self.soldBtn title:@"已售"];
        
        [self setBtn:self.reviewBtn title:@"审核"];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.allMessageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
    [self.waitSellBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.left.equalTo(self.allMessageBtn.right);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];

    [self.reviewBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.right.equalTo(self.right);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    [self.soldBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.right.equalTo(self.reviewBtn.left);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
}
- (void)setCanClick:(BOOL)canClick {
    _canClick = canClick;
    self.allMessageBtn.enabled = canClick;
    self.waitSellBtn.enabled = canClick;
    self.soldBtn.enabled = canClick;
    self.reviewBtn.enabled = canClick;
}
#pragma mark
#pragma mark - 懒加载

- (UIButton *)allMessageBtn {
    if (!_allMessageBtn) {
        _allMessageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _allMessageBtn.selected = YES;
        _allMessageBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn = _allMessageBtn;
        
        [_allMessageBtn addTarget:self action:@selector(clickallMessageBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _allMessageBtn;
}

- (UIButton *)waitSellBtn {
    if (!_waitSellBtn) {
        _waitSellBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _waitSellBtn.backgroundColor = [UIColor whiteColor];
        [_waitSellBtn addTarget:self action:@selector(clickwaitSellBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _waitSellBtn;
}
- (UIButton *)soldBtn {
    if (!_soldBtn) {
        _soldBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _soldBtn.backgroundColor = [UIColor whiteColor];
        //        [_soldBtn sizeToFit];
        
        [_soldBtn addTarget:self action:@selector(clicksoldBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _soldBtn;
}

- (UIButton *)reviewBtn {
    if (!_reviewBtn) {
        
        _reviewBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _reviewBtn.backgroundColor = [UIColor whiteColor];
        [_reviewBtn addTarget:self action:@selector(clickreviewBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _reviewBtn;
}
- (void)setBtn:(UIButton *)button title:(NSString *)title {
    
    // 正常
    NSDictionary *normalAttributeDict = @{
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSFontAttributeName:[UIFont systemFontOfSize:16]
                                          };
    NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:title attributes:normalAttributeDict];
    
    [button setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];
    
    // 选中
    NSDictionary *selectAttributeDict = @{
                                          NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],
                                          NSFontAttributeName:[UIFont systemFontOfSize:16]
                                          };
    NSAttributedString *selectAttribute = [[NSAttributedString alloc] initWithString:title attributes:selectAttributeDict];
    
    [button setAttributedTitle:selectAttribute forState:(UIControlStateSelected)];
    
    [self addSubview:button];
}
#pragma mark
#pragma mark - Action
- (void)clickallMessageBtnAction:(UIButton *)btn {

//    [self ClickBtnWith:btn];
    if (_allBlock) {
        [self ClickBtnWith:btn];
        _allBlock();
    }
}
- (void)clickwaitSellBtnAction:(UIButton *)btn {

    if (_waitSellBlock) {
        [self ClickBtnWith:btn];
        _waitSellBlock();
    }
   
}
- (void)clicksoldBtnAction:(UIButton *)btn {
   
    if (_soldBlock) {
        [self ClickBtnWith:btn];
        _soldBlock();
        
    }
//        [self ClickBtnWith:btn];
}
- (void)clickreviewBtnAction:(UIButton *)btn {
    if (_reviewBlock) {
      [self ClickBtnWith:btn];
        _reviewBlock();
    }
//    [self ClickBtnWith:btn];
}

- (void)ClickBtnWith:(UIButton *)btn{
    self.lastBtn.selected = NO;
    self.lastBtn.backgroundColor = [UIColor whiteColor];
    self.lastBtn = btn;
    
    btn.selected = YES;
    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
}

@end
