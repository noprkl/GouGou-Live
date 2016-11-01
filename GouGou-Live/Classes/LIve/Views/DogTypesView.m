//
//  DogTypesView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogTypesView.h"

@interface DogTypesView ()

/** 易驯养 */
@property (strong,nonatomic) UIButton *easyBtn;
/** 不掉毛 */
@property (strong,nonatomic) UIButton *noDropFurBtn;
/** 忠诚 */
@property (strong,nonatomic) UIButton *faithBtn;
/** 可爱 */
@property (strong,nonatomic) UIButton *lovelyBtn;
/** 更多印象 */
@property (strong,nonatomic) UIButton *moreImpressBtn;

@property(nonatomic, strong) UIButton *lastBtn; /**< <#注释#> */
@end

@implementation DogTypesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self addSubview:self.easyBtn];
        [self addSubview:self.noDropFurBtn];
        [self addSubview:self.faithBtn];
        [self addSubview:self.lovelyBtn];
        [self addSubview:self.moreImpressBtn];
        
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    [_easyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.left).offset(10);
        make.size.equalTo(CGSizeMake(63, 25));
    }];
    _easyBtn.layer.cornerRadius = 5;
    _easyBtn.layer.masksToBounds = YES;
    
    [_noDropFurBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.easyBtn.right).offset(10);
        make.size.equalTo(CGSizeMake(63, 25));

    }];
    
    [_faithBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.noDropFurBtn.right).offset(10);
        make.size.equalTo(CGSizeMake(63, 25));
        
    }];
    
    [_lovelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.faithBtn.right).offset(10);
        make.size.equalTo(CGSizeMake(63, 25));
        
    }];
    
    [_moreImpressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(15);
        make.left.equalTo(weakself.lovelyBtn.right).offset(10);
        make.size.equalTo(CGSizeMake(63, 25));
        
    }];

}

#pragma mark
#pragma mark - 懒加载
- (UIButton *)easyBtn {

    if (!_easyBtn) {
        
        _easyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _easyBtn.layer.borderColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0 blue:228 / 255.0 alpha:1].CGColor;
        _easyBtn.layer.borderWidth = 2;
        [_easyBtn setTitle:@"易驯养" forState:UIControlStateNormal];
        [_easyBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_easyBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateSelected)];

        _easyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_easyBtn addTarget:self action:@selector(clickEasyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _easyBtn;
}

- (UIButton *)noDropFurBtn {

    if (!_noDropFurBtn) {
        _noDropFurBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _noDropFurBtn.layer.cornerRadius = 5;
        _noDropFurBtn.layer.masksToBounds = YES;
        _noDropFurBtn.layer.borderColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0 blue:228 / 255.0 alpha:1].CGColor;
        _noDropFurBtn.layer.borderWidth = 2;
        [_noDropFurBtn setTitle:@"不掉毛" forState:UIControlStateNormal];
        [_noDropFurBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_noDropFurBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateSelected)];

        _noDropFurBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_noDropFurBtn addTarget:self action:@selector(clickNoDropFurBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _noDropFurBtn;
}

- (UIButton *)faithBtn {

     if(!_faithBtn) {
        _faithBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _faithBtn.layer.cornerRadius = 5;
        _faithBtn.layer.masksToBounds = YES;
         _faithBtn.layer.borderColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0 blue:228 / 255.0 alpha:1].CGColor;
         _faithBtn.layer.borderWidth = 2;
        [_faithBtn setTitle:@"忠诚" forState:UIControlStateNormal];
        [_faithBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
         [_faithBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateSelected)];

        _faithBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_faithBtn addTarget:self action:@selector(clickFaithBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faithBtn;
}
    
- (UIButton *)lovelyBtn {

    if (!_lovelyBtn) {
        _lovelyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lovelyBtn.layer.cornerRadius = 5;
        _lovelyBtn.layer.masksToBounds = YES;
        
        _lovelyBtn.layer.borderColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0 blue:228 / 255.0 alpha:1].CGColor;
        _lovelyBtn.layer.borderWidth = 2;
        
        [_lovelyBtn setTitle:@"可爱" forState:UIControlStateNormal];
        [_lovelyBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [_lovelyBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateSelected)];
        _lovelyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_lovelyBtn addTarget:self action:@selector(clickLovelyBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lovelyBtn;
}

- (UIButton *)moreImpressBtn {

    if (!_moreImpressBtn) {
        _moreImpressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreImpressBtn.layer.cornerRadius = 5;
        _moreImpressBtn.layer.masksToBounds = YES;
        _moreImpressBtn.layer.borderColor = [UIColor colorWithRed:228 / 255.0 green:228 / 255.0 blue:228 / 255.0 alpha:1].CGColor;
        _moreImpressBtn.layer.borderWidth = 2;
        [_moreImpressBtn setTitle:@"更多印象" forState:UIControlStateNormal];
        [_moreImpressBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _moreImpressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_moreImpressBtn addTarget:self action:@selector(clickMoreImpressBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreImpressBtn;
}
#pragma mark
#pragma mark - 点击回调方法
- (void)clickEasyBtn:(UIButton *)btn {
    if (_easyBtnBlock) {
       BOOL flag = _easyBtnBlock();
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;

    }

}
- (void)clickNoDropFurBtn:(UIButton *)btn {
    if (_noDropFureBlock) {
        BOOL flag = _noDropFureBlock();
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;

    }
    
}
- (void)clickFaithBtn:(UIButton *)btn {
    if (_faithBtnBlock) {
        BOOL flag = _faithBtnBlock();
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;

    }
}
- (void)clickLovelyBtn:(UIButton *)btn {
    
    if (_lovelyBtnBlock) {
        BOOL flag = _lovelyBtnBlock();
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;

    }
}
- (void)clickMoreImpressBtn {
    
    if (_moreImpressBtnBlock) {
        _moreImpressBtnBlock();
    }
}
    
@end

