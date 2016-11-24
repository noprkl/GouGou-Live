//
//  MyMessageView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyMessageView.h"



@interface MyMessageView ()


@property(nonatomic, strong) UIControl *backControl; /**< 背景点击 */

@property(nonatomic, strong) UIImageView *iconView; /**< 用户头像 */

@property(nonatomic, strong) UILabel *userNameLabel; /**< 用户名 */

@property(nonatomic, strong) UILabel *userNameAuthen; /**< 实名认证 */

@property(nonatomic, strong) UILabel *sellerAuthen; /**< 商家认证 */

@property(nonatomic, strong) UILabel *userSign; /**< 用户签名 */

@property(nonatomic, strong) UIControl *foucusBtn; /**< 关注按钮 */
@property(nonatomic, strong) UILabel *focus; /**< 关注 */
@property(nonatomic, strong) UILabel *focusCount; /**< 关注人数 */


@property(nonatomic, strong) UIControl *fansBtn; /**< 粉丝按钮 */
@property(nonatomic, strong) UILabel *fansLabel; /**< 粉丝 */
@property(nonatomic, strong) UILabel *fansCountLabel; /**< 粉丝人数 */

@property(nonatomic, strong) UIControl *myPageBtn; /**< 我的主页按钮 */
@property(nonatomic, strong) UIImageView *myPageImage; /**< 我的主页图片 */
@property(nonatomic, strong) UILabel *myPageLabel; /**< 我的主页 */

@property(nonatomic, strong) UIView *line1; /**< 线1 */

@property(nonatomic, strong) UIButton *liveBtn; /**< 直播按钮 */

@property(nonatomic, strong) UIView *line2; /**< 线2 */

@end

@implementation MyMessageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backControl];
        [self.backControl addSubview:self.iconView];
        [self.backControl addSubview:self.userNameLabel];
        [self.backControl addSubview:self.userNameAuthen];
        [self.backControl addSubview:self.sellerAuthen];
        [self.backControl addSubview:self.userSign];
        
        [self addSubview:self.foucusBtn];
        [self.foucusBtn addSubview:self.focusCount];
        [self.foucusBtn addSubview:self.focus];
        
        [self addSubview:self.fansBtn];
        [self.fansBtn addSubview:self.fansLabel];
        [self.fansBtn addSubview:self.fansCountLabel];
        
        [self addSubview:self.myPageBtn];
        [self.myPageBtn addSubview:self.myPageImage];
        [self.myPageBtn addSubview:self.myPageLabel];
        
        [self addSubview:self.line1];
        [self addSubview:self.liveBtn];
        [self addSubview:self.line2];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backControl makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.equalTo(140);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(10);
        make.size.equalTo(CGSizeMake(60, 60));

    }];
    [self.userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.bottom).offset(10);
        make.centerX.equalTo(self.centerX).offset(0);
        
    }];
    [self.userNameAuthen makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameLabel.centerY);
        make.left.equalTo(self.userNameLabel.right).offset(10);
        make.size.equalTo(CGSizeMake(50, 15));
    }];
    [self.sellerAuthen makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameLabel.centerY);
        make.left.equalTo(self.userNameAuthen.right).offset(10);
        make.size.equalTo(CGSizeMake(50, 15));
    }];
    [self.userSign makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.userNameAuthen.bottom).offset(10);
    }];
    
    //
    [self.foucusBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userSign.bottom).offset(10);
        make.left.equalTo(self.left);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 55));
    }];
    [self.focusCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.foucusBtn.centerX);
        make.top.equalTo(self.foucusBtn.top).offset(10);
    }];
    [self.focus makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.foucusBtn.centerX);
        make.top.equalTo(self.focusCount.bottom).offset(10);
    }];
    
    //
    [self.fansBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.foucusBtn.centerY);
        make.left.equalTo(self.foucusBtn.right);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 55));
    }];
    [self.fansCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fansBtn.centerX);
        make.top.equalTo(self.fansBtn.top).offset(10);
    }];
    
    [self.fansLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fansBtn.centerX);
        make.top.equalTo(self.fansCountLabel.bottom).offset(10);
    }];
    
    //
    [self.myPageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.foucusBtn.centerY);
        make.left.equalTo(self.fansBtn.right);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 55));
    }];
    [self.myPageImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.myPageBtn.centerX);
        make.top.equalTo(self.myPageBtn.top).offset(10);
    }];
    [self.myPageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.myPageBtn.centerX);
        make.top.equalTo(self.myPageImage.bottom).offset(10);
    }];
    
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foucusBtn.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(1);
    }];
    [self.liveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(44);
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.liveBtn.bottom);
        make.left.width.equalTo(self);
        make.height.equalTo(10);
    }];
    
    if ([UserInfos sharedUser].userimgurl.length > 0) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:[UserInfos sharedUser].userimgurl];

        [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
    if ([UserInfos sharedUser].usernickname.length > 0) {
        self.userNameLabel.text = [UserInfos sharedUser].usernickname;
    }
    if ([UserInfos sharedUser].isreal) {
        self.userNameAuthen.hidden = NO;
        if ([UserInfos sharedUser].ismerchant) {
            self.sellerAuthen.hidden = NO;
        }else{
            self.sellerAuthen.hidden = YES;
        }
    }else{
        self.userNameAuthen.hidden = YES;
    }
    if ([UserInfos sharedUser].usermotto.length > 0) {
        self.userSign.text = [UserInfos sharedUser].usermotto;
    }else{
        self.userSign.text = @"什么也没有，快去设置个性签名吧！";
    }
}
#pragma mark
#pragma mark - 懒加载
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc] init];
        _backControl.backgroundColor = [UIColor whiteColor];
        [_backControl addTarget:self action:@selector(clickEditingMyMessageAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backControl;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        
        _iconView.image = [UIImage imageNamed:@"头像"];
    }
    return _iconView;
}
- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.text = @"用户名";
        _userNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _userNameLabel;
}
- (UILabel *)userNameAuthen {
    if (!_userNameAuthen) {
        _userNameAuthen = [[UILabel alloc] init];
        _userNameAuthen.text = @"实名认证";
        _userNameAuthen.hidden = YES;
        _userNameAuthen.font = [UIFont systemFontOfSize:10];
        _userNameAuthen.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _userNameAuthen.backgroundColor = [UIColor colorWithHexString:@"#ffa11a"];
        _userNameAuthen.textAlignment = NSTextAlignmentCenter;
        
        _userNameAuthen.layer.cornerRadius = 7.5;
        _userNameAuthen.layer.masksToBounds = YES;
    }
    return _userNameAuthen;
}
- (UILabel *)sellerAuthen {
    if (!_sellerAuthen) {
        _sellerAuthen = [[UILabel alloc] init];
        _sellerAuthen.text = @"商家认证";
        _sellerAuthen.hidden = YES;
        _sellerAuthen.font = [UIFont systemFontOfSize:10];
        _sellerAuthen.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _sellerAuthen.backgroundColor = [UIColor colorWithHexString:@"#ffa11a"];
        _sellerAuthen.textAlignment = NSTextAlignmentCenter;
        
        _sellerAuthen.layer.cornerRadius = 7.5;
        _sellerAuthen.layer.masksToBounds = YES;
    }
    return _sellerAuthen;
}
- (UILabel *)userSign {
    if (!_userSign) {
        _userSign = [[UILabel alloc] init];
        _userSign.text = @"个性签名";
        _userSign.font = [UIFont systemFontOfSize:12];
        _userSign.textColor = [UIColor colorWithHexString:@"#333333"];

    }
    return _userSign;
}
- (UIControl *)foucusBtn {
    if (!_foucusBtn) {
        _foucusBtn = [[UIControl alloc] init];
        [_foucusBtn addTarget:self action:@selector(ClickFocusBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _foucusBtn;
}
- (UILabel *)focusCount {
    if (!_focusCount) {
        _focusCount = [[UILabel alloc] init];
        _focusCount.text = @"111";
        _focusCount.font = [UIFont systemFontOfSize:14];
        _focusCount.textColor = [UIColor colorWithHexString:@"#333333"];

    }
    return _focusCount;
}
- (UILabel *)focus {
    if (!_focus) {
        _focus = [[UILabel alloc] init];
        _focus.text = @"关注";
        _focus.font = [UIFont systemFontOfSize:14];
        _focus.textColor = [UIColor colorWithHexString:@"#333333"];

    }
    return _focus;
}
- (UIControl *)fansBtn {
    if (!_fansBtn) {
        _fansBtn = [[UIControl alloc] init];
        [_fansBtn addTarget:self action:@selector(ClickFansBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _fansBtn;
}
- (UILabel *)fansCountLabel {
    if (!_fansCountLabel) {
        _fansCountLabel = [[UILabel alloc] init];
        _fansCountLabel.text = @"111";
        _fansCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fansCountLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fansCountLabel;
}
- (UILabel *)fansLabel {
    if (!_fansLabel) {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.text = @"粉丝";
        _fansLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fansLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fansLabel;
}
- (UIControl *)myPageBtn {
    if (!_myPageBtn) {
        _myPageBtn = [[UIControl alloc] init];
        [_myPageBtn addTarget:self action:@selector(ClickMyPageBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _myPageBtn;
}
- (UIImageView *)myPageImage {
    if (!_myPageImage) {
        _myPageImage = [[UIImageView alloc] init];
        _myPageImage.image = [UIImage imageNamed:@"房子"];
    }
    return _myPageImage;
}
- (UILabel *)myPageLabel {
    if (!_myPageLabel) {
        _myPageLabel = [[UILabel alloc] init];
        _myPageLabel.text = @"我的主页";
        _myPageLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _myPageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _myPageLabel;
}
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line1;
}
- (UIButton *)liveBtn {
    if (!_liveBtn) {
        _liveBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_liveBtn setTintColor:[UIColor colorWithHexString:@"#333333"]];
        _liveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        NSString *btnTitle = @"商家认证后才能直播";
        if ([UserInfos sharedUser].ismerchant) {
            btnTitle = @"我要直播";
        }
        [_liveBtn setTitle:btnTitle forState:(UIControlStateNormal)];
        [_liveBtn addTarget:self action:@selector(ClickLiveBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _liveBtn;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line2;
}
#pragma mark
#pragma mark - Action
- (void)clickEditingMyMessageAction {
    if (_editBlock) {
        _editBlock();
    }
}
- (void)ClickLiveBtnAction:(UIButton *)btn {

    if (_liveBlcok) {
        _liveBlcok(btn);
    }
}
- (void)ClickFocusBtnAction {
    if (_focusBlcok) {
        _focusBlcok();
    }
}
- (void)ClickMyPageBtnAction {
    if (_myPageBlcok) {
        _myPageBlcok();
    }
}
- (void)ClickFansBtnAction {
    if (_fansBlcok) {
        _fansBlcok();
    }
}
@end
