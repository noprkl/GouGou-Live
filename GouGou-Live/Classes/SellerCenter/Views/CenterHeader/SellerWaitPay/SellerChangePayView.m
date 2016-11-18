//
//  SellerChangePayView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//
#define kHeight 177

#import "SellerChangePayView.h"

@interface SellerChangePayView ()<UITextFieldDelegate>

#pragma mark - 控件
@property(nonatomic, strong) UILabel *realPay; /**< 实付尾款 */
@property(nonatomic, strong) UILabel *realPayNumber; /**< 实付尾款数 */

@property(nonatomic, strong) UILabel *changeMoney; /**< 修改尾款 */

@property(nonatomic, strong) UIView *editBackView; /**< 编辑背景 */

@property(nonatomic, strong) UITextField *changeTextField; /**< 修改文本框 */

@property(nonatomic, strong) UIView *line1; /**< 线1 */
@property(nonatomic, strong) UIView *backView2; /**< 背景 */
@property(nonatomic, strong) UILabel *googsPrice; /**< 商品价格 */
@property(nonatomic, strong) UILabel *googsPriceNumber; /**< 新商品价格 */
@property(nonatomic, strong) UILabel *googsOldPriceNumber; /**< 商品老价格 */

@end
@implementation SellerChangePayView

#pragma mark
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:self.realPay];
        [self addSubview:self.realPayNumber];
        
        [self addSubview:self.changeMoney];
        [self addSubview:self.editBackView];
        [self.editBackView addSubview:self.changeTextField];

        [self addSubview:self.line1];
        
        [self addSubview:self.backView2];
        [self.backView2 addSubview:self.googsPrice];
        [self.backView2 addSubview:self.googsPriceNumber];
        [self.backView2 addSubview:self.googsOldPriceNumber];
    }
    return self;
}
// 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    // 尾款
    [self.realPay makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.realPayNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.realPay.centerY);
        make.left.equalTo(self.realPay.right).offset(10);
    }];

    // 修改
    [self.changeMoney makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.realPay.top).offset(30);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.editBackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeMoney.centerY);
        make.left.equalTo(self.changeMoney.right).offset(10);
        make.size.equalTo(CGSizeMake(125, 33));
    }];
    [self.changeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.editBackView.centerY);
        make.left.equalTo(self.left).offset(9);
        make.right.equalTo(self.right).offset(-9);
        make.height.equalTo(33);
    }];

    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeMoney.bottom).offset(15);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    // 商品价格
    [self.backView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    
    [self.googsPrice makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
  
    [self.googsPriceNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.centerY);
        make.left.equalTo(self.googsPrice.right).offset(10);
    }];
    [self.googsOldPriceNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.centerY);
        make.left.equalTo(self.googsPriceNumber.right).offset(10);
    }];
}
#pragma mark
#pragma mark - 懒加载

- (UILabel *)realPay {
    if (!_realPay) {
        _realPay = [[UILabel alloc] init];
        _realPay.text =@"实付尾款：";
        _realPay.textColor = [UIColor colorWithHexString:@"#000000"];
        _realPay.font = [UIFont systemFontOfSize:16];
    }
    return _realPay;
}
- (UILabel *)realPayNumber {
    if (!_realPayNumber) {
        _realPayNumber = [[UILabel alloc] init];
        _realPayNumber.text =@"¥ 950";
        _realPayNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        _realPayNumber.font = [UIFont systemFontOfSize:14];
    }
    return _realPayNumber;
}

- (UILabel *)changeMoney {
    if (!_changeMoney) {
        _changeMoney = [[UILabel alloc] init];
        _changeMoney.text =@"修改尾款：";
        _changeMoney.textColor = [UIColor colorWithHexString:@"#000000"];
        _changeMoney.font = [UIFont systemFontOfSize:16];
    }
    return _changeMoney;
}
- (UIView *)editBackView {
    if (!_editBackView) {
        _editBackView = [[UIView alloc] init];
        _editBackView.layer.masksToBounds = YES;
        _editBackView.layer.cornerRadius = 9;
        _editBackView.layer.borderColor = [UIColor colorWithHexString:@"#e0e0e0"].CGColor;
        _editBackView.layer.borderWidth = 1;
    }
    return _editBackView;
}
- (UITextField *)changeTextField {
    if (!_changeTextField) {
        _changeTextField = [[UITextField alloc] init];

        _changeTextField.delegate = self;
        [_changeTextField addTarget:self action:@selector(changeTextFieldEditing:) forControlEvents:(UIControlEventTouchDown)];
        
    }
    return _changeTextField;
}
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line1;
}
- (UIView *)backView2 {
    if (!_backView2) {
        _backView2 = [[UIView alloc] init];
        _backView2.backgroundColor = [UIColor whiteColor];
    }
    return _backView2;
}

- (UILabel *)googsPrice {
    if (!_googsPrice) {
        _googsPrice = [[UILabel alloc] init];
        _googsPrice.text =@"商品价格：";
        _googsPrice.textColor = [UIColor colorWithHexString:@"#000000"];
        _googsPrice.font = [UIFont systemFontOfSize:16];
    }
    return _googsPrice;
}
- (UILabel *)googsPriceNumber {
    if (!_googsPriceNumber) {
        _googsPriceNumber = [[UILabel alloc] init];
        _googsPriceNumber.text =@"¥ 1300";
        _googsPriceNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        _googsPriceNumber.font = [UIFont systemFontOfSize:14];
    }
    return _googsPriceNumber;
}
- (UILabel *)googsOldPriceNumber {
    if (!_googsOldPriceNumber) {
        _googsOldPriceNumber = [[UILabel alloc] init];
        _googsOldPriceNumber.attributedText = [self getAttributeWithString:@"¥ 1400"];
    }
    return _googsOldPriceNumber;
}
#pragma mark
#pragma mark - Action
- (void)changeTextFieldEditing:(UITextField *)textField {
    if (_editBlock) {
        _editBlock();
    }
}
- (NSAttributedString *)getAttributeWithString:(NSString *)string {
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"],
                           NSFontAttributeName:[UIFont systemFontOfSize:14],
                           NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]
                           };
    NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:string attributes:dict];
    return attribut;
}

@end
