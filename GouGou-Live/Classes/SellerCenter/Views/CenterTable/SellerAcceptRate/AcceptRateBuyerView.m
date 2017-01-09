//
//  AcceptRateBuyerView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AcceptRateBuyerView.h"

@interface AcceptRateBuyerView ()


//@property(nonatomic, strong) UIImageView *buyerIcon; /**< 买家头像 */
//
//@property(nonatomic, strong) UILabel *buyerName; /**< 买家名字 */
//
//@property(nonatomic, strong) UILabel *commentTime; /**< 评论时间 */
//
//@property(nonatomic, strong) UILabel *commentContent; /**< 评论内容 */
//@property(nonatomic, strong) UIView *line; /**< 线 */

@end

@implementation AcceptRateBuyerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.buyerIcon];
        [self addSubview:self.buyerName];
        [self addSubview:self.commentTime];
        [self addSubview:self.commentContent];
        [self addSubview:self.line];
    }
    return self;
}
- (void)setModel:(AcceptRateBuyerModel *)model {
    _model = model;
    NSString *urlString = [IMAGE_HOST stringByAppendingString:model.userImgUrl];
    [self.buyerIcon sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    self.buyerName.text = model.userNickName;
    self.commentContent.text = model.comment;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.buyerIcon makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.left.equalTo(self.left).offset(10);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    [self.buyerName makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.buyerIcon.centerY).offset(-5);
        make.left.equalTo(self.buyerIcon.right).offset(10);
    }];
    [self.commentTime makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.buyerName.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    [self.commentContent makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buyerIcon.centerY).offset(5);
        make.left.equalTo(self.buyerIcon.right).offset(10);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.bottom.equalTo(self.bottom);
        make.height.equalTo(1);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UIImageView *)buyerIcon {
    if (!_buyerIcon) {
        _buyerIcon = [[UIImageView alloc] init];
//        _buyerIcon.image = [UIImage imageNamed:@"主播头像"];
        
        // 切圆
        _buyerIcon.layer.cornerRadius = 22;
        _buyerIcon.layer.masksToBounds = YES;
        // 加边框
        _buyerIcon.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _buyerIcon.layer.borderWidth = 1;

    }
    return _buyerIcon;
}
- (UILabel *)buyerName {
    if (!_buyerName) {
        _buyerName = [[UILabel alloc] init];
//        _buyerName.text = @"买家**称";
        _buyerName.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _buyerName.font = [UIFont systemFontOfSize:14];
    }
    return _buyerName;
}
- (UILabel *)commentTime {
    if (!_commentTime) {
        _commentTime = [[UILabel alloc] init];
        _commentTime.textColor = [UIColor colorWithHexString:@"#666666"];
        _commentTime.font = [UIFont systemFontOfSize:12];
    }
    return _commentTime;
}
- (UILabel *)commentContent {
    if (!_commentContent) {
        _commentContent = [[UILabel alloc] init];
        
//        _commentContent.text = @"狗狗很可爱";
        _commentContent.textColor = [UIColor colorWithHexString:@"#000000"];
        _commentContent.font = [UIFont systemFontOfSize:14];
    }
    return _commentContent;
}
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line;
}
@end
