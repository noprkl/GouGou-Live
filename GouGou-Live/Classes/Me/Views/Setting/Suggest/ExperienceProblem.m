//
//  ExperienceProblem.m
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ExperienceProblem.h"
#import "AddUpdataImagesView.h"
static NSString * identifer = @"collectionCell";
#define ImgCount 3

@interface ExperienceProblem ()<UITextViewDelegate>
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;
/** textView */
@property (strong,nonatomic) UITextView *textView;
/** whilteView */
@property (strong,nonatomic) UIView *whilteView;
/** explainLabel */
@property (strong,nonatomic) UILabel *explainLabel;
/** 计数label */
@property (strong,nonatomic) UILabel *countLabel;
/** 最后选中按钮 */
@property (strong,nonatomic) UIButton *lastButton;
/** 提交 */
@property (strong,nonatomic) UIButton *handinBtn;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ExperienceProblem
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"功能问题",@"购买遇到问题",@"性能问题",@"其他"];
    }
    return _dataArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self problemButton];
        [self addSubview:self.whilteView];
        [self.whilteView addSubview:self.explainLabel];
        [self.whilteView addSubview:self.textView];
        [self.whilteView addSubview:self.countLabel];
        [self addSubview:self.handinBtn];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextChange:) name:UITextViewTextDidChangeNotification object:self.textView];
    }
    return self;
}
- (void)problemButton {
    //  总列数
    int totalColumns = 2;
    //  button间距
    CGFloat space = 20;
    //  边间距
    CGFloat margin = 10;
    CGFloat cellW = (SCREEN_WIDTH - space - totalColumns * margin) / totalColumns;
    CGFloat cellH = 35;
    // 根据格子个数创建对应的框框
    for(int index = 0; index< self.dataArray.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonsArray addObject:button];
        button.backgroundColor = [UIColor whiteColor];
        // 计算行号  和   列号
        int row = index / totalColumns;
        int col = index % totalColumns;
        //根据行号和列号来确定 子控件的坐标
        CGFloat btnX = margin + col * (cellW + space);
        CGFloat btnY = row * (cellH + margin) + margin;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button setTitle:self.dataArray[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
//        if (index == 0) {
//            button.selected = YES;
//            self.lastButton = button;
//            [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
//            [button setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
//        }
        button.frame = CGRectMake(btnX, btnY, cellW, cellH);
        
        [button addTarget:self action:@selector(chooseProblemBtn:) forControlEvents:UIControlEventTouchUpInside];
        // 添加到view 中
        [self addSubview:button];
    }
}
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    [_whilteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.top).offset(100);
        make.left.equalTo(weakself.left).offset(10);
        make.centerX.equalTo(weakself.centerX);
        make.height.equalTo(130);
    }];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.whilteView.top).offset(10);
        make.left.equalTo(weakself.whilteView.left).offset(10);
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.explainLabel.bottom);
        make.left.equalTo(weakself.whilteView.left).offset(10);
        make.centerX.equalTo(weakself.centerX);
        make.height.equalTo(100);
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.whilteView.right).offset(-10);
        make.bottom.equalTo(weakself.whilteView.bottom).offset(-10);
    }];
    [_handinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weakself);
        make.height.equalTo(44);
    }];
}
- (UIView *)whilteView {
    if (!_whilteView) {
        _whilteView = [[UIView alloc] init];
        _whilteView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _whilteView.layer.cornerRadius = 5;
        _whilteView.layer.masksToBounds = YES;
    }
    return _whilteView;
}
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _textView.delegate = self;
    }
    return _textView;
}
- (UILabel *)explainLabel {
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc]init];
        _explainLabel.text = @"请描述您的问题";
        _explainLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _explainLabel.font = [UIFont systemFontOfSize:12];
    }
    return _explainLabel;
}
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _countLabel.text = @"140";
        _countLabel.font = [UIFont systemFontOfSize:12];
    }
    return _countLabel;
}
- (UIButton *)handinBtn {
    if (!_handinBtn) {
        _handinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_handinBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_handinBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_handinBtn setTitle:@"提交" forState:UIControlStateNormal];
        _handinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _handinBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_handinBtn addTarget:self action:@selector(clickHandinBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handinBtn;
}
#pragma mark - 按钮选中
// 提交按钮
- (void)clickHandinBtn:(UIButton *)button {
    if (_handinBlock) {
        _handinBlock(button);
    }
}
// 问题种类按钮
- (void)chooseProblemBtn:(UIButton *)btn {
    
    btn.selected = YES;
    self.lastButton.selected = NO;
    self.lastButton.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.lastButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    btn.selected = YES;
    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    self.lastButton = btn;
    
    if (_problemBlock) {
        _problemBlock([btn currentTitle]);
    }
    
}
// 通知监听textView内容
- (void)textViewTextChange:(NSNotification *)notification {
    self.textViewText = self.textView.text;
}
#pragma mark - textView代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    
    if (textView == self.textView) {
        if (range.location < 140) {
            return YES;
        }
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    
    self.countLabel.text = [@(140 - textView.text.length) stringValue];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    return YES;
}

@end
