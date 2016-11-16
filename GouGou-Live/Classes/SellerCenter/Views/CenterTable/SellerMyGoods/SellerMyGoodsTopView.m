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
@property (strong, nonatomic) UIButton *allCountBtn;

/** 收入 */
@property (strong, nonatomic) UIButton *incomeBtn;

/** 支出 */
@property (strong, nonatomic) UIButton *outcomeBtn;

/** 交易中 */
@property (strong, nonatomic) UIButton *detailingBtn;

/** 上一个按钮 */
@property (strong, nonatomic) UIButton *lastBtn;

@end

@implementation SellerMyGoodsTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBtn:self.allCountBtn title:@"全部"];
        
        [self setBtn:self.incomeBtn title:@"待售"];
        
        [self setBtn:self.outcomeBtn title:@"已售"];
        
        [self setBtn:self.detailingBtn title:@"审核"];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.allCountBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
    [self.incomeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.right.equalTo(self.centerX);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    [self.outcomeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.left.equalTo(self.centerX);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
    [self.detailingBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.right.equalTo(self.right);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
}
#pragma mark
#pragma mark - 懒加载

- (UIButton *)allCountBtn {
    if (!_allCountBtn) {
        _allCountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _allCountBtn.selected = YES;
        _allCountBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn = _allCountBtn;
        
        [_allCountBtn addTarget:self action:@selector(clickallCountBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _allCountBtn;
}

- (UIButton *)incomeBtn {
    if (!_incomeBtn) {
        _incomeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _incomeBtn.backgroundColor = [UIColor whiteColor];
        [_incomeBtn addTarget:self action:@selector(clickincomeBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _incomeBtn;
}
- (UIButton *)outcomeBtn {
    if (!_outcomeBtn) {
        _outcomeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _outcomeBtn.backgroundColor = [UIColor whiteColor];
        //        [_outcomeBtn sizeToFit];
        
        [_outcomeBtn addTarget:self action:@selector(clickoutcomeBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _outcomeBtn;
}

- (UIButton *)detailingBtn {
    if (!_detailingBtn) {
        
        _detailingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _detailingBtn.backgroundColor = [UIColor whiteColor];
        [_detailingBtn addTarget:self action:@selector(clickdetailingBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _detailingBtn;
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
- (void)clickallCountBtnAction:(UIButton *)btn {
    if (_allBlock) {
        _allBlock();
        
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        self.lastBtn = btn;
    }
}
- (void)clickincomeBtnAction:(UIButton *)btn {
    if (_waitSellBlock) {
        _waitSellBlock();
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        self.lastBtn = btn;
    }
}
- (void)clickoutcomeBtnAction:(UIButton *)btn {
    if (_soldBlock) {
        _soldBlock();
        
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        self.lastBtn = btn;
    }
    
}
- (void)clickdetailingBtnAction:(UIButton *)btn {
    if (_reviewBlock) {
        _reviewBlock();
       
        btn.selected = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        self.lastBtn = btn;
    }
    
}



@end
