//
//  SellerMessageView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerMessageView.h"
#import "StartSourceView.h"

@interface SellerMessageView ()


@property(nonatomic, strong) UIImageView *sellerIconView; /**< 主播头像 */

@property(nonatomic, strong) UILabel *sellerNameLabel; /**< 主播名字 */

@property(nonatomic, strong) UILabel *fansLabel; /**< 粉丝 */

@property(nonatomic, strong) UILabel *fansCountLabel; /**< 粉丝人数 */

@property(nonatomic, strong) UILabel *rateLabel; /**< 评价 */

@property(nonatomic, strong) UILabel *rateCountLabel; /**< 评价人数 */

@property(nonatomic, strong) UILabel *pleaseLabel; /**< 消费者满意度 */

@property(nonatomic, strong) StartSourceView *startView; /**< 星星 */

@property(nonatomic, strong) UIButton *focusBtn; /**< 关注按钮 */

@property(nonatomic, strong) UILabel *line1; /**< 线1 */

@property(nonatomic, strong) UILabel *certifLabel; /**< 实名认证 */

@property(nonatomic, strong) UILabel *certifNameLabel; /**< 实名 */

@property(nonatomic, strong) UILabel *certifStateLabel; /**< 实名认证状态 */

@property(nonatomic, strong) UILabel *sellCertifLabel; /**< 商家认证 */

@property(nonatomic, strong) UILabel *sellNameLabel; /**< 商家 */

@property(nonatomic, strong) UILabel *line2; /**< 线2 */

@property(nonatomic, strong) UILabel * briefLabel; /**< 简介 */

@property(nonatomic, strong) UILabel * briefContentLabel; /**< 简介内容 */

@property(nonatomic, assign) CGFloat viewHeight; /**< view高度 */

@end

@implementation SellerMessageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.sellerIconView];
        [self addSubview:self.sellerNameLabel];
        [self addSubview:self.fansLabel];
        [self addSubview:self.fansCountLabel];
        [self addSubview:self.rateLabel];
        [self addSubview:self.rateCountLabel];
        [self addSubview:self.pleaseLabel];
        [self addSubview:self.startView];
        [self addSubview:self.focusBtn];
        [self addSubview:self.line1];
        [self addSubview:self.certifLabel];
        [self addSubview:self.certifNameLabel];
        [self addSubview:self.certifStateLabel];
        [self addSubview:self.sellCertifLabel];
        [self addSubview:self.sellNameLabel];
        [self addSubview:self.line2];
        [self addSubview:self.briefLabel];
        [self addSubview:self.briefContentLabel];
        
    }
    return self;
}
- (void)setFansCount:(NSInteger)fansCount {
    _fansCount = fansCount;
    self.fansCountLabel.text = [@(fansCount) stringValue];
}
- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    self.rateCountLabel.text = [@(commentCount) stringValue];
}
- (void)setPleasureCount:(NSInteger)pleasureCount {
    _pleasureCount = pleasureCount;
    self.startView.startCount = pleasureCount;
}
- (void)setUserImg:(NSString *)userImg {
    _userImg = userImg;
    if (userImg.length != 0) {
        NSString *imgUrl = [IMAGE_HOST stringByAppendingString:userImg];
        [self.sellerIconView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
}
- (void)setDescCommnet:(NSString *)descCommnet {
    _descCommnet = descCommnet;
    self.briefContentLabel.text = descCommnet;
}
- (void)setUserName:(NSString *)userName {
    _userName = userName;
    self.sellerNameLabel.text = userName;
    self.certifNameLabel.text = userName;
    self.sellNameLabel.text = userName;
}
- (void)setIsFocus:(BOOL)isFocus {
    _isFocus = isFocus;
    self.focusBtn.selected = isFocus;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.sellerIconView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    [self.sellerNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    [self.fansLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sellerNameLabel.bottom).offset(10);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    [self.fansCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fansLabel.centerY);
        make.left.equalTo(self.fansLabel.right).offset(3);
    }];
    [self.rateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fansLabel.centerY);
        make.left.equalTo(self.fansCountLabel.right).offset(10);
    }];
    [self.rateCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fansLabel.centerY);
        make.left.equalTo(self.rateLabel.right).offset(3);
    }];
    [self.focusBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellerIconView.centerY);
        make.right.equalTo(self.right).offset(-10);
        make.size.equalTo(CGSizeMake(60, 30));
    }];
    [self.pleaseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fansLabel.bottom).offset(10);
        make.left.equalTo(self.sellerIconView.right).offset(10);
    }];
    [self.startView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pleaseLabel.centerY);
        make.left.equalTo(self.pleaseLabel.right).offset(10);
        make.size.equalTo(CGSizeMake(100, 15));
    }];
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pleaseLabel.bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(1);
    }];
    
    [self.certifLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.certifNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.certifLabel.centerY);
        make.left.equalTo(self.certifLabel.right);
    }];
    
    [self.certifStateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.certifLabel.centerY);
        make.left.equalTo(self.certifNameLabel.right).offset(15);
    }];
    [self.sellCertifLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.certifLabel.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);

    }];
    [self.sellNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.sellCertifLabel.centerY);
        make.left.equalTo(self.sellCertifLabel.right);
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.bottom).offset(55);
        make.left.right.equalTo(self);
        make.height.equalTo(1);
    }];
    [self.briefLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line2.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.briefContentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.briefLabel.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
}
#pragma mark
#pragma mark - Action 
- (CGFloat)getMessageHeight {
    return CGRectGetMaxY(self.briefContentLabel.frame) + 10;;
}
- (void)clickFocusBtnAction:(UIButton *)btn {
    if (_focusBlock) {
        _focusBlock(self.focusBtn);
    }

}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)sellerIconView {
    if (!_sellerIconView) {
        _sellerIconView = [[UIImageView alloc] init];
        _sellerIconView.image = [UIImage imageNamed:@"主播头像"];
        _sellerIconView.layer.cornerRadius = 15;
        _sellerIconView.layer.masksToBounds = YES;
    }
    return _sellerIconView;
    }
- (UILabel *)sellerNameLabel {
    if (!_sellerNameLabel) {
        _sellerNameLabel = [[UILabel alloc] init];
        _sellerNameLabel.text = @"陈家狗狗培育中心";
        _sellerNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _sellerNameLabel.font = [UIFont systemFontOfSize:16];

    }
    return _sellerNameLabel;
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
- (UILabel *)fansCountLabel {
    if (!_fansCountLabel) {
        _fansCountLabel = [[UILabel alloc] init];
        _fansCountLabel.text = @"1000";
        _fansCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _fansCountLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fansCountLabel;
}
- (UILabel *)rateCountLabel {
    if (!_rateCountLabel) {
        _rateCountLabel = [[UILabel alloc] init];
        _rateCountLabel.text = @"80";
        _rateCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _rateCountLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rateCountLabel;
}
- (UILabel *)rateLabel {
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.text = @"评价";
        _rateLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _rateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _rateLabel;
}
- (UILabel *)pleaseLabel {
    if (!_pleaseLabel) {
        _pleaseLabel = [[UILabel alloc] init];
        _pleaseLabel.text = @"消费者满意度";
        _pleaseLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _pleaseLabel.font = [UIFont systemFontOfSize:12];
    }
    return _pleaseLabel;
}
- (StartSourceView *)startView {
    if (!_startView) {
        _startView = [[StartSourceView alloc] init];
        _startView.backgroundColor = [UIColor whiteColor];
    }
    return _startView;
}
- (UIButton *)focusBtn {
    if (!_focusBtn) {
        _focusBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        _focusBtn.layer.cornerRadius = 5;
        _focusBtn.layer.masksToBounds = YES;
        
        [_focusBtn setTitle:@"关注" forState:(UIControlStateNormal)];
        [_focusBtn setTitle:@"已关注" forState:(UIControlStateSelected)];
        _focusBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _focusBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_focusBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        [_focusBtn addTarget:self action:@selector(clickFocusBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _focusBtn;
}
- (UILabel *)line1 {
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line1;
}
- (UILabel *)certifStateLabel {
    if (!_certifStateLabel) {
        _certifStateLabel = [[UILabel alloc] init];
        _certifStateLabel.text = @"已人工复查";
        _certifStateLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _certifStateLabel.font = [UIFont systemFontOfSize:10];
    }
    return _certifStateLabel;
}
- (UILabel *)certifNameLabel {
    if (!_certifNameLabel) {
        _certifNameLabel = [[UILabel alloc] init];
        _certifNameLabel.text = @"张**";
        _certifNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _certifNameLabel.font = [UIFont systemFontOfSize:12];
    
    }
    return _certifNameLabel;
}
- (UILabel *)certifLabel {
    if (!_certifLabel) {
        _certifLabel = [[UILabel alloc] init];
        _certifLabel.text = @"实名认证：";
        _certifLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _certifLabel.font = [UIFont systemFontOfSize:12];

    }
    return _certifLabel;
}
- (UILabel *)sellCertifLabel {
    if (!_sellCertifLabel) {
        _sellCertifLabel = [[UILabel alloc] init];
        _sellCertifLabel.text = @"厂商认证：";
        _sellCertifLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _sellCertifLabel.font = [UIFont systemFontOfSize:12];
    }
    return _sellCertifLabel;
}
- (UILabel *)sellNameLabel {
    if (!_sellNameLabel) {
        _sellNameLabel = [[UILabel alloc] init];
        _sellNameLabel.text = @"张氏家犬养殖";
        _sellNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _sellNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _sellNameLabel;
}
- (UILabel *)line2 {
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line2;
    
}
- (UILabel *)briefLabel {
    if (!_briefLabel) {
        _briefLabel = [[UILabel alloc] init];
        _briefLabel.text = @"简介";
        _briefLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _briefLabel.font = [UIFont systemFontOfSize:16];
    }
    return _briefLabel;
    
}
- (UILabel *)briefContentLabel {
    if (!_briefContentLabel) {
        _briefContentLabel = [[UILabel alloc] init];
        _briefContentLabel.text = @"常年进行犬类养殖,信誉保证";
        _briefContentLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _briefContentLabel.font = [UIFont systemFontOfSize:12];

    }
    return _briefContentLabel;
}
- (NSAttributedString *)getLabelAttributeString:(NSString *)text color:(NSString *)hexing font:(NSInteger)fontSize {
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor colorWithHexString:hexing],
                           NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                           };
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:text attributes:dict];

    return attribute;
}
@end
