//
//  SellerGoodsBottomView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerGoodsBottomView.h"

@interface SellerGoodsBottomView ()

@property(nonatomic, strong) UIButton *allSelectBtn; /**< 编辑 */

@property(nonatomic, strong) UIButton *deleteBtn; /**< 添加 */

@end

@implementation SellerGoodsBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.allSelectBtn];
        [self addSubview:self.deleteBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
   
    [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.right);
        make.size.equalTo(CGSizeMake(100, self.frame.size.height));
    }];
    
    [self.allSelectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
//        make.width.equalTo(80);
    }];
    

}
- (UIButton *)allSelectBtn {
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_allSelectBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
        _allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_allSelectBtn setTitle:@"全选" forState:(UIControlStateNormal)];
       
        [_allSelectBtn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
        [_allSelectBtn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];

        // 偏移量
        [_allSelectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        
        [_allSelectBtn addTarget:self action:@selector(clickAllSelectBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _allSelectBtn;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        _deleteBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _deleteBtn;
}
- (void)clickDeleteBtnAction {
    if (_deleteBlock) {
        _deleteBlock();
    }
}
- (void)clickAllSelectBtnAction:(UIButton *)btn {
    
    if (_allSelectBlock) {
        _allSelectBlock(btn);
    }
}

@end
