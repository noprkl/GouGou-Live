//
//  MerchantViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MerchantViewController.h"
#import "CertificateViewController.h"

#import "UnCertificateVIew.h"
#import "DoneCertificateView.h"
#import "PhotoView.h"

static NSString * MedrchantCell = @"MedrchantCell";

@interface MerchantViewController ()
/** 未认证 */
@property (strong,nonatomic) UnCertificateVIew *unCertificateVIew;
/** 已经实名认证 */
@property (strong,nonatomic) DoneCertificateView *doneCertificateView;
/** 照片 */
@property (strong,nonatomic) PhotoView *photoView;

@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if ([[UserInfos sharedUser].isreal isEqualToString:@"0"]) {
//        [self.view addSubview:self.unCertificateVIew];
//
//    }else{
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(clickHandinCertitycate)];
//        
//        [self.view addSubview:self.doneCertificateView];
//    }
    
//    [self.view addSubview:self.unCertificateVIew];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(clickHandinCertitycate)];
    
    [self.view addSubview:self.doneCertificateView];
    [self.view addSubview:self.photoView];

}
// 点击提交认证
- (void)clickHandinCertitycate {
    
//    BOOL flag =  [NSString valiMobile:self.phoneNumTextfiled.text];
//    if (!flag) {
//        
//        [self showAlert:@"输入的不是电话号码"];
//    } else {
//        
//        
//    }
//
    DLog(@"%@", self.doneCertificateView.infoTextfiled.text);
    DLog(@"%@", self.doneCertificateView.adressTextField.text);
    DLog(@"%@", self.doneCertificateView.aresTextField.text);
    DLog(@"%@", self.doneCertificateView.phoneNumTextfiled.text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UnCertificateVIew *)unCertificateVIew {
    if (!_unCertificateVIew) {
        _unCertificateVIew = [[UnCertificateVIew alloc] initWithFrame:self.view.bounds];
        _unCertificateVIew.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

        __weak typeof(self) weakSelf = self;
        _unCertificateVIew.certificateBlack = ^(UIButton *btn){
            CertificateViewController *certifi = [[CertificateViewController alloc] init];
            [weakSelf.navigationController pushViewController:certifi animated:YES];
        };
        
    }
    return _unCertificateVIew;
}
- (DoneCertificateView *)doneCertificateView {
    if (!_doneCertificateView) {
        _doneCertificateView = [[DoneCertificateView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64))];
        _doneCertificateView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
    }
    return _doneCertificateView;
}
- (PhotoView *)photoView {
    
    if (!_photoView) {
        _photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, 197)];
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
//        __weak typeof(self) weakSelf = self;
//        _photoView.deleteBlock = ^(){
//            __strong typeof(weakSelf) strSelf = weakSelf;
//            _photoView = nil;
//            [strSelf.photoView removeFromSuperview];
//        };
    }
    return _photoView;
}
@end
