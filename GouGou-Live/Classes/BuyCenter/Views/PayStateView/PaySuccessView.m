//
//  PaySuccessView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PaySuccessView.h"

@interface PaySuccessView  ()

/** 狗狗图片 */
@property (strong,nonatomic) UIImageView *dogImage;
/** 支付状态提示 */
@property (strong,nonatomic) UILabel *payState;
/** 查看订单 */
@property (strong,nonatomic) UIButton *checkOrderBtn;
/** 返回首页 */
@property (strong,nonatomic) UIButton *backHomePag;

@end

@implementation PaySuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.dogImage];
        [self addSubview:self.payState];
        [self addSubview:self.checkOrderBtn];
        [self addSubview:self.backHomePag];
        
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (UIImageView *)dogImage {

    if (!_dogImage) {
        _dogImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"矢量智能对象"]];
    }
    return _dogImage;
}

- (UILabel *)payState {

    if (!_payState) {
        _payState = [[UILabel alloc] init];
        _payState.text = @"支付成功";
        _payState.font = [UIFont systemFontOfSize:14];
        _payState.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _payState;
}

- (UIButton *)checkOrderBtn {

    if (!_checkOrderBtn) {
        _checkOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        [_checkOrderBtn setTitleColor:[UIColor colorWithHexString:@"0000000"] forState:UIControlStateNormal];
        [_checkOrderBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_checkOrderBtn addTarget:self action:@selector(clickCheckOreder:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkOrderBtn;
}

- (UIButton *)backHomePag {

    if (!_backHomePag) {
        _backHomePag = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backHomePag setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [_backHomePag setTitle:@"返回首页" forState:UIControlStateNormal];
        [_backHomePag setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_backHomePag addTarget:self action:@selector(clickBackHomePage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backHomePag;
}
// 点击查看详情
- (void)clickCheckOreder:(UIButton *)button {

    button.selected = !button.selected;

}
// 点击返回首页
- (void)clickBackHomePage:(UIButton *)button {

    if (!_backHomePageBlock) {
        _backHomePageBlock(button);
    }
    
}

@end
