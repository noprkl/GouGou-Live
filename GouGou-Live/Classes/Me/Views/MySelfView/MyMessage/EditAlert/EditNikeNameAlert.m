//
//  EditNikeNameAlert.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditNikeNameAlert.h"

@interface EditNikeNameAlert ()<UITextViewDelegate>
/** 蒙版 */
@property (strong, nonatomic) UIControl *overLayer;

/** title */
@property (strong, nonatomic) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *noteLabel; /**< 提示文字 */

@property(nonatomic, strong) UITextView *editTextView; /**< 编辑处 */
/** 确认按钮 */
@property (strong, nonatomic) UIButton *sureBtn;
/** 取消按钮 */
@property (strong, nonatomic) UIButton *cancelBtn;

@property(nonatomic, strong) UILabel *placeLabel; /**< placeHolder */

@property(nonatomic, strong) UILabel *countLabel; /**< 字的个数 */


@property(nonatomic, assign) NSInteger count; /**< 字数 */

@end
@implementation EditNikeNameAlert

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.overLayer];
        [self addSubview:self.titleLabel];
        [self addSubview:self.editTextView];
        [self addSubview:self.noteLabel];
        [self addSubview:self.sureBtn];
        [self addSubview:self.cancelBtn];
    }
    return self;
}
- (void)setUP {
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(10);
    }];
    
    [self.editTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(5);
        make.top.equalTo(self.titleLabel.bottom).offset(10);
        make.right.equalTo(self.right).offset(-5);
        make.height.equalTo(44);
    }];
    
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.editTextView.left);
        make.top.equalTo(self.editTextView.bottom).offset(5);
    }];
    
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.bottom.equalTo(self.bottom);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 2, 44));
    }];
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 2, 44));
    }];

}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.placeLabel.text = placeHolder;
}
- (void)setNoteString:(NSString *)noteString {
    _noteString = noteString;
    self.noteLabel.text = noteString;
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请输入用户昵称";
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UITextView *)editTextView {
    if (!_editTextView) {
        _editTextView  = [[UITextView alloc] init];
        _editTextView.delegate = self;
        _editTextView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _editTextView.textColor = [UIColor colorWithHexString:@"#666666"];
        _editTextView.font = [UIFont systemFontOfSize:14];
        _editTextView.layer.cornerRadius = 5;
        _editTextView.layer.masksToBounds = YES;
        _editTextView.returnKeyType = UIReturnKeyDefault;
        
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = @"输入用户昵称";
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:14];
        placeLabel.frame = CGRectMake(5, 5, 200, 15);
        [_editTextView addSubview:placeLabel];
        self.placeLabel = placeLabel;
       
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.text = @"17";
        _count = 17;
        countLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        countLabel.font = [UIFont systemFontOfSize:14];
        countLabel.frame = CGRectMake(SCREEN_WIDTH - 25, 20, 20, 15);
        [_editTextView addSubview:countLabel];
        self.countLabel = countLabel;
        
        
    }
    return _editTextView;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"支持中英文、数字以及下划线";
        _noteLabel.font = [UIFont systemFontOfSize:13];
        _noteLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _noteLabel;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchDown)];
    }
    return _cancelBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#99CC33"];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        [_sureBtn addTarget:self action:@selector(clickSureBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureBtn;
}
- (void)clickSureBtnAction {
    
    if (_sureBlock) {
        _sureBlock(self.editTextView.text);
        [self dismiss];
    }
}
#pragma mark
#pragma mark - UItextview 监听
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    _count = 17 - range.length;
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (range.location < 17) {
        return YES;
    }
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        
        self.placeLabel.text = self.placeHolder;

    }else{
        self.placeLabel.text = @"";
    }
    self.countLabel.text = [@(17 - textView.text.length) stringValue];
}

#pragma mark
#pragma mark - 蒙版弹出效果
- (UIControl *)overLayer
{
    // 懒加载 蒙版
    if (!_overLayer) {
        _overLayer = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _overLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        //        [_overLayer addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _overLayer;
}

- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.overLayer];
    //载入alertView
    [keyWindow addSubview:self];

#pragma mark
#pragma mark - 设置当前view的frame
//    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat h = keyBoardFrame.size.height;
    
    CGRect rect = self.frame;
    rect = CGRectMake(0, SCREEN_HEIGHT - 165 - 258, SCREEN_WIDTH, 165);
    self.frame = rect;
   
    [self.editTextView becomeFirstResponder];

    // 约束
    [self setUP];
    
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss
{
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.overLayer.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overLayer.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.overLayer removeFromSuperview];
        [self.editTextView resignFirstResponder];

    }];
}


@end
