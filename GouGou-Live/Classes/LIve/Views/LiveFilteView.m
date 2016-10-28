//
//  LiveFilteView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define kWidth ((self.bounds.size.width - 3) / 3)


#import "LiveFilteView.h"
#import "FilteButton.h"



@interface LiveFilteView ()

/** 体型按钮 */
@property (strong, nonatomic) FilteButton *sizeBtn;

/** 线1 */
@property (strong, nonatomic) UILabel *line1;

/** 年龄 */
@property (strong, nonatomic) FilteButton *ageBtn;

/** 线2 */
@property (strong, nonatomic) UILabel *line2;

/** 价格 */
@property (strong, nonatomic) FilteButton *priceBtn;

/** 底部线 */
@property (strong, nonatomic) UILabel *lineBottom;

@end

@implementation LiveFilteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.sizeBtn];
        [self addSubview:self.line1];
        [self addSubview:self.ageBtn];
        [self addSubview:self.line2];
        [self addSubview:self.priceBtn];
        [self addSubview:self.lineBottom];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.sizeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.bottom.equalTo(self.bottom).offset(-2);
        make.width.equalTo(kWidth);
    }];
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sizeBtn.right);
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(1, 30));
    }];
    
    [self.ageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.sizeBtn.right);
        make.bottom.equalTo(self.bottom).offset(-2);
        make.width.equalTo(kWidth);
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ageBtn.right);
        make.centerY.equalTo(self.centerY);
        make.size.equalTo(CGSizeMake(1, 30));
    }];
    [self.priceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom).offset(-2);
        make.width.equalTo(kWidth);
    }];
    [self.lineBottom makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom);
        make.centerX.equalTo(self.centerX);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
}
#pragma mark
#pragma mark - 懒加载
- (FilteButton *)sizeBtn {
    if (!_sizeBtn) {
        _sizeBtn = [FilteButton buttonWithType:(UIButtonTypeSystem)];
       
        [_sizeBtn setTitle:@"体型" forState:(UIControlStateNormal)];

        [_sizeBtn setImage:[UIImage imageNamed:@"矩形-33"] forState:(UIControlStateNormal)];
        [_sizeBtn addTarget:self action:@selector(clickSizeBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sizeBtn;
}

- (UILabel *)line1 {
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#b2b2b2"];
    }
    return _line1;
}

- (FilteButton *)ageBtn {
    if (!_ageBtn) {
        _ageBtn = [FilteButton buttonWithType:(UIButtonTypeSystem)];

        [_ageBtn setTitle:@"年龄" forState:(UIControlStateNormal)];
        [_ageBtn setImage:[UIImage imageNamed:@"矩形-33"] forState:(UIControlStateNormal)];
        [_ageBtn addTarget:self action:@selector(clickAgeBtnAction) forControlEvents:(UIControlEventTouchDown)];

    }
    return _ageBtn;
}

- (UILabel *)line2 {
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#b2b2b2"];
    }
    return _line2;
}

- (FilteButton *)priceBtn {
    if (!_priceBtn) {
        _priceBtn = [FilteButton buttonWithType:(UIButtonTypeSystem)];
       
        [_priceBtn setTitle:@"价格" forState:(UIControlStateNormal)];
        [_priceBtn setImage:[UIImage imageNamed:@"矩形-33"] forState:(UIControlStateNormal)];
        [_priceBtn addTarget:self action:@selector(clickPriceBtnAction) forControlEvents:(UIControlEventTouchDown)];

    }
    return _priceBtn;
}

- (UILabel *)lineBottom {
    if (!_lineBottom) {
        _lineBottom = [[UILabel alloc] init];
        _lineBottom.backgroundColor = [UIColor colorWithHexString:@"#b2b2b2"];
    }
    return _lineBottom;
}
#pragma mark
#pragma mark - Action
- (void)clickSizeBtnAction {
    if (_sizeBlock) {
        _sizeBlock();
    }
}
- (void)clickAgeBtnAction {
    if (_ageBlock) {
        _ageBlock();
    }
}
- (void)clickPriceBtnAction {
    if (_priceBlock) {
        _priceBlock();
    }
}
@end
