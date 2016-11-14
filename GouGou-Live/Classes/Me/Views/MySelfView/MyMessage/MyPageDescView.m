//
//  MyPageDescView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyPageDescView.h"

@interface MyPageDescView ()

@property(nonatomic, strong) UILabel *descLabel; /**< 简介 */

@property(nonatomic, strong) UILabel *contentLabel; /**< 简介内容 */

@property(nonatomic, strong) UIButton *editBtn; /**< 编辑按钮 */

@end
@implementation MyPageDescView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.descLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.editBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(15);
        make.top.equalTo(self.top).offset(15);
    }];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(15);
        make.bottom.equalTo(self.bottom).offset(-15);
    }];
    [self.editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-15);
        make.right.equalTo(self.right).offset(-10);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"简介";
        _descLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _descLabel.font = [UIFont systemFontOfSize:16];
    }
    return _descLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"暂无简介";
        _contentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}
- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
       
        [_editBtn setTintColor:[UIColor colorWithHexString:@"#333333"]];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:(UIControlStateNormal)];
        [_editBtn setImageEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, -5))];
        
        [_editBtn addTarget:self action:@selector(editDescBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _editBtn;
}
- (void)editDescBtnAction {
    if (_editBlock) {
        _editBlock();
    }
}
@end
