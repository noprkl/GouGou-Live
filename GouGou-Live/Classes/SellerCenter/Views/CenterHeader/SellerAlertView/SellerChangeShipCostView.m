//
//  SellerChangeShipCostView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//
#define kHeight 225

#import "SellerChangeShipCostView.h"

@interface SellerChangeShipCostView ()
<UITextFieldDelegate>
/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

#pragma mark - 控件
@property(nonatomic, strong) UIView *backView0; /**< 背景0 */
@property(nonatomic, strong) UILabel *orderCode; /**< 订单编号 */
@property(nonatomic, strong) UILabel *orderCodeNumber; /**< 编号码 */
@property(nonatomic, strong) UIView *line0; /**< 线0 */

@property(nonatomic, strong) UIView *backView1; /**< 背景1 */
@property(nonatomic, strong) UILabel *finalMoney; /**< 应付尾款 */
@property(nonatomic, strong) UILabel *finalMoneyNumber; /**< 应付尾款 */
@property(nonatomic, strong) UIView *line1; /**< 线1 */

@property(nonatomic, strong) UIView *backView2; /**< 背景 */
@property(nonatomic, strong) UILabel *changeFinalMoney; /**< 修改尾款 */
@property(nonatomic, strong) UIView *changeTextView; /**< 修改尾款文本框背景 */
@property(nonatomic, strong) UITextField *changeTextField; /**< 修改尾款文本框 */
@property(nonatomic, strong) UILabel *changedMoney; /**< 改变的钱数 */
@property(nonatomic, strong) UIView *line2; /**< 线 */

@property(nonatomic, strong) UIView *backView3; /**< 背景 */
@property(nonatomic, strong) UILabel *googsPrice; /**< 商品价格 */
@property(nonatomic, strong) UILabel *googsPriceNumber; /**< 新商品价格 */
@property(nonatomic, strong) UILabel *googsOldPriceNumber; /**< 老商品价格 */

@property(nonatomic, strong) UIButton *commitBtn; /**< 确认按钮 */

@end
@implementation SellerChangeShipCostView

#pragma mark
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:self.backView0];
        [self.backView0 addSubview:self.orderCode];
        [self.backView0 addSubview:self.orderCodeNumber];
        [self addSubview:self.line0];
        
        [self addSubview:self.backView1];
        [self.backView1 addSubview:self.finalMoney];
        [self.backView1 addSubview:self.finalMoneyNumber];
        [self addSubview:self.line1];
       
        [self addSubview:self.backView2];
        [self.backView2 addSubview:self.changeFinalMoney];
        [self.backView2 addSubview:self.changeTextView];
        [self.changeTextView addSubview:self.changeTextField];
        [self.backView2 addSubview:self.changedMoney];
        [self addSubview:self.line2];
       
        [self addSubview:self.backView3];
        [self.backView3 addSubview:self.googsPrice];
        [self.backView3 addSubview:self.googsPriceNumber];
        [self.backView3 addSubview:self.googsOldPriceNumber];
        
        [self addSubview:self.commitBtn];
    }
    return self;
}
// 约束
- (void)setUP {
    // 订单
    [self.backView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.orderCode makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView0.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.orderCodeNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderCode.centerY);
        make.left.equalTo(self.orderCode.right).offset(10);
    }];
    [self.line0 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView0.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    // 尾款
    [self.backView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line0.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.finalMoney makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView1.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.finalMoneyNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.finalMoney.centerY);
        make.left.equalTo(self.finalMoney.right).offset(10);
    }];
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView1.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    // 修改
    [self.backView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.changeFinalMoney makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.changeTextView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.centerY);
        make.left.equalTo(self.changeFinalMoney.right).offset(10);
        make.size.equalTo(CGSizeMake(124, 33));
    }];
    [self.changeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.changeTextView.centerY);
        make.left.equalTo(self.changeTextView.left).offset(9);
        make.right.equalTo(self.changeTextView.right).offset(-9);
        make.height.equalTo(33);
    }];
    
    [self.changedMoney makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView2.centerY);
        make.left.equalTo(self.changeTextField.right).offset(10);
    }];

    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView2.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    // 商品价格
    [self.backView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line2.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.googsPrice makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView3.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.googsPriceNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView3.centerY);
        make.left.equalTo(self.googsPrice.right).offset(10);
    }];
    [self.googsOldPriceNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView3.centerY);
        make.left.equalTo(self.googsPriceNumber.right).offset(10);
    }];
    
    [self.commitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView3.bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(44);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIView *)backView0 {
    if (!_backView0) {
        _backView0 = [[UIView alloc] init];
        _backView0.backgroundColor = [UIColor whiteColor];
    }
    return _backView0;
}
- (UILabel *)orderCode {
    if (!_orderCode) {
        _orderCode = [[UILabel alloc] init];
        _orderCode.text =@"订单编号：";
        _orderCode.textColor = [UIColor colorWithHexString:@"#000000"];
        _orderCode.font = [UIFont systemFontOfSize:16];
    }
    return _orderCode;
}
- (UILabel *)orderCodeNumber {
    if (!_orderCodeNumber) {
        _orderCodeNumber = [[UILabel alloc] init];
        _orderCodeNumber.text =@"386777436234";
        _orderCodeNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        _orderCodeNumber.font = [UIFont systemFontOfSize:14];
    }
    return _orderCodeNumber;
}
- (UIView *)line0 {
    if (!_line0) {
        _line0 = [[UIView alloc] init];
        _line0.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line0;
}
- (UIView *)backView1 {
    if (!_backView1) {
        _backView1 = [[UIView alloc] init];
        _backView1.backgroundColor = [UIColor whiteColor];
    }
    return _backView1;
}
- (UILabel *)finalMoney {
    if (!_finalMoney) {
        _finalMoney = [[UILabel alloc] init];
        _finalMoney.text =@"应付尾款：";
        _finalMoney.textColor = [UIColor colorWithHexString:@"#000000"];
        _finalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _finalMoney;
}
- (UILabel *)finalMoneyNumber {
    if (!_finalMoneyNumber) {
        _finalMoneyNumber = [[UILabel alloc] init];
        _finalMoneyNumber.text =@"¥ 950";
        _finalMoneyNumber.textColor = [UIColor colorWithHexString:@"#333333"];
        _finalMoneyNumber.font = [UIFont systemFontOfSize:14];
    }
    return _finalMoneyNumber;
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
- (UILabel *)changeFinalMoney {
    if (!_changeFinalMoney) {
        _changeFinalMoney = [[UILabel alloc] init];
        _changeFinalMoney.text =@"修改尾款：";
        _changeFinalMoney.textColor = [UIColor colorWithHexString:@"#000000"];
        _changeFinalMoney.font = [UIFont systemFontOfSize:16];
    }
    return _changeFinalMoney;
}
- (UIView *)changeTextView {
    if (!_changeTextView) {
        _changeTextView = [[UIView alloc] init];
        _changeTextView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
       
        _changeTextView.layer.cornerRadius = 9;
        _changeTextView.layer.masksToBounds = YES;
    }
    return _changeTextView;
}
- (UITextField *)changeTextField {
    if (!_changeTextField) {
        _changeTextField = [[UITextField alloc] init];
        _changeTextField.placeholder = @"¥ 950";
        _changeTextField.delegate = self;
        [_changeTextField addTarget:self action:@selector(changeTextFieldEditing:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _changeTextField;
}
- (UILabel *)changedMoney {
    if (!_changedMoney) {
        _changedMoney = [[UILabel alloc] init];
        _changedMoney.text = @"¥ 0";
        _changedMoney.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _changedMoney.font = [UIFont systemFontOfSize:14];
    }
    return _changedMoney;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line2;
}
- (UIView *)backView3 {
    if (!_backView3) {
        _backView3 = [[UIView alloc] init];
        _backView3.backgroundColor = [UIColor whiteColor];
    }
    return _backView3;
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
- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_commitBtn setTitle:@"确认修改" forState:(UIControlStateNormal)];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [_commitBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_commitBtn addTarget:self action:@selector(clickCommitBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _commitBtn;
}

#pragma mark
#pragma mark - Action
- (void)changeTextFieldEditing:(UITextField *)textField {
    DLog(@"%@--%ld", textField.text, textField.text.length);
    
    CGFloat newMoney;
    if ([textField.text isEqualToString:@""]) {
        newMoney = 0;
    }else if(textField.text.length != 0){
        newMoney = [textField.text floatValue];
    }
    DLog(@"%@--%ld--%f", textField.text, textField.text.length, newMoney);
    
    // 计算改变的钱数
    self.changedMoney.text = [NSString stringWithFormat:@"¥ %@", [@(950 - newMoney) stringValue]];

    
}

- (void)clickCommitBtnAction {
    
    
    if (_commitBlock) {
        
        _commitBlock(self.changeTextField.text);
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
#pragma mark - UItextField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self dismiss];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    CGFloat oldPrice = 950;
    CGFloat nowPrice = [textField.text floatValue];
    // 判断不能输入
    if (nowPrice > (oldPrice * 10) || nowPrice < (oldPrice * (-1))) {
        return NO;
    }
        
    
        return YES;
}
#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer {
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}
- (void)show {
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];
    
#pragma mark
#pragma mark - 设置当前view的frame
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - kHeight - 260, SCREEN_WIDTH, kHeight);
    self.frame = rect;
    
    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss {
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
        [self.changeTextField becomeFirstResponder];
    }];
}
- (void)fadeOut {
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
    }];
}
@end
