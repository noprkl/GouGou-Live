//
//  SellerNoneDogTypeView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerNoneDogTypeView.h"

@interface SellerNoneDogTypeView ()<UITextFieldDelegate>

@property(nonatomic, strong) UIView *emptyView; /**< 空白view */

@property(nonatomic, strong) UILabel *explineLabel; /**< 提示说明 */

@property(nonatomic, strong) UILabel *addTypeLabel; /**< 添加自定义品种  */

@property(nonatomic, strong) UITextField *searchTextfiled; /**< 搜索自定义品种 */

@property(nonatomic, strong) UILabel *countLabel; /**< 字数 */

@property(nonatomic, strong) UIButton *sureAddButton; /**< 确认添加 */

@property(nonatomic, strong) UIView *lineView; /**< 横线 */

@end

@implementation SellerNoneDogTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        [self addSubview:self.emptyView];
        [self.emptyView addSubview:self.addTypeLabel];
        [self.emptyView addSubview:self.sureAddButton];
        [self.emptyView addSubview:self.countLabel];
        [self.emptyView addSubview:self.lineView];
        [self.emptyView addSubview:self.searchTextfiled];
        [self addSubview:self.explineLabel];
        
    }
    return self;
}
- (void)setDogType:(NSString *)dogType {
    _dogType = dogType;
    self.searchTextfiled.text = dogType;
}
#pragma mark
#pragma mark - 约束

- (void)layoutSubviews {

    [super layoutSubviews];
    
    [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.right.equalTo(self.right).offset(-10);
        make.height.equalTo(90);
    }];
    
    [_addTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyView.top).offset(10);
        make.centerX.equalTo(self.emptyView.centerX);
    }];
    
    [_sureAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.emptyView.right).offset(-10);
        make.bottom.equalTo(self.emptyView.bottom).offset(-10);
        make.width.equalTo(72);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emptyView.left).offset(10);
        make.right.equalTo(self.sureAddButton.left).offset(-10);
        make.bottom.equalTo(self.emptyView.bottom).offset(-10);
        make.height.equalTo(1);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lineView.right);
        make.bottom.equalTo(self.lineView.bottom);
    }];
    
    [_searchTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.lineView.left);
        make.right.equalTo(self.countLabel.left);
        make.bottom.equalTo(self.lineView.top);
        make.height.equalTo(25);
    }];

    [_explineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.emptyView.bottom).offset(20);
        
    }];
    
    
}

#pragma mark
#pragma mark - 懒加载

- (UIView *)emptyView {

    if (!_emptyView) {
        _emptyView = [[UIView alloc] init];
        _emptyView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _emptyView.layer.cornerRadius = 5;
        _emptyView.layer.masksToBounds = YES;
    }
    return _emptyView;
}

- (UILabel *)addTypeLabel {

    if (!_addTypeLabel) {
        _addTypeLabel = [[UILabel alloc] init];
        _addTypeLabel.text = @"添加自定义品种";
        _addTypeLabel.font = [UIFont systemFontOfSize:14];
        _addTypeLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _addTypeLabel;
}

- (UITextField *)searchTextfiled {

    if (!_searchTextfiled) {
        _searchTextfiled = [[UITextField alloc]init];
        _searchTextfiled.font = [UIFont systemFontOfSize:14];
        _searchTextfiled.text = @"金毛狮王";
        _searchTextfiled.delegate = self;
        _searchTextfiled.textColor = [UIColor colorWithHexString:@"#333333"];
        [_searchTextfiled addTarget:self action:@selector(textEditAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _searchTextfiled;
}

- (UILabel *)countLabel {

    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textColor = [UIColor colorWithHexString:@"999999"];
        _countLabel.text = [NSString stringWithFormat:@"%ld/10",self.searchTextfiled.text.length];
    }
    return _countLabel;
}

- (UIButton *)sureAddButton {

    if (!_sureAddButton) {
        _sureAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureAddButton setTitle:@"确认添加" forState:UIControlStateNormal];
        [_sureAddButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        [_sureAddButton setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        _sureAddButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureAddButton.layer.cornerRadius = 5;
        _sureAddButton.layer.masksToBounds = YES;
        
        [_sureAddButton addTarget:self action:@selector(cilckSureAddBtn:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureAddButton;
}

- (UIView *)lineView {

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}

- (UILabel *)explineLabel {
    
    if (!_explineLabel) {
        _explineLabel = [[UILabel alloc] init];
        _explineLabel.text = @"暂未录入您查找的品种";
        _explineLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _explineLabel.font = [UIFont systemFontOfSize:16];
    }
    return _explineLabel;
}

- (void)cilckSureAddBtn:(UIButton *)button {
   
    if (_addBlock) {
        _addBlock(self.searchTextfiled.text);
    }

}
- (void)textEditAction:(UITextField *)textField {
    self.countLabel.text = [NSString stringWithFormat:@"%ld/10", textField.text.length];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([NSString isChinese:string] && range.location < 10) {
        return YES;
    }
    
    return NO;
}

@end
