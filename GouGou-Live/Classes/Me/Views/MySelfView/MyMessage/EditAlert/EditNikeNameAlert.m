//
//  EditNikeNameAlert.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditNikeNameAlert.h"


@interface EditNikeNameAlert ()<UITextViewDelegate,UITextFieldDelegate>
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
        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewtextDidEndEditing:) name:@"UITextFieldTextDidChangeNotification" object:_editTextView];
    }
    return self;
}

- (void)textViewtextDidEndEditing:(NSNotification *)obj {
    
    UITextView *textView = (UITextView *)obj.object;
    
    NSString *toBeString = textView.text;
    NSString *lang = [[UITextInputMode activeInputModes] accessibilityLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _countText) {
                textView.text = [toBeString substringToIndex:_countText];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > _countText) {
            textView.text = [toBeString substringToIndex:_countText];
        }  
    }
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
#pragma mark - setter
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
- (void)setEasyMessage:(NSString *)easyMessage {

    _easyMessage = easyMessage;
    self.editTextView.text = easyMessage;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", self.countText - easyMessage.length];
}

- (void)setCountText:(NSInteger)countText {
    _countText = countText;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", countText - _easyMessage.length];
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
        countLabel.text = [NSString stringWithFormat:@"%ld", _countText];
        countLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        countLabel.font = [UIFont systemFontOfSize:14];
        countLabel.frame = CGRectMake(SCREEN_WIDTH - 70, 20, 60, 10);
        countLabel.textAlignment = NSTextAlignmentRight;
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
    if (self.editTextView.text.length > _countText) {
        self.editTextView.text = [self.editTextView.text substringWithRange:NSMakeRange(0, _countText - 1)];
    }

    if (_sureBlock) {
        _sureBlock(self.editTextView.text);
        [self dismiss];
    }
}
#pragma mark
#pragma mark - UItextview 监听

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    //不支持系统表情的输入
    if ([[textView textInputMode] primaryLanguage]==nil||[[[textView textInputMode] primaryLanguage]isEqualToString:@"emoji"]) {
        return NO;
    }
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange =NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location > _countText) {
            return NO;
        }else{
            return YES;
        }
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = _countText - comcatstr.length;
    if (caninputlen >= 0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length >0){
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }else{
                __block NSInteger idx =0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
                                          if (idx >= rg.length) {
                                              *stop =YES;//取出所需要就break，提高效率
                                              return ;
                                          }
                                          trimString = [trimString stringByAppendingString:substring];
                                          idx++;
                                      }];
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
            self.countLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)_countText];
        }
        return NO;
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum >_countText){
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:_countText];
        [textView setText:s];
    }
    //不让显示负数
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",MAX(0,_countText - existTextNum),_countText];
    if (textView.text.length == 0) {
        
        self.placeLabel.text = self.placeHolder;
    }else{
        self.placeLabel.text = @"";
    }
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
    rect = CGRectMake(0, SCREEN_HEIGHT - 165 - 280, SCREEN_WIDTH, 165);
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
