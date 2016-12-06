//
//  SellerOrderDetailNoteView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  订单详情-备注

#import "SellerOrderDetailNoteView.h"

@interface SellerOrderDetailNoteView ()

@property(nonatomic, strong) UILabel *noteLabel; /**< 备注 */

@end
@implementation SellerOrderDetailNoteView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.noteLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(15);
        make.right.equalTo(self.right).offset(-15);
    }];
    
    self.layer.cornerRadius = 9;
    self.layer.masksToBounds = YES;
}
- (void)setNoteStr:(NSString *)noteStr {
    _noteStr = noteStr;
    self.noteLabel.text = noteStr;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"备注：这只狗狗需要笼子、狗粮";
        _noteLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _noteLabel.font = [UIFont systemFontOfSize:14];
    }
    return _noteLabel;
}
@end
