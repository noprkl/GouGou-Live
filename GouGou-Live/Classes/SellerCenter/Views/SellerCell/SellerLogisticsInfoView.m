//
//  SellerLogisticsInfoView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerLogisticsInfoView.h"

@interface SellerLogisticsInfoView ()
/** 物流信息 */
@property (strong,nonatomic) UILabel *logisticInfoLabel;
/** 快递名 */
@property (strong,nonatomic) UILabel *expressNameLabe;
/** 快递编号 */
@property (strong,nonatomic) UILabel *numLabel;

@property(nonatomic, strong) UIButton *editBtn; /**< 编辑按钮 */

@property(nonatomic, strong) UIView *line; /**< 线 */

@end

@implementation SellerLogisticsInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.logisticInfoLabel];
        [self addSubview:self.expressNameLabe];
        [self addSubview:self.numLabel];
        [self addSubview:self.editBtn];
        [self addSubview:self.line];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakself = self;
    
    [_logisticInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        
    }];
    
    [_expressNameLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.logisticInfoLabel.bottom).offset(30);
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.expressNameLabe.right).offset(10);
        make.centerY.equalTo(weakself.expressNameLabe.centerY);
        
    }];
    [_editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.right).offset(-10);
        make.bottom.equalTo(weakself.bottom).offset(-10);
    }];
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself);
        make.bottom.equalTo(weakself.bottom);
        make.height.equalTo(1);
    }];
}
- (void)setTransformNumber:(NSString *)transformNumber {
    _transformNumber = transformNumber;
    self.numLabel.text = transformNumber;
}
- (void)setTransformStyle:(NSString *)transformStyle {
    _transformStyle = transformStyle;
    self.expressNameLabe.text = transformStyle;
}
#pragma markc
#pragma mark - 懒加载
- (UILabel *)logisticInfoLabel {
    
    if (!_logisticInfoLabel) {
        _logisticInfoLabel = [[UILabel alloc] init];
        _logisticInfoLabel.text = @"物流信息";
        _logisticInfoLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _logisticInfoLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _logisticInfoLabel;
}

- (UILabel *)expressNameLabe {
    
    if (!_expressNameLabe) {
        _expressNameLabe = [[UILabel alloc] init];
        _expressNameLabe.text = @"狗狗快递";
        _expressNameLabe.textColor = [UIColor colorWithHexString:@"#000000"];
        _expressNameLabe.font = [UIFont systemFontOfSize:14];
        
    }
    return _expressNameLabe;
}
- (UILabel *)numLabel {
    
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.text = @"7281737272627";
        _numLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _numLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _numLabel;
}
- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:(UIControlStateNormal)];
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_editBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
        _editBtn.hidden = YES;
        [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        
        [_editBtn addTarget:self action:@selector(clickEditBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _editBtn;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}


#pragma mark - Action 
- (void)clickEditBtnAction {
    if (_editBlock) {
        _editBlock();
    }
}
- (void)setHidEdit:(BOOL)hidEdit {
    _hidEdit = hidEdit;
    self.editBtn.hidden = hidEdit;
}
@end
