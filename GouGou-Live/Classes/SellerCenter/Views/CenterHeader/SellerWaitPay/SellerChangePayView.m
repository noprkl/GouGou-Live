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

@property(nonatomic, assign) BOOL isHaveDian; /**< 小数点 */

@property(nonatomic, assign) BOOL isFirstZero; /**< 首位为0 */

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
        make.left.equalTo(self.editBackView.left).offset(0);
        make.right.equalTo(self.editBackView.right).offset(0);
        make.height.equalTo(25);
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
- (void)setRealMoney:(NSString *)realMoney {
    _realMoney = realMoney;
    self.realPayNumber.text = realMoney;
}
- (void)setRealMoneyNote:(NSString *)realMoneyNote {
    _realMoneyNote = realMoneyNote;
    self.realPay.text = [NSString stringWithFormat:@"%@:", realMoneyNote];
}
- (void)setChangeStyle:(NSString *)changeStyle {
    _changeStyle = changeStyle;
    self.changeMoney.text = [NSString stringWithFormat:@"%@:", changeStyle];;
}
- (void)setPrice:(NSString *)price {
    _price = price;
    self.googsPriceNumber.text = [NSString stringWithFormat:@"%@", price];
}
- (void)setOldPrice:(NSString *)oldPrice {
    _oldPrice = oldPrice;
    self.googsOldPriceNumber.attributedText = [NSAttributedString getCenterLineWithString:oldPrice];
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.changeTextField.placeholder = [NSString stringWithFormat:@"￥%@", placeHolder];
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
        _changeTextField.font = [UIFont systemFontOfSize:14];
        _changeTextField.delegate = self;
        [_changeTextField addTarget:self action:@selector(changeTextFieldEditing:) forControlEvents:(UIControlEventEditingChanged)];
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
        _editBlock(textField.text);
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
#pragma mark
#pragma mark - 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.changeTextField) {
        
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian = NO;
        }
        if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
            _isFirstZero = NO;
        }
        
        if ([string length]>0)
            {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
                {
                
                if([textField.text length]==0){
                    if(single == '.'){
                        //首字母不能为小数点
                        return NO;
                    }
                    if (single == '0') {
                        _isFirstZero = YES;
                        return YES;
                    }
                }
                
                if (single=='.'){
                    if(!_isHaveDian)//text中还没有小数点
                        {
                        _isHaveDian=YES;
                        return YES;
                        }else{
                            return NO;
                        }
                }else if(single=='0'){
                    if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if([textField.text isEqualToString:@"0.0"]){
                            return NO;
                        }
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if (_isFirstZero&&!_isHaveDian){
                        //首位有0没.不能再输入0
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if (_isHaveDian){
                        //存在小数点，保留两位小数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt= (int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){
                        //首位有0没点
                        return NO;
                    }else{
                        return YES;
                    }
                }
                }else{
                    //输入的数据格式不正确
                    return NO;
                }
            }else{
                return YES;
            }
    }
    return YES;
}
@end
