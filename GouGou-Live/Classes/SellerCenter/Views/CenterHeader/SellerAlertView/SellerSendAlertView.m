//
//  SellerSendAlertView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerSendAlertView.h"


@interface SellerSendAlertView ()<UITextFieldDelegate>
/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

#pragma mark - 控件
@property(nonatomic, strong) UIView *backView; /**< 背景 */

@property(nonatomic, strong) UILabel *orderCode; /**< 订单编号 */

@property(nonatomic, strong) UILabel *orderCodeNumber; /**< 编号码 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@property(nonatomic, strong) UILabel *shipStyle; /**< 运货方式 */
@property(nonatomic, strong) UILabel *shipStyleNote; /**< 空行提示 */
@property(nonatomic, strong) UIView *shipStyleBackView; /**< 运货背景 */
@property(nonatomic, strong) UITextField *shipStyleTextField; /**< 运货方式编辑 */

@property(nonatomic, strong) UILabel *shipOrder; /**< 运单编号 */
@property(nonatomic, strong) UILabel *shipOrderNote; /**< 空行提示 */
@property(nonatomic, strong) UIView *shipOrderBackView; /**< 货单背景 */

@property(nonatomic, strong) UITextField *shipOrderTextField; /**< 运单方式编辑 */

@property(nonatomic, strong) UIButton *commitBtn; /**< 提交按钮 */

@end
@implementation SellerSendAlertView


#pragma mark
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:self.backView];
        [self.backView addSubview:self.orderCode];
        [self.backView addSubview:self.orderCodeNumber];

        [self addSubview:self.line];
        [self addSubview:self.shipStyle];
        [self addSubview:self.shipStyleNote];
        [self addSubview:self.shipStyleBackView];
        [self.shipStyleBackView addSubview:self.shipStyleTextField];

        [self addSubview:self.shipOrder];
        [self addSubview:self.shipOrderNote];
        [self addSubview:self.shipOrderBackView];
        [self.shipOrderBackView addSubview:self.shipOrderTextField];
        [self addSubview:self.successNote];
        [self addSubview:self.commitBtn];
    }
    return self;
}
- (void)setOrderID:(NSString *)orderID {
    _orderID = orderID;
    self.orderCodeNumber.text = orderID;
}
// 约束
- (void)setUP {
    [self.backView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.orderCode makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.centerY);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.orderCodeNumber makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderCode.centerY);
        make.left.equalTo(self.orderCode.right);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    // 运货方式
    [self.shipStyle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.shipStyleNote makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shipStyle.centerY);
        make.left.equalTo(self.shipStyle.right).offset(10);
    }];
    [self.shipStyleBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shipStyle.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(44);
    }];
    
    [self.shipStyleTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shipStyleBackView.centerY);
        make.top.equalTo(self.shipStyleBackView.top);
        make.left.equalTo(self.shipStyleBackView.left).offset(5);
        make.right.equalTo(self.shipStyleBackView.right).offset(-5);
    }];
    
    // 运单
    [self.shipOrder makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shipStyleBackView.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.shipOrderNote makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shipOrder.centerY);
        make.left.equalTo(self.shipOrder.right).offset(10);
    }];
    [self.shipOrderBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shipOrder.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(44);
    }];
    
    [self.shipOrderTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shipOrderBackView.centerY);
        make.top.equalTo(self.shipOrderBackView.top);
        make.left.equalTo(self.shipOrderBackView.left).offset(5);
        make.right.equalTo(self.shipOrderBackView.right).offset(-5);
    }];
    [self.successNote makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shipOrderBackView.bottom).offset(5);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.commitBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(44);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
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
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
- (UILabel *)shipStyle {
    if (!_shipStyle) {
        _shipStyle = [[UILabel alloc] init];
        _shipStyle.text = @"运输方式";
        _shipStyle.textColor = [UIColor colorWithHexString:@"#000000"];
        _shipStyle.font = [UIFont systemFontOfSize:16];
    }
    return _shipStyle;
}
- (UILabel *)shipStyleNote {
    if (!_shipStyleNote) {
        _shipStyleNote = [[UILabel alloc] init];
        _shipStyleNote.text = @"运输方式不能为空";
        _shipStyleNote.hidden = YES;
        _shipStyleNote.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _shipStyleNote.font = [UIFont systemFontOfSize:14];
    }
    return _shipStyleNote;
}
- (UIView *)shipStyleBackView {
    if (!_shipStyleBackView) {
        _shipStyleBackView = [[UIView alloc] init];
        _shipStyleBackView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _shipStyleBackView.layer.cornerRadius = 5;
        _shipStyleBackView.layer.masksToBounds = YES;
    }
    return _shipStyleBackView;
}
- (UITextField *)shipStyleTextField {
    if (!_shipStyleTextField) {
        _shipStyleTextField = [[UITextField alloc] init];
        _shipStyleTextField.delegate = self;
    }
    return _shipStyleTextField;
}
- (UILabel *)shipOrder {
    if (!_shipOrder) {
        _shipOrder = [[UILabel alloc] init];
        _shipOrder.text = @"运单编号";
        _shipOrder.textColor = [UIColor colorWithHexString:@"#000000"];
        _shipOrder.font = [UIFont systemFontOfSize:16];
    }
    return _shipOrder;
}
- (UILabel *)shipOrderNote {
    if (!_shipOrderNote) {
        _shipOrderNote = [[UILabel alloc] init];
        _shipOrderNote.text = @"运单编号不能为空";
        _shipOrderNote.hidden = YES;
        _shipOrderNote.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _shipOrderNote.font = [UIFont systemFontOfSize:14];
    }
    return _shipOrderNote;
}
- (UIView *)shipOrderBackView {
    if (!_shipOrderBackView) {
        _shipOrderBackView = [[UIView alloc] init];
        _shipOrderBackView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _shipOrderBackView.layer.cornerRadius = 5;
        _shipOrderBackView.layer.masksToBounds = YES;

    }
    return _shipOrderBackView;
}
- (UITextField *)shipOrderTextField {
    if (!_shipOrderTextField) {
        _shipOrderTextField = [[UITextField alloc] init];
        _shipOrderTextField.delegate = self;
    }
    return _shipOrderTextField;
}
- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
       
        [_commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
        [_commitBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        _commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
       
        [_commitBtn addTarget:self action:@selector(clickCommitBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _commitBtn;
}
- (UILabel *)successNote {
    if (!_successNote) {
        _successNote = [[UILabel alloc] init];
        _successNote.text = @"订单已发货成功";
        _successNote.hidden = YES;
        _successNote.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _successNote.font = [UIFont systemFontOfSize:14];
    }
    return _successNote;
}
#pragma mark
#pragma mark - Action 

- (void)clickCommitBtnAction {
    
    
    if (_commitBlock) {
        
        // 提示隐藏判断
        self.shipOrderNote.hidden = self.shipOrderTextField.text.length > 0 ? YES:NO;
        self.shipStyleNote.hidden = self.shipStyleTextField.text.length > 0 ? YES:NO;
        
        if (self.shipOrderTextField.text.length != 0 && self.shipStyleTextField.text.length != 0) {
        _commitBlock(self.shipStyleTextField.text, self.shipOrderTextField.text);
        }
    }
}

#pragma mark
#pragma mark - UItextField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self dismiss];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    if (textField == self.shipStyleTextField) { // 运输方式
//        if (range.location == 0) {
//            self.shipStyleNote.hidden = NO;
//        }
//        self.shipStyleNote.hidden = YES;

        // 判断汉字
        BOOL flag = [NSString isChinese:string];
        if (flag) {
            return YES;
        }
        return NO;
    }else if (textField == self.shipOrderTextField){ // 运单
//        if (range.location == 0) {
//            self.shipOrderNote.hidden = NO;
//        }
//        self.shipOrderNote.hidden = YES;

        // 判断数字
        BOOL flag = [NSString validateNumber:string];
        if (flag) {
            return YES;
        }
        return NO;
    }
    return NO;
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
    rect = CGRectMake(0, SCREEN_HEIGHT - 285 - 280, SCREEN_WIDTH, 285);
    self.frame = rect;
    
    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss {
    //返回时调用
    [self fadeOut];
    if (_dismissBlock) {
        _dismissBlock();
    }
}
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
        [self.shipStyleTextField becomeFirstResponder];
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
