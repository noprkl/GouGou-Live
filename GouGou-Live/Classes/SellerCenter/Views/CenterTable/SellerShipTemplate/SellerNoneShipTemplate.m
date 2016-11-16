//
//  SellerNoneShipTemplate.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerNoneShipTemplate.h"

@interface SellerNoneShipTemplate ()

@property(nonatomic, strong) UIImageView *imageView; /**< 图片 */

@property(nonatomic, strong) UILabel *label; /**< 文字 */

@end

@implementation SellerNoneShipTemplate
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [self addSubview:self.imageView];
        [self addSubview:self.label];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(50);
    }];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.imageView.bottom).offset(20);
    }];
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"矢量智能对象"];
    }
    return _imageView;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"暂时还没有运费模板";
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _label;
}
@end
