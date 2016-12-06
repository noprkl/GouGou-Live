
//
//  AnonymityAssessView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AnonymityAssessView.h"

@interface AnonymityAssessView ()
/** 匿名 */
@property (strong,nonatomic) UILabel *anonymityLabel;
/** 开关 */
@property (strong,nonatomic) UISwitch *swichs;

@end

@implementation AnonymityAssessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.anonymityLabel];
        [self addSubview:self.swichs];
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_anonymityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
    [_swichs mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(weakself.right).offset(-10);
        make.centerY.equalTo(weakself.centerY);
        
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)anonymityLabel {

    if (!_anonymityLabel) {
        _anonymityLabel = [[UILabel alloc] init];
        _anonymityLabel.text = @"匿名评价";
        _anonymityLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _anonymityLabel.font = [UIFont systemFontOfSize:16];
    }
    return _anonymityLabel;
}
- (UISwitch *)swichs {

    if (!_swichs) {
        _swichs = [[UISwitch alloc] init];
        [_swichs addTarget:self action:@selector(anonymityCommentAction) forControlEvents:UIControlEventValueChanged];
    }
    return _swichs;
}

- (void)anonymityCommentAction {


}

@end
