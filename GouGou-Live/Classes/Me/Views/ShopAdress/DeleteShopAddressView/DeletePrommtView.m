//
//  DeletePrommtView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DeletePrommtView.h"

@interface DeletePrommtView ()

/** 蒙版 */
@property (strong,nonatomic) UIView *boomHUD;
/** 标题 */
@property (strong,nonatomic) UILabel *titlelabel;
/** 确认删除提示 */
@property (strong,nonatomic) UILabel *sureDeleteLabel;
/** 横线*/
@property (strong,nonatomic) UIView *lineView;
/** 取消按钮 */
@property (strong,nonatomic) UIButton *cancelBtn;
/** 确认按钮 */
@property (strong,nonatomic) UIButton *sureDeleteBtn;
/** 竖线 */
@property (strong,nonatomic) UIView *verticalView;

@end

@implementation DeletePrommtView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.titlelabel];
        [self addSubview:self.sureDeleteLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.sureDeleteBtn];
        [self addSubview:self.verticalView];
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.centerX);
        make.top.equalTo(weakself.top).offset(10);
    }];
    
    [_sureDeleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.centerX);
        make.top.equalTo(weakself.titlelabel.bottom).offset(5);
        make.left.right.equalTo(weakself);
        
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.sureDeleteLabel.bottom).offset(10);
        make.left.right.equalTo(weakself);
        make.height.equalTo(1);
    }];

    [_verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakself.centerX);
        make.top.equalTo(weakself.lineView.bottom);
        make.width.equalTo(1);
        make.bottom.equalTo(weakself.bottom);
        
    }];

    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.bottom.equalTo(weakself.bottom);
        make.left.equalTo(weakself.left);
        make.right.equalTo(weakself.verticalView.left);
        make.top.equalTo(weakself.lineView.bottom);
        make.height.equalTo(44);
    }];

    [_sureDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.lineView.bottom);
        make.left.equalTo(weakself.verticalView.right);
        make.right.bottom.equalTo(weakself);
        make.height.equalTo(44);
    }];
    
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.sureDeleteLabel.text = message;
}
- (UIView *)boomHUD {

    if (!_boomHUD) {
        _boomHUD = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _boomHUD.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _boomHUD;
}

- (UILabel *)titlelabel {

    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"提示";
        _titlelabel.font = [UIFont systemFontOfSize:16];
        _titlelabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _titlelabel;
}

- (UILabel *)sureDeleteLabel {

    if (!_sureDeleteLabel) {
        _sureDeleteLabel = [[UILabel alloc] init];
        _sureDeleteLabel.text = @"确认删除此商家地址吗?";
        _sureDeleteLabel.font = [UIFont systemFontOfSize:14];
        _sureDeleteLabel.numberOfLines = 0;
        _sureDeleteLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _sureDeleteLabel.textAlignment = NSTextAlignmentCenter;
        _sureDeleteLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _sureDeleteLabel;
}

- (UIView *)lineView {

    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}

- (UIButton *)cancelBtn {

    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelBtn addTarget:self action:@selector(clickCnacleButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)verticalView {

    if (!_verticalView) {
        _verticalView = [[UIView alloc] init];
        _verticalView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _verticalView;
}

- (UIButton *)sureDeleteBtn {

    if (!_sureDeleteBtn) {
        _sureDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureDeleteBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureDeleteBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        _sureDeleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sureDeleteBtn addTarget:self action:@selector(cilckSureDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureDeleteBtn;
}


// 点击确定按钮
- (void)cilckSureDeleteButton:(UIButton *)button {

    if (_sureBlock) {
        [self dismiss];
        _sureBlock(button);
    }

}
// 点击取消按钮
- (void)clickCnacleButton {
  
    [self fadeOut];
    if (_cancelBlock) {
        _cancelBlock();
    }
}
- (void)show
{
    //获取主window
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    //载入蒙版
    [keyWindow addSubview:self.boomHUD];
    //载入alertView
    [keyWindow addSubview:self];
    
    
    //根据overlayer设置alertView的中心点
    CGRect rect = self.frame;
    CGFloat W = SCREEN_WIDTH - 120;
    CGFloat H = 150;
    rect = CGRectMake((SCREEN_WIDTH - W) / 2, (SCREEN_HEIGHT - H) / 2, W, H);
    self.frame = rect;
    //渐入动画
    [self fadeIn];
    
}
- (void)dismiss
{
    //返回时调用
    [self fadeOut];
}
- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(0.3, 0.3);
    
    self.boomHUD.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.boomHUD.alpha = 1;
        self.transform = CGAffineTransformIdentity;
    }];
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.boomHUD.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.3, 0.3);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.boomHUD removeFromSuperview];
    }];
}



@end
