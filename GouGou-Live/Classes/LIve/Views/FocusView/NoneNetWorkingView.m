//
//  NoneNetWorkingView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NoneNetWorkingView.h"

@interface NoneNetWorkingView ()


@property(nonatomic, strong) UIImageView *dogImageView; /**< 狗狗图片 */

@property(nonatomic, strong) UILabel *noteLabel; /**< 提示label */

@property(nonatomic, strong) UIButton *addNetBtn; /**< 加载网络 */

@end
@implementation NoneNetWorkingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dogImageView];
        [self addSubview:self.noteLabel];
        [self addSubview:self.addNetBtn];
    }
    return self;
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[UIImageView alloc] init];
        _dogImageView.image = [UIImage imageNamed:@"矢量智能对象"];
    }
    return _dogImageView;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"现在没有网络噢，点击加载网络";
    }
    return _noteLabel;
}
- (UIButton *)addNetBtn {
    if (!_addNetBtn) {
        _addNetBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addNetBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_addNetBtn setTitle:@"加载" forState:(UIControlStateNormal)];
        _addNetBtn.titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _addNetBtn.layer.cornerRadius = 5;
        _addNetBtn.layer.masksToBounds = YES;
        [_addNetBtn addTarget:self action:@selector(clickAddNetBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _addNetBtn;
}
- (void)clickAddNetBtnAction {
    if (_addNetBlock) {
        _addNetBlock();
    }
}
@end
