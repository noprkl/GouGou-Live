//
//  MyPageHeaderView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyPageHeaderView.h"
#import "StartSourceView.h"


@interface MyPageHeaderView ()

@property(nonatomic, strong) UIImageView *iconView; /**< 用户头像 */

@property(nonatomic, strong) UILabel *userNameLabel; /**< 用户名 */

@property(nonatomic, strong) UILabel *userNameAuthen; /**< 实名认证 */

@property(nonatomic, strong) UILabel *sellerAuthen; /**< 商家认证 */

@property(nonatomic, strong) UILabel *fansLabel; /**< 粉丝 */
@property(nonatomic, strong) UILabel *fansCountLabel; /**< 粉丝人数 */

@property(nonatomic, strong) UIView *line1; /**< 线 */

@property(nonatomic, strong) UILabel *comment; /**< 评论 */
@property(nonatomic, strong) UILabel *commentCountLabel; /**< 评论 */

@property(nonatomic, strong) UILabel *pleasure; /**< 消费者满意度 */

@property(nonatomic, strong) StartSourceView *startSource; /**< 星星个数 */

@end
@implementation MyPageHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.iconView];
        [self addSubview:self.userNameAuthen];
        [self addSubview:self.sellerAuthen];
        [self addSubview:self.fansLabel];
        [self addSubview:self.fansCountLabel];
        [self addSubview:self.line1];
        [self addSubview:self.comment];
        [self addSubview:self.commentCountLabel];
        [self addSubview:self.pleasure];
        [self addSubview:self.startSource];
        
    }
    return self;
}
- (void)setFansCount:(NSInteger)fansCount {
    _fansCount = fansCount;
    self.fansCountLabel.text = [@(fansCount) stringValue];
}
- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    self.commentCountLabel.text = [@(commentCount) stringValue];
}
- (void)setPleasureCount:(NSInteger)pleasureCount {
    _pleasureCount = pleasureCount;
    self.startSource.startCount = pleasureCount;
}

// 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.iconView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(10);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    if (_isReal) {
        [self.userNameLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.bottom).offset(15);
            make.centerX.equalTo(self.centerX).offset(-30);
        }];
    }else{
        [self.userNameLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.bottom).offset(15);
            make.centerX.equalTo(self.centerX).offset(0);
        }];
    }
    
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

    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.userNameLabel.bottom).offset(20);
        make.size.equalTo(CGSizeMake(1, 25));
    }];
    [self.fansCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.right.equalTo(self.line1.left).offset(-20);
    }];
    [self.fansLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.right.equalTo(self.fansCountLabel.left).offset(-5);
    }];
    [self.comment makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.line1.right).offset(20);
    }];
    [self.commentCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.line1.centerY);
        make.left.equalTo(self.comment.right).offset(5);
    }];
    
    [self.pleasure makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.centerX).offset(-10);
        make.top.equalTo(self.fansLabel.bottom).offset(20);
    }];
    [self.startSource makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pleasure.centerY);
        make.left.equalTo(self.pleasure.right).offset(10);
        make.height.equalTo(self.pleasure.height);
    }];
  
    if (_userImg.length > 0) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:_userImg];
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }
    if (_userName.length > 0) {
        self.userNameLabel.text = _userName;
    }
    if (_isReal) {
        self.userNameAuthen.hidden = NO;
        if (_isMentch) {
            self.sellerAuthen.hidden = NO;
            self.pleasure.hidden = NO;
            self.startSource.hidden = NO;
        }else{
            self.sellerAuthen.hidden = YES;
            self.pleasure.hidden = YES;
            self.startSource.hidden = YES;
        }
    }else{
        self.userNameAuthen.hidden = YES;
    }
}
#pragma mark
#pragma mark - 懒加载
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
- (UILabel *)commentCountLabel {
    if (!_commentCountLabel) {
        _commentCountLabel = [[UILabel alloc] init];
        _commentCountLabel.text = @"111";
        _commentCountLabel.font = [UIFont systemFontOfSize:14];
        _commentCountLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
    }
    return _commentCountLabel;
}
- (UILabel *)comment {
    if (!_comment) {
        _comment = [[UILabel alloc] init];
        _comment.text = @"评论";
        _comment.font = [UIFont systemFontOfSize:14];
        _comment.textColor = [UIColor colorWithHexString:@"#333333"];
        
    }
    return _comment;
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
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line1;
}
- (UILabel *)pleasure {
    if (!_pleasure) {
        _pleasure = [[UILabel alloc] init];
        _pleasure.text = @"消费者满意度";
        _pleasure.textColor = [UIColor colorWithHexString:@"#666666"];
        _pleasure.font = [UIFont systemFontOfSize:12];
    }
    return _pleasure;
}
- (StartSourceView *)startSource {
    if (!_startSource) {
        _startSource = [[StartSourceView alloc] init];
        _startSource.startCount = self.pleasureCount;
        _startSource.backgroundColor = [UIColor whiteColor];
    }
    return _startSource;
}
@end
