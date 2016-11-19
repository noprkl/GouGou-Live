//
//  SellerGoodsBarBtnView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerGoodsBarBtnView.h"


@interface SellerGoodsBarBtnView ()

@property(nonatomic, strong) UIButton *editBtn; /**< 编辑 */

@property(nonatomic, strong) UIButton *addBtn; /**< 添加 */

@end

@implementation SellerGoodsBarBtnView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.editBtn];
        [self addSubview:self.addBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right).offset(5);
    }];
    
    [self.addBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.editBtn.left).offset(-10);
    }];
}
- (UIButton *)editBtn {
    if (!_editBtn) {
         _editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_editBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editBtn setTitle:@"完成" forState:(UIControlStateSelected)];
        [_editBtn addTarget:self action:@selector(editGoods:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _editBtn;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(clickAddBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _addBtn;
}
- (void)clickAddBtnAction {
    if (_addBlock) {
        _addBlock();
    }
}
- (void)editGoods:(UIButton *)btn {
    
    if (_editBlock) {
        btn.selected = !btn.selected;
        _editBlock(btn.selected);
        self.addBtn.hidden = btn.selected;
    }
}
@end
