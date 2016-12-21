//
//  MerhantComplaint.m
//  GouGou-Live
//
//  Created by ma c on 16/12/13.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MerhantComplaint.h"

@interface MerhantComplaint ()
/** 提示文字 */
@property (strong,nonatomic) UILabel *complaintTitle;
/** 电话号码 */
@property (strong,nonatomic) UIButton *phoneNumBtn;
/** 提交 */
@property (strong,nonatomic) UIButton *handinBtn;

@end

@implementation MerhantComplaint

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.complaintTitle];
        [self addSubview:self.phoneNumBtn];
        [self addSubview:self.handinBtn];
    }
    return self;
}

#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_complaintTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.top).offset(44);
        make.centerX.equalTo(weakself.centerX);
    }];
    
    [_phoneNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.complaintTitle.bottom).offset(10);
        make.centerX.equalTo(weakself.centerX);
        make.size.equalTo(CGSizeMake(120, 32));
    }];
    [_handinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(weakself);
        make.height.equalTo(44);
    }];
    
}
#pragma mark - 懒加载
- (UILabel *)complaintTitle {
    if (!_complaintTitle) {
        _complaintTitle = [[UILabel alloc] init];
        _complaintTitle.textColor = [UIColor colorWithHexString:@"#999999"];
        _complaintTitle.font = [UIFont systemFontOfSize:12];
        _complaintTitle.text = @"商品、商家投诉请拨打客服电话";
    }
    return _complaintTitle;
}

- (UIButton *)phoneNumBtn {
    if (!_phoneNumBtn) {
        _phoneNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneNumBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        [_phoneNumBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        _phoneNumBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_phoneNumBtn setTitle:@"电话号码" forState:UIControlStateNormal];
        _phoneNumBtn.layer.cornerRadius  = 5;
        _phoneNumBtn.layer.masksToBounds = YES;
        [_phoneNumBtn addTarget:self action:@selector(clickPhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneNumBtn;
}
- (UIButton *)handinBtn {
    if (!_handinBtn) {
        _handinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_handinBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_handinBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_handinBtn setTitle:@"提交" forState:UIControlStateNormal];
        _handinBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _handinBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_handinBtn addTarget:self action:@selector(clickHandinBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handinBtn;
}
#pragma mark - 按钮点击事件
- (void)clickHandinBtn:(UIButton *)button {
    if (_handinBlock) {
        _handinBlock(button);
    }
    
}
- (void)clickPhoneNumber {

    if (_phoneNumBlock) {
        _phoneNumBlock();
    }
}
@end
