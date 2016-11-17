//
//  SellerProtectApplyRefundView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerProtectApplyRefundView.h"
#import "DogImageView.h"

@interface SellerProtectApplyRefundView ()

@property(nonatomic, strong) UILabel *applyRefund; /**< 申请退款 */

@property(nonatomic, strong) UILabel *applyRefundCount; /**< 款数 */

@property(nonatomic, strong) DogImageView *pictures; /**< 图片个数 */

@property(nonatomic, strong) UILabel *reasonLabel; /**< 退款理由 */

@end
@implementation SellerProtectApplyRefundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.applyRefund];
        [self addSubview:self.applyRefundCount];
        [self addSubview:self.pictures];
        [self addSubview:self.reasonLabel];
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.applyRefund makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(20);
        make.left.equalTo(self.left).offset(10);
    }];
    [self.applyRefundCount makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.applyRefund.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];

    CGFloat height = [self.pictures getCellHeightWithImages:@[@"组-7", @"组-7", @"组-7"]];
    [self.pictures makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.applyRefund.bottom).offset(20);
        make.left.width.equalTo(self);
        make.height.equalTo(height);
    }];
    [self.reasonLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictures.bottom).offset(20);
        make.left.equalTo(self.left).offset(10);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)applyRefund {
    if (!_applyRefund) {
        _applyRefund = [[UILabel alloc] init];
        _applyRefund.text = @"申请赔款";
        _applyRefund.textColor = [UIColor colorWithHexString:@"#333333"];
        _applyRefund.font = [UIFont systemFontOfSize:16];
    }
    return _applyRefund;
}
- (UILabel *)applyRefundCount {
    if (!_applyRefundCount) {
        _applyRefundCount = [[UILabel alloc] init];
        _applyRefundCount.text = @"¥ 1000";
        _applyRefundCount.textColor = [UIColor colorWithHexString:@"#333333"];
        _applyRefundCount.font = [UIFont boldSystemFontOfSize:16];
    }
    return _applyRefundCount;
}
- (DogImageView *)pictures {
    if (!_pictures) {
        _pictures = [[DogImageView alloc] init];
    }
    return _pictures;
}
- (UILabel *)reasonLabel {
    if (!_reasonLabel) {
        _reasonLabel = [[UILabel alloc] init];
        _reasonLabel.text = @"狗狗腿有问题，需要赔偿";
        _reasonLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _reasonLabel.font = [UIFont systemFontOfSize:14];
    }
    return _reasonLabel;
}
@end
