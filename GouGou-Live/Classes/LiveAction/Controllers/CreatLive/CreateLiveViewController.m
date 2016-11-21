//
//  CreateLiveViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CreateLiveViewController.h"

@interface CreateLiveViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *editNameText; /**< 名字编辑 */
@property (weak, nonatomic) IBOutlet UILabel *noteLabel; /**< 提示 */
@property (weak, nonatomic) IBOutlet UIButton *sellORBtn; /**< 是否出售按钮 */
@property (weak, nonatomic) IBOutlet UILabel *cityLabel; /**< 城市 */
@property (strong, nonatomic) UIView *lineView; /**< 横线 */

@property (strong, nonatomic) UILabel *shareLabel; /**< 分享到 */

@property(nonatomic, strong) UIButton *SinaShareBtn; /**< 微博 */

@property(nonatomic, strong) UIButton *friendShareBtn; /**< 朋友圈 */

@property(nonatomic, strong) UIButton *WXShareBtn; /**< 微信 */

@property(nonatomic, strong) UIButton *QQShareBtn; /**< QQ */

@property(nonatomic, strong) UIButton *TencentShareBtn; /**< 空间 */

@property(nonatomic, strong) UIButton *beginLiveBtn; /**< 开始直播 */

@end

@implementation CreateLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 设置navigationBar的透明效果
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];

}
- (void)initUI {

    [self.view addSubview:self.lineView];
    [self.view addSubview:self.shareLabel];
    [self.view addSubview:self.QQShareBtn];
    [self.view addSubview:self.SinaShareBtn];
    [self.view addSubview:self.TencentShareBtn];
    [self.view addSubview:self.WXShareBtn];
    [self.view addSubview:self.friendShareBtn];
    [self.view addSubview:self.beginLiveBtn];

    self.editNameText.delegate = self;
    
    [self makeConstraint];
}
// 约束
- (void)makeConstraint {
    if (self.sellORBtn.selected) {
        [self.lineView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sellORBtn.bottom).offset(100);
            make.centerX.equalTo(self.view.centerX);
            make.size.equalTo(CGSizeMake(225, 1));
        }];
    }else{
        [self.lineView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sellORBtn.bottom).offset(25);
            make.centerX.equalTo(self.view.centerX);
            make.size.equalTo(CGSizeMake(225, 1));
        }];
    }
    [self.shareLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.bottom).offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    [self.QQShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareLabel.bottom).offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];
    [self.friendShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.QQShareBtn.left).offset(-20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.WXShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.friendShareBtn.left).offset(-20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.TencentShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QQShareBtn.right).offset(20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.SinaShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TencentShareBtn.right).offset(20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.beginLiveBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQShareBtn.bottom).offset(15);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(310, 44));
    }];
}
#pragma mark
#pragma mark - Action
- (IBAction)clickSellORBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    
    [self makeConstraint];
}
- (IBAction)clickDeleteBtnAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 微博分享
- (void)ClickSinaShareAction:(UIButton *)btn{
    
}
// 微信分享
- (void)ClickWXShareAction:(UIButton *)btn{
    
}
// QQ分享
- (void)ClickQQShareAction:(UIButton *)btn{
    
}
// 空间分享
- (void)ClickTencentShareAction:(UIButton *)btn{
    
}
// 朋友圈分享
- (void)ClickFriendShareAction:(UIButton *)btn{
    
}
// 开始直播
- (void)ClickBeginLiveBtnAction:(UIButton *)btn{ }
#pragma mark
#pragma mark - 懒加载
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}
- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.text = @"分享到";
        _shareLabel.font = [UIFont systemFontOfSize:12];
        _shareLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _shareLabel;
    
}
- (UIButton *)QQShareBtn {
    if (!_QQShareBtn) {
        _QQShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_QQShareBtn setImage:[UIImage imageNamed:@"QQgray"] forState:(UIControlStateNormal)];
        [_QQShareBtn addTarget:self action:@selector(ClickQQShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _QQShareBtn;
}
- (UIButton *)WXShareBtn {
    if (!_WXShareBtn) {
        _WXShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_WXShareBtn setImage:[UIImage imageNamed:@"微信未点击"] forState:(UIControlStateNormal)];
        [_WXShareBtn addTarget:self action:@selector(ClickWXShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _WXShareBtn;
}
- (UIButton *)SinaShareBtn {
    if (!_SinaShareBtn) {
        _SinaShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_SinaShareBtn setImage:[UIImage imageNamed:@"weibo_btn"] forState:(UIControlStateNormal)];
        [_SinaShareBtn addTarget:self action:@selector(ClickSinaShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _SinaShareBtn;
}
- (UIButton *)TencentShareBtn {
    if (!_TencentShareBtn) {
        _TencentShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_TencentShareBtn setImage:[UIImage imageNamed:@"空间"] forState:(UIControlStateNormal)];
        [_TencentShareBtn addTarget:self action:@selector(ClickTencentShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _TencentShareBtn;
}
- (UIButton *)friendShareBtn {
    if (!_friendShareBtn) {
        _friendShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_friendShareBtn setImage:[UIImage imageNamed:@"朋友圈"] forState:(UIControlStateNormal)];
        [_friendShareBtn addTarget:self action:@selector(ClickFriendShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _friendShareBtn;
}
- (UIButton *)beginLiveBtn {
    if (!_beginLiveBtn) {
        _beginLiveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_beginLiveBtn setTitle:@"开始直播" forState:(UIControlStateNormal)];
        [_beginLiveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _beginLiveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _beginLiveBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        _beginLiveBtn.layer.cornerRadius = 9;
        _beginLiveBtn.layer.masksToBounds = YES;
        
        [_beginLiveBtn addTarget:self action:@selector(ClickBeginLiveBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _beginLiveBtn;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location < 12) {
        return YES;
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.noteLabel.hidden = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
   
    if ([textField.text isEqualToString:@""]) {
        self.noteLabel.hidden = NO;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
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
