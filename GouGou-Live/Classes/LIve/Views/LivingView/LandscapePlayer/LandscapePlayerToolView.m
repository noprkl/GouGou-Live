//
//  LandscapePlayerToolView.m
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LandscapePlayerToolView.h"

@interface LandscapePlayerToolView ()

@end
@implementation LandscapePlayerToolView
#pragma mark
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
        [self addSubview:self.livingImageView];
        [self addSubview:self.backBtn];
        [self addSubview:self.watchCount];
        [self addSubview:self.reportBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.collectBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    [self.livingImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.left.equalTo(self.backBtn.right);
    }];
    
    [self.watchCount remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.left.equalTo(self.livingImageView.right).offset(10);
        make.width.equalTo(100);
        make.height.equalTo(self.backBtn.height);
    }];
    
    [self.collectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(10);
        make.right.equalTo(self.right);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    [self.shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(10);
        make.right.equalTo(self.collectBtn.left);
        make.size.equalTo(CGSizeMake(44, 44));

    }];
    [self.reportBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(10);
        make.right.equalTo(self.shareBtn.left).offset(-10);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

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
- (void)clickReportBtnAction:(UIButton *)btn {
    if (_reportBlcok) {
        _reportBlcok();
    }
}
- (void)clickcollectBtnAction:(UIButton *)btn {
    if (_collectBlcok) {
        _collectBlcok(btn.selected);
    }
    btn.selected = !btn.selected;
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
        [_watchCount setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        _watchCount.enabled = NO;
    }
    return _watchCount;
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
        [_shareBtn setImage:[UIImage imageNamed:@"分享-拷贝"] forState:(UIControlStateSelected)];
        [_shareBtn setContentMode:(UIViewContentModeCenter)];
        [_shareBtn addTarget:self action:@selector(clickShareBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _shareBtn;
}
- (UIButton *)reportBtn {
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_reportBtn setImage:[UIImage imageNamed:@"举报"] forState:(UIControlStateNormal)];
         [_reportBtn setImage:[UIImage imageNamed:@"举报-拷贝"] forState:(UIControlStateSelected)];
        [_reportBtn setContentMode:(UIViewContentModeCenter)];

        [_reportBtn addTarget:self action:@selector(clickReportBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _reportBtn;
}

- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_collectBtn setImage:[UIImage imageNamed:@"喜欢"] forState:(UIControlStateNormal)];
        [_collectBtn setImage:[UIImage imageNamed:@"喜欢点击"] forState:(UIControlStateSelected)];
        [_collectBtn setContentMode:(UIViewContentModeCenter)];

        [_collectBtn addTarget:self action:@selector(clickcollectBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _collectBtn;
}

@end
