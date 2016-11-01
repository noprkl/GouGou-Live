//
//  LivingCenterView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LivingCenterView.h"

@interface LivingCenterView ()

/** 聊天 */
@property (strong, nonatomic) UIButton *talkBtn;

/** 狗狗 */
@property (strong, nonatomic) UIButton *dogBtn;

/** 客服 */
@property (strong, nonatomic) UIButton *serviceBtn;

/** 商家认证 */
@property (strong, nonatomic) UIButton *sellerBtn;

/** 上一个按钮 */
@property (strong, nonatomic) UIButton *lastBtn;

@end

@implementation LivingCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBtn:self.talkBtn title:@"消息" normalImage:[UIImage imageNamed:@"消息（直播小icon)"] selectImage:[UIImage imageNamed:@"消息（直播小icon)点击之后"]];
      
        [self setBtn:self.dogBtn title:@"狗狗" normalImage:[UIImage imageNamed:@"狗狗（直播小icon)"] selectImage:[UIImage imageNamed:@"狗狗（直播小icon)点之后"]];

        [self setBtn:self.serviceBtn title:@"客服" normalImage:[UIImage imageNamed:@"客服（直播小icon)"] selectImage:[UIImage imageNamed:@"客服（直播小icon)-拷贝点击"]];

        [self setBtn:self.sellerBtn title:@"认证商家" normalImage:[UIImage imageNamed:@"认证（直播小icon)"] selectImage:[UIImage imageNamed:@"认证（直播小icon)-拷贝点击"]];

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.talkBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
    [self.dogBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.right.equalTo(self.centerX);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    [self.serviceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.left.equalTo(self.centerX);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
    [self.sellerBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.top.equalTo(self.top);
        make.right.equalTo(self.right);
        make.width.equalTo(SCREEN_WIDTH / 4);
    }];
    
    
}
#pragma mark
#pragma mark - 懒加载

- (UIButton *)talkBtn {
    if (!_talkBtn) {
        _talkBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _talkBtn.selected = YES;
        _talkBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        self.lastBtn = _talkBtn;
        
        [_talkBtn addTarget:self action:@selector(clicktalkBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _talkBtn;
}

- (UIButton *)dogBtn {
    if (!_dogBtn) {
        _dogBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _dogBtn.backgroundColor = [UIColor whiteColor];

        [_dogBtn addTarget:self action:@selector(clickdogBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _dogBtn;
}


- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_serviceBtn sizeToFit];
        _serviceBtn.backgroundColor = [UIColor whiteColor];

        [_serviceBtn addTarget:self action:@selector(clickserviceBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _serviceBtn;
}

- (UIButton *)sellerBtn {
    if (!_sellerBtn) {
        
        _sellerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sellerBtn.backgroundColor = [UIColor whiteColor];

        [_sellerBtn addTarget:self action:@selector(clickSellerBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sellerBtn;
}
- (void)setBtn:(UIButton *)button title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage {

    // 正常
    NSDictionary *normalAttributeDict = @{
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSFontAttributeName:[UIFont systemFontOfSize:16]
                                          };
    NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:title attributes:normalAttributeDict];
    
    [button setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];
    [button setImage:normalImage forState:(UIControlStateNormal)];
    
    // 选中
    NSDictionary *selectAttributeDict = @{
                                          NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],
                                          NSFontAttributeName:[UIFont systemFontOfSize:16]
                                          };
    NSAttributedString *selectAttribute = [[NSAttributedString alloc] initWithString:title attributes:selectAttributeDict];
    [button setImage:selectImage forState:(UIControlStateSelected)];

    [button setAttributedTitle:selectAttribute forState:(UIControlStateSelected)];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self addSubview:button];
}
#pragma mark
#pragma mark - Action
- (void)clicktalkBtnAction:(UIButton *)btn {
    if (_talkBlock) {
        BOOL flag = _talkBlock(btn);
       
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;
    }
}
- (void)clickdogBtnAction:(UIButton *)btn {
    if (_dogBlock) {
        BOOL flag = _dogBlock(btn);
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;
    }
}
- (void)clickserviceBtnAction:(UIButton *)btn {
    if (_serviceBlock) {
        BOOL flag = _serviceBlock(btn);
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;
    }

}
- (void)clickSellerBtnAction:(UIButton *)btn {
    if (_sellerBlock) {
        BOOL flag = _sellerBlock(btn);
        self.lastBtn.selected = NO;
        self.lastBtn.backgroundColor = [UIColor whiteColor];
        btn.selected = flag;
        btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        self.lastBtn = btn;
    }

}
@end
