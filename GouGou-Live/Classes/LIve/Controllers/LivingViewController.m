//
//  LivingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//  观看界面

#import "LivingViewController.h"

@interface LivingViewController ()



/** 返回按钮 */
@property (strong, nonatomic) UIButton *backBtn;
/** 直播中 */
@property (strong, nonatomic) UILabel *roomName;

/** 举报 */
@property (strong, nonatomic) UIButton *reportBtn;
/** 分享 */
@property (strong, nonatomic) UIButton *shareBtn;
/** 收藏 */
@property (strong, nonatomic) UIButton *collectBtn;

/** 观看人数 */
@property (strong, nonatomic) UIButton *watchLabel;
/** 全屏 */
@property (strong, nonatomic) UIButton *screenBtn;

/** 商品列表 */
//@property (strong, nonatomic)  *<#class#>;
@end

@implementation LivingViewController

#pragma mark
#pragma mark - viewcontroller生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // navBar隐藏
    self.navigationController.navigationBarHidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // navBar显示
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;
    
}
#pragma mark
#pragma mark - UI
- (void)initUI {
    
//    UIWindow *window = [[UIApplication sharedApplication].delegate window];
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    [self.view addSubview:self.backBtn];
    
    
    
    
    
    [self makeConstraint];
    
   
}
- (void)makeConstraint {

    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.left).offset(25);
        make.left.equalTo(self.view.left).offset(20);
    }];

}
#pragma mark
#pragma mark - Action
- (void)clickBackBtnAction {
    
    [self  popoverPresentationController];
}
- (void)clickReportBtnAction {

}
- (void)clickShareBtnAction {
    
}
- (void)clickCollectBtnAction {
    
}
- (void)clickScreenBtnAction {
    
}

#pragma mark
#pragma mark - 懒加载
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_backBtn sizeToFit];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(clickBackBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (UIButton *)reportBtn {
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_reportBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
        [_reportBtn addTarget:self action:@selector(clickBackBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _reportBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
