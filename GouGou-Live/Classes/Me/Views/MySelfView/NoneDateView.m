//
//  NoneDateView.m
//  GouGou-Live
//
//  Created by ma c on 17/1/3.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "NoneDateView.h"

@interface NoneDateView ()

@property (nonatomic, strong) UIImageView *imageView; /**< 图片 */

@property (nonatomic, strong) UILabel *noteLabel; /**< 提示 */

@end

@implementation NoneDateView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.noteLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.top).offset(70);
    }];
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX);
        make.top.equalTo(self.imageView.bottom).offset(20);
    }];
    
}
- (void)setNoteStr:(NSString *)noteStr {
    _noteStr = noteStr;
    self.noteLabel.text = noteStr;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"矢量智能对象"];
    }
    return _imageView;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"没有数据";
        _noteLabel.font = [UIFont systemFontOfSize:14];
        _noteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noteLabel;
}
@end
