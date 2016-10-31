//
//  LivingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//  观看界面

// 按钮宽高
#define kWidth 22

#import "LivingViewController.h"
#import "LivingCenterView.h"
#import "LiveTopView.h"

@interface LivingViewController ()

/** 返回按钮 */
@property (strong, nonatomic) UIButton *backBtn;

/** 直播中 */
@property (strong, nonatomic) UILabel *roomNameLabel;

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

/** 选择按钮 */
@property (strong, nonatomic) LivingCenterView *centerView;

/** 按钮名字 */
@property (strong, nonatomic) NSArray *childTitles;
/** 按钮未选中图片 */
@property (strong, nonatomic) NSArray *childNormalImages;
/** 按钮选中图片 */
@property (strong, nonatomic) NSArray *childSelectImages;

/** 子控制器 */
@property (strong, nonatomic) NSMutableArray *childVCS;
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
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backBtn removeFromSuperview];
    [self.roomNameLabel removeFromSuperview];
    [self.reportBtn removeFromSuperview];
    [self.shareBtn removeFromSuperview];
    [self.collectBtn removeFromSuperview];
    [self.watchLabel removeFromSuperview];
    [self.screenBtn removeFromSuperview];
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
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    [window addSubview:self.backBtn];
    [window addSubview:self.roomNameLabel];
    [window addSubview:self.reportBtn];
    [window addSubview:self.shareBtn];
    [window addSubview:self.collectBtn];
    [window addSubview:self.watchLabel];
    [window addSubview:self.screenBtn];
    
    
    [self.view addSubview:self.centerView];

    
    [self makeConstraint];
}
- (void)makeConstraint {
    [self.centerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(245);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 45));
    }];
}
- (NSMutableArray *)childVCS {
    if (!_childVCS) {
        _childVCS = [NSMutableArray array];
    }
    return _childVCS;
}
- (void)addChildViewController {
    
    NSArray *childVCNames = @[@"TalkingViewController", @"DogShowViewController", @"ServiceViewController", @"SellerShowViewController"];
    
    for (NSInteger i = 0; i < childVCNames.count; i ++) {
        UIViewController *vc = [[NSClassFromString(childVCNames[i]) alloc] init];
        
        [self addChildViewController:vc];
        [self.childVCS addObject:vc];
    }
    
    [self addChildView:1];
}

#pragma mark
#pragma mark - 中间view
- (void)addChildView:(NSInteger)index {

    UIViewController *vc = self.childVCS[index];
    
    if ([vc  isViewLoaded]) return;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect rect = vc.view.frame;
        rect = CGRectMake(index * SCREEN_WIDTH, CGRectGetMaxY(self.centerView.frame), SCREEN_WIDTH, 1000);
        vc.view.frame = rect;
    }];

    [self.view addSubview:vc.view];

}
- (LivingCenterView *)centerView {
    
    if (!_centerView) {
        _centerView = [[LivingCenterView alloc] init];
        __weak typeof(self) weakSelf = self;
        _centerView.talkBlock = ^(UIButton *btn){
            
            
            
            [weakSelf addChildView:0];
            
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            [weakSelf addChildView:1];
            
            return YES;
        };
        _centerView.serviceBlock = ^(UIButton *btn){
            [weakSelf addChildView:2];
            return YES;
        };
        _centerView.sellerBlock = ^(UIButton *btn){
            [weakSelf addChildView:3];
            return YES;
        };
    }
    return _centerView;
}
- (NSArray *)childTitles {
    if (!_childTitles) {
        _childTitles = @[@"聊天", @"狗狗", @"客服", @"认证商家"];
    }
    return _childTitles;
}

#pragma mark
#pragma mark - Action
- (void)clickBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
        _backBtn.frame = CGRectMake(20, 30, kWidth, kWidth);
        
        _backBtn.layer.cornerRadius = 3;
        _backBtn.layer.masksToBounds = YES;
        
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(clickBackBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (UILabel *)roomNameLabel {
    if (!_roomNameLabel) {
        _roomNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + kWidth + 5, 30, 70, kWidth)];
        _roomNameLabel.layer.cornerRadius = 3;
        _roomNameLabel.layer.masksToBounds = YES;
        
        _roomNameLabel.text = @"直播名字";
        _roomNameLabel.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];

        _roomNameLabel.textAlignment = NSTextAlignmentCenter;
        _roomNameLabel.textColor = [UIColor whiteColor];
    }
    return _roomNameLabel;
}
- (UIButton *)reportBtn {
    if (!_reportBtn) {
        _reportBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        _reportBtn.layer.cornerRadius = 3;
        _reportBtn.layer.masksToBounds = YES;
        
        _reportBtn.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];
        _reportBtn.frame = CGRectMake((SCREEN_WIDTH - kWidth * 2 - 10 * 2), 30, kWidth, kWidth);

        [_reportBtn setImage:[UIImage imageNamed:@"举报"] forState:(UIControlStateNormal)];
        [_reportBtn addTarget:self action:@selector(clickReportBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _reportBtn;
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
       
        _shareBtn.layer.cornerRadius = 3;
        _shareBtn.layer.masksToBounds = YES;

        _shareBtn.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];
        _shareBtn.frame = CGRectMake((SCREEN_WIDTH - kWidth - 10), 30, kWidth, kWidth);
        
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
        [_shareBtn addTarget:self action:@selector(clickShareBtnAction) forControlEvents:(UIControlEventTouchDown)];

    }
    return _shareBtn;
}
- (UIButton *)collectBtn {
    if (!_collectBtn) {
        
        _collectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _collectBtn.layer.cornerRadius = 3;
        _collectBtn.layer.masksToBounds = YES;

        _collectBtn.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];
        _collectBtn.frame = CGRectMake((SCREEN_WIDTH - kWidth - 10), 30 + kWidth + 10, kWidth, kWidth);
        
        [_collectBtn setImage:[UIImage imageNamed:@"喜欢icon(点击"] forState:(UIControlStateNormal)];
        [_collectBtn addTarget:self action:@selector(clickCollectBtnAction) forControlEvents:(UIControlEventTouchDown)];

    }
    return _collectBtn;
}
- (UIButton *)screenBtn {
    if (!_screenBtn) {
        _screenBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        
        _screenBtn.layer.cornerRadius = 3;
        _screenBtn.layer.masksToBounds = YES;
        
        _screenBtn.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];
        _screenBtn.frame = CGRectMake((SCREEN_WIDTH - kWidth - 10), 215, kWidth, kWidth);
        
        [_screenBtn setImage:[UIImage imageNamed:@"缩小"] forState:(UIControlStateNormal)];
        [_screenBtn addTarget:self action:@selector(clickScreenBtnAction) forControlEvents:(UIControlEventTouchDown)];
        

    }
    return _screenBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
