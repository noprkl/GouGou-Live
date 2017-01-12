
//
//  LivingToolView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LivingToolView.h"

@interface LivingToolView ()

@property(nonatomic, strong) UIButton *backBtn; /**< 发挥按钮 */

@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播提示图 */

@property(nonatomic, strong) UIButton *watchCount; /**< 观看人数 */

@property(nonatomic, strong) UIButton *shareBtn; /**< 分享 */

@property(nonatomic, strong) UIButton *faceOrBack; /**< 翻转按钮 */

@end
@implementation LivingToolView
#pragma mark
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
        [self addSubview:self.livingImageView];
        [self addSubview:self.backBtn];
        [self addSubview:self.watchCount];
        [self addSubview:self.shareBtn];
        [self addSubview:self.faceOrBack];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(10);
        make.left.equalTo(self.left);
        make.size.equalTo(CGSizeMake(34, 34));
    }];
    
    [self.livingImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.left.equalTo(self.backBtn.right);
    }];
    
    [self.watchCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.left.equalTo(self.livingImageView.right).offset(10);
        make.width.equalTo(100);
        make.height.equalTo(self.backBtn.height);
    }];
    [self.faceOrBack makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.right.equalTo(self.right).offset(0);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [self.shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.right.equalTo(self.faceOrBack.left).offset(0);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
- (void)setWatchPeople:(NSString *)watchPeople {
    _watchPeople = watchPeople;
    [self.watchCount setTitle:watchPeople forState:(UIControlStateNormal)];
}
#pragma mark
#pragma mark - Action
- (void)clickBackBtnAction {
    if (_backBlcok) {
        _backBlcok();
    }
}
- (void)clickShareBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (_shareBlcok) {
        _shareBlcok(btn);
    }
}
- (void)clickFaceOrBackAction {
    if (_faceBlcok) {
        _faceBlcok();
    }
}

#pragma mark
#pragma mark - 懒加载
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setImage:[UIImage imageNamed:@"返回-拷贝"] forState:(UIControlStateNormal)];
        [_backBtn setContentMode:(UIViewContentModeCenter)];
        [_backBtn addTarget:self action:@selector(clickBackBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (UIImageView *)livingImageView {
    if (!_livingImageView) {
        _livingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"直播中"]];
    }
    return _livingImageView;
}
- (UIButton *)watchCount {
    if (!_watchCount) {
        _watchCount = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_watchCount setImage:[UIImage imageNamed:@"联系人"] forState:(UIControlStateNormal)];
        _watchCount.titleLabel.font = [UIFont systemFontOfSize:14];
        [_watchCount setTitle:@"0" forState:(UIControlStateNormal)];
        [_watchCount setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        _watchCount.enabled = NO;
    }
    return _watchCount;
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
        [_shareBtn setContentMode:(UIViewContentModeCenter)];

        [_shareBtn setImage:[UIImage imageNamed:@"分享-拷贝"] forState:(UIControlStateSelected)];
        [_shareBtn addTarget:self action:@selector(clickShareBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _shareBtn;
}
- (UIButton *)faceOrBack {
    if (!_faceOrBack) {
        _faceOrBack = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_faceOrBack setImage:[UIImage imageNamed:@"相机翻转"] forState:(UIControlStateNormal)];
        [_faceOrBack setContentMode:(UIViewContentModeCenter)];

        [_faceOrBack addTarget:self action:@selector(clickFaceOrBackAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _faceOrBack;
}
@end
