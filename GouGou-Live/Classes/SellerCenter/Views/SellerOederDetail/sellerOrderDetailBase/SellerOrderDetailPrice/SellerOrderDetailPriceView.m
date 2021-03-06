//
//  SellerOrderDetailPriceView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailPriceView.h"

@interface SellerOrderDetailPriceView ()

@property(nonatomic, strong) UILabel *allPrice; /**< 总价 */

@property(nonatomic, strong) UILabel *templatePrice; /**< 运费 */

@property(nonatomic, strong) UILabel *favorablePrice; /**< 优惠 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@property(nonatomic, strong) UIView *backView; /**< 背景 */

@property(nonatomic, strong) UILabel *realPrice; /**< 实付 */

@end
@implementation SellerOrderDetailPriceView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.allPrice];
        [self addSubview:self.allPriceCount];
        [self addSubview:self.templatePrice];
        [self addSubview:self.templatePriceCount];
        [self addSubview:self.favorablePrice];
        [self addSubview:self.favorablePriceCount];
        [self addSubview:self.line];
        [self addSubview:self.backView];
        [self.backView addSubview:self.realPrice];
        [self.backView addSubview:self.realPriceCount];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.allPrice makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.allPriceCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.allPrice.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.templatePrice makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allPrice.bottom).offset(30);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.templatePriceCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.templatePrice.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.favorablePrice makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.templatePrice.bottom).offset(30);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.favorablePriceCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.favorablePrice.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.favorablePrice.bottom).offset(15);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    [self.backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.bottom);
        make.left.equalTo(self.left);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
    [self.realPriceCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.realPrice makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.realPriceCount.centerY);
        make.right.equalTo(self.realPriceCount.left);
    }];
    
    
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)allPrice {
    if (!_allPrice) {
        _allPrice = [[UILabel alloc] init];
        _allPrice.text = @"商品总价";
        _allPrice.font = [UIFont systemFontOfSize:16];
    }
    return _allPrice;
}
- (UILabel *)allPriceCount {
    if (!_allPriceCount) {
        _allPriceCount = [[UILabel alloc] init];
        _allPriceCount.text = @"2400";
        _allPriceCount.font = [UIFont systemFontOfSize:16];
        _allPriceCount.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }
    return _allPriceCount;
}

- (UILabel *)templatePrice {
    if (!_templatePrice) {
        _templatePrice = [[UILabel alloc] init];
        _templatePrice.text = @"运费";
        _templatePrice.font = [UIFont systemFontOfSize:16];
    }
    return _templatePrice;
}
- (UILabel *)templatePriceCount {
    if (!_templatePriceCount) {
        _templatePriceCount = [[UILabel alloc] init];
        _templatePriceCount.text = @"50";
        _templatePriceCount.font = [UIFont systemFontOfSize:16];
        _templatePriceCount.textColor = [UIColor colorWithHexString:@"#ffa11a"];

    }
    return _templatePriceCount;
}

- (UILabel *)favorablePrice {
    if (!_favorablePrice) {
        _favorablePrice = [[UILabel alloc] init];
        _favorablePrice.text = @"优惠";
        _favorablePrice.font = [UIFont systemFontOfSize:16];
    }
    return _favorablePrice;
}
- (UILabel *)favorablePriceCount {
    if (!_favorablePriceCount) {
        _favorablePriceCount = [[UILabel alloc] init];
        _favorablePriceCount.text = @"1000";
        _favorablePriceCount.font = [UIFont systemFontOfSize:16];
        _favorablePriceCount.textColor = [UIColor colorWithHexString:@"#ffa11a"];

    }
    return _favorablePriceCount;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UILabel *)realPrice {
    if (!_realPrice) {
        _realPrice = [[UILabel alloc] init];
        _realPrice.text = @"实付款：";
        _realPrice.font = [UIFont boldSystemFontOfSize:16];
    }
    return _realPrice;
}
- (UILabel *)realPriceCount {
    if (!_realPriceCount) {
        _realPriceCount = [[UILabel alloc] init];
        _realPriceCount.text = @"¥ 1450";
        _realPriceCount.font = [UIFont boldSystemFontOfSize:20];
        _realPriceCount.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }
    return _realPriceCount;
}
@end
