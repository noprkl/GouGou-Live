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

#import "ShareAlertView.h"
#import "ShareBtnModel.h"
#import "DeletePrommtView.h" // 举报提示
#import "TalkingView.h"

#import "LandscapePlayerVc.h" // 横屏播放

#import "TalkingViewController.h"
#import "ServiceViewController.h"
#import "DogShowViewController.h"
#import "SellerShowViewController.h"

#import <PLPlayerKit/PLPlayerKit.h>

@interface LivingViewController ()<UIScrollViewDelegate, PLPlayerDelegate>

@property (nonatomic, strong) PLPlayer *player;

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

/** 底部scrollview */
@property (strong, nonatomic) UIScrollView *baseScrollView;

/** 子控制器 */
@property (strong, nonatomic) NSMutableArray *childVCS;

/** 分享弹出框 */
@property (strong, nonatomic) NSArray *shareAlertBtns;


@property(nonatomic, strong) UIViewController *lastVC; /**< 上一个控制器 */
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
//    self.backBtn.hidden = NO;
//    self.roomNameLabel.hidden = NO;
//    self.reportBtn.hidden = NO;
//    self.shareBtn.hidden = NO;
//    self.collectBtn.hidden = NO;
//    self.watchLabel.hidden = NO;
//    self.screenBtn.hidden = NO;

    // 设置navigationBar的透明效果
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
//    self.backBtn.hidden = YES;
//    self.roomNameLabel.hidden = YES;
//    self.reportBtn.hidden = YES;
//    self.shareBtn.hidden = YES;
//    self.collectBtn.hidden = YES;
//    self.watchLabel.hidden = YES;
//    self.screenBtn.hidden = YES;

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

#pragma mark
#pragma mark - UI
- (void)initUI {
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

//    [window addSubview:self.backBtn];
//    [window addSubview:self.roomNameLabel];
//    [window addSubview:self.reportBtn];
//    [window addSubview:self.shareBtn];
//    [window addSubview:self.collectBtn];
//    [window addSubview:self.watchLabel];
//    [window addSubview:self.screenBtn];
    // 初始化 PLPlayerOption 对象
    PLPlayerOption *playerOption = [PLPlayerOption defaultOption];
    
    // 更改需要修改的 option 属性键所对应的值
    [playerOption setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [playerOption setOptionValue:@2000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [playerOption setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [playerOption setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [playerOption setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];
    
    
    
    NSURL *url = [NSURL URLWithString:@"rtmp://pili-live-rtmp.zhuaxingtech.com/gougoulive/helloios"];
    self.player = [PLPlayer playerWithURL:url option:playerOption];
    self.player.delegate = self;
    self.player.playerView.frame = CGRectMake(0, 10, SCREEN_WIDTH, 225);
    // 添加子视图
    [self.view addSubview:self.player.playerView];
    // 播放
    [self.player play];
   
    [self.player.playerView addSubview:self.backBtn];
    [self.player.playerView addSubview:self.roomNameLabel];
    [self.player.playerView addSubview:self.reportBtn];
    [self.player.playerView addSubview:self.shareBtn];
    [self.player.playerView addSubview:self.collectBtn];
    [self.player.playerView addSubview:self.watchLabel];
    [self.player.playerView addSubview:self.screenBtn];

    // 播放控件约束
    [self makeSubviewConstraint];
    
    
    
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.baseScrollView];
    // 子视图
    [self addChildViewController];
    // 子视图约束
    [self makeConstraint];
}
// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
    DLog(@"%@", player);
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误时，会回调这个方法
    DLog(@"%@", error);
}
// 播放控件约束
- (void)makeSubviewConstraint {
    [self.player.playerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(225);
    }];
    [self.backBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.player.playerView.left).offset(15);
        make.top.equalTo(self.player.playerView.top).offset(10);
    }];
    [self.roomNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.left.equalTo(self.backBtn.right).offset(15);
    }];
    [self.shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.right.equalTo(self.player.playerView.right).offset(-10);
    }];
    
    [self.reportBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.right.equalTo(self.shareBtn.left).offset(-10);
    }];
    [self.collectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn.centerX);
        make.top.equalTo(self.shareBtn.bottom).offset(10);
    }];
    [self.watchLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.left);
        make.bottom.equalTo(self.player.playerView.bottom).offset(-10);
        make.width.equalTo(100);
    }];
    [self.screenBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn.centerX);
        make.bottom.equalTo(self.player.playerView.bottom).offset(-10);
    }];
}

// 自控制器约束
- (void)makeConstraint {
    [self.centerView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(245);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 45));
    }];
    
    [self.baseScrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}
- (NSMutableArray *)childVCS {
    if (!_childVCS) {
        _childVCS = [NSMutableArray array];
    }
    return _childVCS;
}
- (void)addChildViewController {
    
//    NSArray *childVCNames = @[@"TalkingViewController", @"DogShowViewController", @"ServiceViewController", @"SellerShowViewController"];
//    
//    for (NSInteger i = 0; i < childVCNames.count; i ++) {
//        UIViewController *vc = [[NSClassFromString(childVCNames[i]) alloc] init];
//        
//        [self addChildViewController:vc];
//        [self.childVCS addObject:vc];
//    }
    TalkingViewController *talkVC = [[TalkingViewController alloc] init];
    [self.childVCS addObject:talkVC];
    [self addChildViewController:talkVC];
    DogShowViewController *dogShowVC = [[DogShowViewController alloc] init];
    [self.childVCS addObject:dogShowVC];
    [self addChildViewController:dogShowVC];
    ServiceViewController *serviceVC = [[ServiceViewController alloc] initWithConversationChatter:@"liver" conversationType:(EMConversationTypeChat)];
    [self.childVCS addObject:serviceVC];
    [self addChildViewController:serviceVC];
    SellerShowViewController *sellerShowVC = [[SellerShowViewController alloc] init];
    [self.childVCS addObject:sellerShowVC];
    [self addChildViewController:sellerShowVC];
    
    // 将子控制器的view 加载到MainVC的ScrollView上  这里用的是加载时的屏幕宽
    self.baseScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childTitles.count, 0);
    
    // 设置contentView加载时的位置
    self.baseScrollView.contentOffset = CGPointMake(0, 0);
    
    // 减速结束加载控制器视图 代理
    self.baseScrollView.delegate = self;
    
    // 进入后第一次加载hot
    [self scrollViewDidEndDecelerating:self.baseScrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 每个子控制器的宽高
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    
    // 偏移量 - x
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取视图的索引
    NSInteger index = offset / width;
    
    //根据索引返回vc的引用
    UIViewController *childVC = self.childViewControllers[index];
    
#pragma mark - 隐藏键盘
    if ([self.lastVC isKindOfClass:NSClassFromString(@"TalkingViewController")]) {
        
        TalkingViewController *talkVC = (TalkingViewController *)self.lastVC;
        
        [talkVC.textField resignFirstResponder];
        
    }else if ([self.lastVC isKindOfClass:NSClassFromString(@"ServiceViewController")]){
        
        ServiceViewController *serviceVC = (ServiceViewController *)self.lastVC;
        
        [serviceVC.textField resignFirstResponder];
    }
    
    self.lastVC = childVC;

    // 判断当前vc是否加载过
    if ([childVC isViewLoaded]) return;
    
    // 给没加载过的控制器设置frame
    childVC.view.frame = CGRectMake(offset, 0, width, height - 290);
    
    // 添加控制器视图到contentScrollView上
    [scrollView addSubview:childVC.view];
    
}
// 减速结束时调用 加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 传的调用这个代理方法的scrollview
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark
#pragma mark - 中间view
- (UIScrollView *)baseScrollView {
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _baseScrollView.scrollEnabled = NO;
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.showsVerticalScrollIndicator = NO;
    }
    return _baseScrollView;
}
- (LivingCenterView *)centerView {
    
    if (!_centerView) {
        _centerView = [[LivingCenterView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        _centerView.talkBlock = ^(UIButton *btn){
            
            CGPoint center = CGPointMake(0 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            
            
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            
            CGPoint center = CGPointMake(1 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            
            
            
            return YES;
        };
        _centerView.serviceBlock = ^(UIButton *btn){
            CGPoint center = CGPointMake(2 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            

            
            return YES;
        };
        _centerView.sellerBlock = ^(UIButton *btn){
            CGPoint center = CGPointMake(3 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            
            
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
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    // 横屏->竖屏
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [self forceOrientation:UIInterfaceOrientationPortrait];
        
        self.shareBtn.hidden = NO;
        self.collectBtn.hidden = NO;
        self.reportBtn.hidden = NO;
        self.centerView.hidden = NO;
        self.baseScrollView.hidden = NO;
        
        CGRect rect = self.screenBtn.frame;
        rect = CGRectMake((SCREEN_WIDTH - kWidth - 10), 215, kWidth, kWidth);
        self.screenBtn.frame = rect;
        
        //        [self forceOrientation:UIInterfaceOrientationPortrait];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)clickReportBtnAction {
    
    // 举报
    DeletePrommtView *report = [[DeletePrommtView alloc] init];
    report.message = @"确定举报该用户";
    report.sureBlock = ^(UIButton *btn){
        DLog(@"举报");
    };
    [report show];
}
- (NSAttributedString *)getAttributeString:(NSString *)string {
    NSDictionary *attributeDict = @{
                                    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"]
                                    };
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:string attributes:attributeDict];

    return attribute;
}
- (void)clickShareBtnAction {
    
    __weak typeof(self) weakSelf = self;
    
    __block ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, self.view.bounds.size.width, 150) alertModels:self.shareAlertBtns tapView:^(NSInteger btnTag) {
        
        NSInteger index = btnTag - 20;
        switch (index) {
            case 0:
            {
                // 朋友圈
                [weakSelf MomentShare];
                shareAlert = nil;
                [shareAlert dismiss];
            }
                break;
            case 1:
            {
                // 微信
                [weakSelf WChatShare];
                shareAlert = nil;
                [shareAlert dismiss];
            }
                break;
            case 2:
            {
                // QQ空间
                [weakSelf TencentShare];
                shareAlert = nil;
                [shareAlert dismiss];
            }
                break;
            case 3:
            {
                // 新浪微博
                [weakSelf SinaShare];
                shareAlert = nil;
                [shareAlert dismiss];
            }
                break;
            case 4:
            {
                // QQ
                [weakSelf QQShare];
                shareAlert = nil;
                [shareAlert dismiss];
            }
                break;
                
            default:
                break;
        }
        
        } colCount:4];
    [shareAlert show];
}
- (void)clickCollectBtnAction {
    
}
- (void)clickScreenBtnAction:(UIButton *)btn {
   
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    
//    if (orientation == UIDeviceOrientationPortrait) {
//      
//        [self forceOrientation:(UIInterfaceOrientationLandscapeLeft)];
//        
//        self.shareBtn.hidden = YES;
//        self.collectBtn.hidden = YES;
//        self.reportBtn.hidden = YES;
//        self.centerView.hidden = YES;
//        self.baseScrollView.hidden = YES;
//        [self.view remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
//        }];
//        [self.player.playerView remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
//        }];
//    }else if (orientation == UIInterfaceOrientationLandscapeLeft) {
//       [self forceOrientation:UIInterfaceOrientationPortrait];
//       
//        self.shareBtn.hidden = NO;
//        self.collectBtn.hidden = NO;
//        self.reportBtn.hidden = NO;
//        self.centerView.hidden = NO;
//        self.baseScrollView.hidden = NO;
//        [self makeSubviewConstraint];
//    }
    LandscapePlayerVc *landscapeVc = [[LandscapePlayerVc alloc] init];
    landscapeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:landscapeVc animated:YES];
}
// 切换横屏
- (void)forceOrientation: (UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget: [UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
#pragma mark
#pragma mark - 懒加载

- (NSArray *)shareAlertBtns {
    if (!_shareAlertBtns) {
        _shareAlertBtns = [NSArray array];
        
        ShareBtnModel *model1 = [[ShareBtnModel alloc] initWithTitle:@"朋友圈" image:[UIImage imageNamed:@"朋友圈selected"]];
        
        ShareBtnModel *model2 = [[ShareBtnModel alloc] initWithTitle:@"微信" image:[UIImage imageNamed:@"微信select"]];
        
        ShareBtnModel *model3 = [[ShareBtnModel alloc] initWithTitle:@"QQ空间" image:[UIImage imageNamed:@"QQ空间"]];
        ShareBtnModel *model4 = [[ShareBtnModel alloc] initWithTitle:@"新浪微博" image:[UIImage imageNamed:@"新浪微博"]];
        ShareBtnModel *model5 = [[ShareBtnModel alloc] initWithTitle:@"QQ" image:[UIImage imageNamed:@"QQ-(1)"]];
        
        _shareAlertBtns = @[model1, model2, model3, model4, model5];
        
    }
    return _shareAlertBtns;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//        _backBtn.frame = CGRectMake(20, 30, kWidth, kWidth);
        
//        _backBtn.layer.cornerRadius = 3;
//        _backBtn.layer.masksToBounds = YES;
        
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
        _roomNameLabel.font = [UIFont systemFontOfSize:13];
        _roomNameLabel.textAlignment = NSTextAlignmentCenter;
        _roomNameLabel.textColor = [UIColor whiteColor];
    }
    return _roomNameLabel;
}
- (UIButton *)watchLabel {
    if (!_watchLabel) {
        _watchLabel = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_watchLabel setImage:[UIImage imageNamed:@"联系人"] forState:(UIControlStateNormal)];
        _watchLabel.titleLabel.font = [UIFont systemFontOfSize:14];
        [_watchLabel setTitle:@"1000" forState:(UIControlStateNormal)];
        [_watchLabel setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        _watchLabel.enabled = NO;
    }
    return _watchLabel;
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
        UIImage *image = [UIImage imageNamed:@"喜欢icon(点击"];
        

        [_collectBtn setImage:image forState:(UIControlStateNormal)];
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
        [_screenBtn addTarget:self action:@selector(clickScreenBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        

    }
    return _screenBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
