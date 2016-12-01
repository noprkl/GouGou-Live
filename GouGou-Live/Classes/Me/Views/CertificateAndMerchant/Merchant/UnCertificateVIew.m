//
//  UnCertificateVIew.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UnCertificateVIew.h"

@interface UnCertificateVIew ()

/** 倒计时 */
@property (strong,nonatomic) UIButton *countdownBtn;
/** 开心狗图片 */
@property (strong,nonatomic) UIImageView *imageView;
/** 提示文字 */
@property (strong,nonatomic) UILabel *titlelable;
/** 实名认证按钮 */
@property (strong,nonatomic) UIButton *certificateButton;


@end
@implementation UnCertificateVIew
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.countdownBtn];
        [self addSubview:self.imageView];
        [self addSubview:self.titlelable];
        [self addSubview:self.certificateButton];
        [self freetimeout];
    }
    return self;
}

#pragma mark
#pragma mark - 约束
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_countdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(10);
        make.right.equalTo(weakself.right).offset(-10);
        
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.top).offset(50);
        make.centerX.equalTo(weakself.centerX);
        
    }];
    
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.imageView.bottom).offset(20);
        make.centerX.equalTo(weakself.centerX);
        
    }];
    
    [_certificateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.titlelable.bottom).offset(20);
        make.centerX.equalTo(weakself.centerX);
        make.left.equalTo(weakself.left).offset(10);
        make.height.equalTo(44);
        
    }];
}

#pragma mark
#pragma mark - 懒加载
-(UIButton *)countdownBtn {
    
    if (!_countdownBtn) {
        _countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_countdownBtn setTitle:@"3s自动跳转" forState:UIControlStateNormal];
        _countdownBtn.enabled = NO;
        _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_countdownBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        }
    return _countdownBtn;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon开心狗"]];
    }
    return _imageView;
}

- (UILabel *)titlelable {
    
    if (!_titlelable) {
        _titlelable = [[UILabel alloc] init];
        _titlelable.text = @"只有完成实名认证后才可商家认证";
        _titlelable.textColor = [UIColor colorWithHexString:@"#999999"];
        _titlelable.font = [UIFont systemFontOfSize:14];
    }
    return _titlelable;
}

- (UIButton *)certificateButton {
    
    if (!_certificateButton) {
        _certificateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _certificateButton.layer.cornerRadius = 5;
        _certificateButton.layer.masksToBounds = YES;
        [_certificateButton setTitle:@"实名认证" forState:UIControlStateNormal];
        _certificateButton.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_certificateButton setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _certificateButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_certificateButton addTarget:self action:@selector(clickCertificateBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _certificateButton;
}

- (void)clickCertificateBtn:(UIButton *)button {
    
    if (_certificateBlack) {
        _certificateBlack();
    }
    
}

- (void)freetimeout {
    __block NSInteger time = 3;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time < 1) {
            //取消计时
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self clickCertificateBtn:self.certificateButton];
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.countdownBtn.tintColor = [UIColor colorWithHexString:@"#b2b2b2"];
                
                NSString *string = [NSString stringWithFormat:@"%ldS自动跳转",time];
                
                [self.countdownBtn setTitle:string forState:(UIControlStateNormal)];
            });
            time --;
        }
        
    });
    dispatch_resume(timer);
    
}



@end
