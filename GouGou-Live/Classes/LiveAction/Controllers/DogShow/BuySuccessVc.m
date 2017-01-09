//
//  BuySuccessVc.m
//  GouGou-Live
//
//  Created by ma c on 17/1/3.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "BuySuccessVc.h"

@interface BuySuccessVc ()

@property (nonatomic, strong) UIImageView *imageView; /**< 图片 */

@property (nonatomic, strong) UILabel *noteLabel; /**< 提示 */

@property (nonatomic, strong) UIButton *backBtn; /**< 返回按钮 */

@end

@implementation BuySuccessVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.noteLabel];
    [self.view addSubview:self.backBtn];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.view.top).offset(70);
    }];
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.imageView.bottom).offset(20);
    }];
    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(self.noteLabel.bottom).offset(20);
    }];
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"icon开心狗"];
    }
    return _imageView;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"支付成功";
        _noteLabel.font = [UIFont systemFontOfSize:14];
        _noteLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _noteLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noteLabel;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _backBtn.titleLabel.tintColor = [UIColor colorWithHexString:@"#99cc33"];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
