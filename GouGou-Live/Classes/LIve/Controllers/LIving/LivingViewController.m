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

#import "TalkingViewController.h"
#import "ServiceViewController.h"
#import "DogShowViewController.h"
#import "SellerShowViewController.h"

#import <PLPlayerKit/PLPlayerKit.h>
#import "LandscapePlayerToolView.h" // 顶部view
#import "DeletePrommtView.h"
#import "ShareAlertView.h" // 分享
#import "ShareBtnModel.h" // 分享模型

#import "LivingSendMessageView.h" // 编辑弹幕信息
#import "TalkingViewController.h" // 弹幕控制器
#import "ShowIngDogModel.h"

#import "LiveListDogInfoModel.h"
#import "LiveListRespModel.h"
#import "LiveListStreamModel.h"
#import "LiveListRootModel.h"
#import "LiveRootStreamModel.h"

#import "AppDelegate.h"

@interface LivingViewController ()<UIScrollViewDelegate, PLPlayerDelegate>
// 回放
{
    BOOL _isSliding; // 是否正在滑动
    NSTimer *_timer;
    id _playTimeObserver; // 观察者
}

#pragma mark
#pragma mark - 直播

@property (nonatomic, strong) UIView *livePlayerView; /**< 直播view */

// 播放器
@property (nonatomic, strong) PLPlayer *livePlayer;
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

@property(nonatomic, strong) UIButton *danmuBtn; /**< 弹幕按钮 */
@property(nonatomic, strong) UIImageView *showingImg; /**< 展播中的狗图片 */
@property(nonatomic, strong) UILabel *showingPrice; /**< 展播中的狗价钱 */
@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播中图片 */
@property(nonatomic, strong) LandscapePlayerToolView *livetopView; /**< 头部view */
@property(nonatomic, strong) LivingSendMessageView *sendMessageView; /**< 编辑信息view */
@property(nonatomic, strong) TalkingViewController *talkingVc; /**< 弹窗控制器 */

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

/** 分享按钮 */
@property (strong, nonatomic) NSArray *shareAlertBtns;
@property(nonatomic, strong) UIViewController *lastVC; /**< 上一个控制器 */
@property(nonatomic, strong) UILabel *notePlayer; /**< 播放提示 */
@property(nonatomic, strong) NSArray *liveInfoArr; /**< 直播信息 */
@property(nonatomic, strong) LiveListRootModel *rootModel; /**< 请求数据 */
@property(nonatomic, strong) LiveListStreamModel *stream; /**< 流对象信息 */
@property(nonatomic, strong) LiveListRespModel *resp; /**< 播放信息 */

#pragma mark
#pragma mark - 回放

// 播放状态
@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) UILabel *playAlert; /**< 播放提示 */

@property (nonatomic, assign) CGPoint scrollPoint; /**< 滑动位置 */

@end

@implementation LivingViewController

#pragma mark
#pragma mark - viewcontroller生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // 子视图
    [self makeSubVcConstraint];
    [self getRequestLiveMessage];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    // 请求直播

//    [self LiveInitUI];// 直播UI

//    if (_isLandscape) {//横屏
//        [self forceOrientationLandscapeRight];
//    }
    // 设置直播参数
    self.roomNameLabel.text = _liverName;
    [self.watchLabel setTitle:_watchCount forState:(UIControlStateNormal)];
    
//    [self collectionBtn];
    // 设置navigationBar的透明效果
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.hidesBottomBarWhenPushed = YES;
    
    // 添加观看观看历史
    if ([UserInfos getUser]) {
        NSDictionary *dictHistory = @{
                                      @"id":_liveID,
                                      @"user_id":[UserInfos sharedUser].ID
                                      };
        [self getRequestWithPath:API_Add_view_history params:dictHistory success:^(id successJson) {
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    // 取消横屏
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [self forceOrientation:UIInterfaceOrientationPortrait];
    }
    // 停止播放
    [self.livePlayer pause];
}
#pragma mark
#pragma mark - 直播播放
- (void)getRequestLiveMessage {
    NSDictionary *dict = @{
                           @"live_id":_liveID
                           };
    [self getRequestWithPath:API_Live_product_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.rootModel = [LiveListRootModel mj_objectWithKeyValues:successJson[@"data"]];
        LiveRootStreamModel *rootSteam = [LiveRootStreamModel mj_objectWithKeyValues:self.rootModel.steam];
        LiveListRespModel *resp = [LiveListRespModel mj_objectWithKeyValues:rootSteam.resp];
        self.resp = resp;
        LiveListStreamModel *stream = [LiveListStreamModel mj_objectWithKeyValues:rootSteam.steam];
        self.stream = stream;
        [self LiveInitUI];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
    // 主播停止播放
    if (state == PLPlayerStatusStopped) {
        self.notePlayer.hidden = NO;
        self.notePlayer.text = @"主播已经停止播放";
    }
    // 正常播放状态
    if (state == PLPlayerStatusPlaying) {
        self.notePlayer.hidden = YES;
    }
//    if (state == PLPlayerStatusPlaying) {
//        self.notePlayer.hidden = YES;
//    }
    DLog(@"%@", player);
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误时，会回调这个方法
    // 重连
    [self.livePlayer play];
    if (error) {
        self.notePlayer.hidden = NO;
        self.notePlayer.text = @"出错了";
    }else{
        self.notePlayer.hidden = YES;
    }
    
    DLog(@"%@", error);
}

#pragma mark - 直播UI
- (void)LiveInitUI {
    [self.view addSubview:self.livePlayerView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    // 播放
    [self.livePlayer play];
    
    // 竖屏
    [self.livePlayer.playerView addSubview:self.backBtn];
    [self.livePlayer.playerView addSubview:self.roomNameLabel];
    [self.livePlayer.playerView addSubview:self.reportBtn];
    [self.livePlayer.playerView addSubview:self.shareBtn];
    [self.livePlayer.playerView addSubview:self.collectBtn];
    [self.livePlayer.playerView addSubview:self.watchLabel];
    [self.livePlayer.playerView addSubview:self.screenBtn];
    [self.livePlayer.playerView addSubview:self.notePlayer];
    
    // 全屏
    [self.livePlayer.playerView addSubview:self.livetopView];
    [self.livePlayer.playerView addSubview:self.livingImageView];
    [self.livePlayer.playerView addSubview:self.showingImg];
    [self.livePlayer.playerView addSubview:self.showingPrice];
    [self.livePlayer.playerView addSubview:self.sendMessageView];
    [self.livePlayer.playerView addSubview:self.danmuBtn];
    
    // 播放控件约束
    [self makeLiveSubviewConstraint];
}

// 播放控件约束
- (void)makeLiveSubviewConstraint {
    
    self.backBtn.hidden = NO;
    self.roomNameLabel.hidden = NO;
    self.shareBtn.hidden = NO;
    self.reportBtn.hidden = NO;
    self.collectBtn.hidden = NO;
    self.screenBtn.hidden = NO;
//    self.talkingVc.tableView.hidden = NO;
    
    self.livetopView.hidden = YES;
    self.livingImageView.hidden = YES;
    self.danmuBtn.hidden = YES;
    self.sendMessageView.hidden = YES;
    self.showingImg.hidden = YES;
    self.showingPrice.hidden = YES;
    
    [self.livePlayerView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(245);
    }];
    [self.livePlayer.playerView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.livePlayerView);
        make.height.equalTo(245);
    }];
    [self.backBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.livePlayer.playerView.left).offset(15);
        make.top.equalTo(self.livePlayer.playerView.top).offset(10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [self.roomNameLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.left.equalTo(self.backBtn.right).offset(15);
    }];
    [self.shareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.right.equalTo(self.livePlayer.playerView.right).offset(-10);
    }];
    [self.reportBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.centerY);
        make.right.equalTo(self.shareBtn.left).offset(-10);
    }];
    [self.collectBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn.centerX);
        make.top.equalTo(self.shareBtn.bottom).offset(10);
    }];
    
    [self.watchLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.left);
        make.bottom.equalTo(self.livePlayer.playerView.bottom).offset(-10);
        make.width.equalTo(70);
    }];
    [self.screenBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.shareBtn.centerX);
        make.bottom.equalTo(self.livePlayer.playerView.bottom).offset(-10);
    }];
    [self.notePlayer remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.livePlayer.playerView.centerX);
        make.top.equalTo(self.livePlayer.playerView.top).offset(50);
    }];
}
#pragma mark
#pragma mark - 直播全屏

// 约束
- (void)makeliveLancseConstraint {
    [self.livePlayerView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.livePlayer.playerView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    // 显示
//    self.livetopView.hidden = NO;
    self.livingImageView.hidden = NO;
    self.danmuBtn.hidden = NO;
    self.sendMessageView.hidden = NO;
    if (self.doginfos.count != 0) {
        self.showingImg.hidden = NO;
    }else{
        self.showingImg.hidden = NO;
    }
    if (self.doginfos.count != 0) {
        self.showingPrice.hidden = NO;
    }else{
        self.showingPrice.hidden = NO;
    }
    self.watchLabel.hidden = NO;
    // 隐藏
    self.backBtn.hidden = YES;
    self.roomNameLabel.hidden = YES;
    self.shareBtn.hidden = YES;
    self.reportBtn.hidden = YES;
    self.collectBtn.hidden = YES;
    self.screenBtn.hidden = YES;
    
    [self.livetopView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top);
        make.right.equalTo(self.view.right);
        make.height.equalTo(64);
    }];

    [self.livingImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).offset(20);
    }];
    
    [self.watchLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.livingImageView.centerY);
        make.left.equalTo(self.livingImageView.right).offset(10);
        make.width.equalTo(100);
    }];
    
    [self.talkingVc.tableView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top).offset(110);
        make.bottom.equalTo(self.danmuBtn.top).offset(-10);
        make.width.equalTo(270);
    }];
    [self.danmuBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(12);
        make.bottom.equalTo(self.view.bottom).offset(-15);
        make.size.equalTo(CGSizeMake(26, 26));
    }];
    
    [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.danmuBtn.centerY);
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(45);
    }];

    [self.showingImg remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.centerY);
        make.right.equalTo(self.view.right).offset(-10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];

    [self.showingPrice remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.showingImg.centerX);
        make.top.equalTo(self.showingImg.bottom).offset(10);
    }];
    [self.notePlayer remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.livePlayer.playerView.centerX);
        make.top.equalTo(self.livePlayer.playerView.top).offset(150);
    }];
}

#pragma mark
#pragma mark - Action
- (void)clickBackBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
    // 取消横屏
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
//        [self forceOrientation:UIInterfaceOrientationPortrait];
//    }
}
- (void)clickReportBtnAction {
    
    // 举报
    DeletePrommtView *report = [[DeletePrommtView alloc] init];
    report.message = @"确定举报该用户";
    report.sureBlock = ^(UIButton *btn){
        DLog(@"举报");

        NSDictionary * dict = @{// @([self.liverId intValue])
                                @"id":@([self.liverId integerValue]),
                                @"live_id":_liveID,
                                @"user_id":@([[UserInfos sharedUser].ID intValue])
                                };
        [self getRequestWithPath:API_Report params:dict success:^(id successJson) {
            DLog(@"%@",successJson);
            [self showAlert:successJson[@"message"]];
        } error:^(NSError *error) {
            DLog(@"%@",error);
            
        }];
    };
    [report show];
}
- (void)clickShareBtnAction {
    
    __weak typeof(self) weakSelf = self;
    
    __block ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, self.view.bounds.size.width, 150) alertModels:self.shareAlertBtns tapView:^(NSInteger btnTag) {
        
        NSInteger index = btnTag - 20;
        switch (index) {
            case 0:
            {
                // 朋友圈
                [weakSelf WechatTimeShare];
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
- (void)clickCollectBtnAction:(UIButton *)btn {
    if (btn.selected) { // 如果被选中 删除
        NSDictionary *dict = @{//
                               @"user_id":[UserInfos sharedUser].ID,
                               @"product_id":_liveID,
                               @"type":@(2),
                               @"state":@(2)
                               };
        [self getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            self.isSelectCollectBtn = NO;
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }else{ // 否则添加
        NSDictionary *dict = @{//
                               @"user_id":[UserInfos sharedUser].ID,
                               @"product_id":_liveID ,
                               @"type":@(1),
                               @"state":@(2)
                               };
        [self getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            self.isSelectCollectBtn = YES;
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }

    btn.selected = !btn.selected;
    self.livetopView.collectBtn.selected = btn.selected;
}

- (void)clickScreenButtonAction:(UIButton *)btn {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft | orientation == UIInterfaceOrientationLandscapeRight) { // 转竖屏
        [self forceOrientationPriate];
    }else if (orientation == UIDeviceOrientationPortrait) { // 转横屏
        [self forceOrientationLandscapeRight];
    }
}
// 喜欢状态
- (void)collectionBtn {

    if (self.isSelectCollectBtn) {
        
        [self.collectBtn setImage:[UIImage imageNamed:@"喜欢点击"] forState:UIControlStateSelected];
    } else {
    
        [self.collectBtn setImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    }
}


#pragma mark - 直播控件
- (PLPlayer *)livePlayer {
    if (!_livePlayer) {
        // 初始化 PLPlayerOption 对象
        PLPlayerOption *playerOption = [PLPlayerOption defaultOption];
        // 更改需要修改的 option 属性键所对应的值
        [playerOption setOptionValue:@10 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
        [playerOption setOptionValue:@2000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
        [playerOption setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
        [playerOption setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
        [playerOption setOptionValue:@(kPLLogInfo) forKey:PLPlayerOptionKeyLogLevel];
        
        NSURL *url = [NSURL URLWithString:self.stream.rtmp];
        _livePlayer = [[PLPlayer alloc] initWithURL:url option:playerOption];
        _livePlayer.delegate = self;
        //    [self.livePlayerView addSubview:self.livePlayer.playerView];
        [_livePlayerView insertSubview:self.livePlayer.playerView atIndex:0];
        _livePlayer.playerView.autoresizingMask = UIViewAutoresizingNone;
        
        // 添加播放视图
        [self.view addSubview:_livePlayer.playerView];
    }
    return _livePlayer;
}
- (UIView *)livePlayerView {
    if (!_livePlayerView) {
        _livePlayerView = [[UIView alloc] init];
        _livePlayerView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    return _livePlayerView;
}
- (NSArray *)liveInfoArr {
    if (!_liveInfoArr) {
        _liveInfoArr = [NSArray array];
    }
    return _liveInfoArr;
}
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
        
        [_backBtn setImage:[UIImage imageNamed:@"返回-拷贝"] forState:(UIControlStateNormal)];
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
//        [_watchLabel setTintColor:[UIColor colorWithHexString:@"#ffa11a"]];
        _watchLabel.titleLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
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
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
       
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
        
        _collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _collectBtn.layer.cornerRadius = 3;
        _collectBtn.layer.masksToBounds = YES;

        _collectBtn.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];
        UIImage *image = [UIImage imageNamed:@"喜欢"];

        [_collectBtn setImage:image forState:(UIControlStateNormal)];
        [_collectBtn setImage:[UIImage imageNamed:@"喜欢点击"] forState:(UIControlStateSelected)];
        [_collectBtn addTarget:self action:@selector(clickCollectBtnAction:) forControlEvents:(UIControlEventTouchDown)];

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
        [_screenBtn addTarget:self action:@selector(clickScreenButtonAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _screenBtn;
}
- (UILabel *)notePlayer {
    if (!_notePlayer) {
        _notePlayer = [[UILabel alloc] init];
        _notePlayer.text = @"主播已经离开";
        _notePlayer.hidden = YES;
        _notePlayer.font = [UIFont systemFontOfSize:16];
        _notePlayer.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _notePlayer;
}

#pragma mark  - 直播全屏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        self.livetopView.hidden = !self.livetopView.hidden;
        self.livingImageView.hidden = !self.livetopView.hidden;
        self.watchLabel.hidden = !self.livetopView.hidden;
    }
//    [UIView animateWithDuration:0.3 animations:^{
//        self.topView.hidden = !self.topView.hidden;
//        self.downView.hidden = !self.downView.hidden;
//    }];
    
}
- (void)clickDanmuAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.talkingVc.view.hidden = btn.selected;
    self.sendMessageView.hidden = btn.selected;
}
- (UIButton *)danmuBtn {
    if (!_danmuBtn) {
        _danmuBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_danmuBtn setImage:[UIImage imageNamed:@"弹幕"] forState:(UIControlStateNormal)];
        [_danmuBtn setImage:[UIImage imageNamed:@"禁止弹幕"] forState:(UIControlStateSelected)];
        _danmuBtn.hidden = YES;
        _danmuBtn.selected = YES;
        [_danmuBtn addTarget:self action:@selector(clickDanmuAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _danmuBtn;
}

- (UIImageView *)livingImageView {
    if (!_livingImageView) {
        _livingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"直播中"]];
        _livingImageView.hidden = YES;
    }
    return _livingImageView;
}
- (LandscapePlayerToolView *)livetopView {
    if (!_livetopView) {
        _livetopView = [[LandscapePlayerToolView alloc] init];
        _livetopView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        _livetopView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _livetopView.backBlcok = ^(){
            [weakSelf clickScreenButtonAction:weakSelf.backBtn];
        };
        _livetopView.shareBlcok = ^(UIButton *btn){
            __block ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, weakSelf.view.bounds.size.height - 150, weakSelf.view.bounds.size.width, 150) alertModels:weakSelf.shareAlertBtns tapView:^(NSInteger btnTag) {

                NSInteger index = btnTag - 20;
                switch (index) {
                    case 0:
                    {
                    
                    // 朋友圈
                    [weakSelf WechatTimeShare];
                    
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
            } colCount:5];
            [weakSelf forceOrientationPriate];

            if (shareAlert.isDismiss) {
                btn.selected = NO;
            }else{
                btn.selected = YES;
            }
            [shareAlert show];
            shareAlert.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        };
        // 收藏
        _livetopView.collectBlcok = ^(BOOL isCollection){
            weakSelf.collectBtn.selected = isCollection;
            if (isCollection) { // 如果被选中 删除
                NSDictionary *dict = @{//
                                       @"user_id":[UserInfos sharedUser].ID,
                                       @"product_id":weakSelf.liveID,
                                       @"type":@(2),
                                       @"state":@(2)
                                       };
                [weakSelf getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    [weakSelf showAlert:successJson[@"message"]];
                    weakSelf.isSelectCollectBtn = NO;
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }else{ // 否则添加
                NSDictionary *dict = @{//
                                       @"user_id":[UserInfos sharedUser].ID,
                                       @"product_id":weakSelf.liveID,
                                       @"type":@(1),
                                       @"state":@(2)
                                       };
                [weakSelf getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    [weakSelf showAlert:successJson[@"message"]];
                    weakSelf.isSelectCollectBtn = YES;
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
        };
        // 举报
        _livetopView.reportBlcok = ^(){
            // 举报
            DeletePrommtView *report = [[DeletePrommtView alloc] init];
            report.message = @"确定举报该用户";
            report.sureBlock = ^(UIButton *btn){
                NSDictionary * dict = @{
                                        @"id":weakSelf.liverId,
                                        @"uesr_id":@([[UserInfos sharedUser].ID intValue])
                                        };
                [weakSelf getRequestWithPath:API_Report params:dict success:^(id successJson) {
                    DLog(@"%@",successJson);
                    [weakSelf showAlert:successJson[@"message"]];
                } error:^(NSError *error) {
                    DLog(@"%@",error);
                    
                }];
            };
            [report show];
        };
        
    }
    return _livetopView;
}

- (LivingSendMessageView *)sendMessageView {
    if (!_sendMessageView) {
        _sendMessageView = [[LivingSendMessageView alloc] init];
        _sendMessageView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        _sendMessageView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _sendMessageView.sendBlock = ^(NSString *text){
            if (text.length != 0) {
                [weakSelf.talkingVc sendTextMessage:text];
            }
        };
    }
    return _sendMessageView;
}

- (UILabel *)showingPrice {
    if (!_showingPrice) {
        _showingPrice = [[UILabel alloc] init];
        _showingPrice.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _showingPrice.font = [UIFont systemFontOfSize:14];
        _showingPrice.text = @"1000";
        _showingPrice.hidden = YES;
    }
    return _showingPrice;
}

- (UIImageView *)showingImg {
    if (!_showingImg) {
        _showingImg = [[UIImageView alloc] init];
        _showingImg.image = [UIImage imageNamed:@"组-7"];
        _showingImg.layer.cornerRadius = 15;
        _showingImg.layer.masksToBounds = YES;
        _showingImg.hidden = YES;
    }
    return _showingImg;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
// 横屏转竖屏
- (void)forceOrientationPriate {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    _isLandscape = YES;
    self.baseScrollView.hidden = NO;
    self.centerView.hidden = NO;
   
    [self.talkingVc.tableView removeFromSuperview];
    [self.baseScrollView addSubview:self.talkingVc.view];
    [self.childVCS replaceObjectAtIndex:1 withObject:self.talkingVc];
    [self.baseScrollView setContentOffset:self.scrollPoint animated:YES];
    
//    [self.talkingVc.tableView remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(SCREEN_WIDTH);
//        make.height.equalTo(self.baseScrollView.height);
//        make.top.equalTo(self.baseScrollView.top);
//        make.left.equalTo(self.baseScrollView.left).offset(SCREEN_WIDTH);
//    }];
    [self.talkingVc.view remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(self.baseScrollView.height);
        make.top.equalTo(self.baseScrollView.top);
        make.left.equalTo(self.baseScrollView.left).offset(SCREEN_WIDTH);
    }];

    self.talkingVc.isNotification = YES;

    self.talkingVc.tableView.alpha = 1;
    self.talkingVc.tableView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [self makeLiveSubviewConstraint];
}
// 竖屏转横屏
- (void)forceOrientationLandscapeRight {

    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    [UIViewController attemptRotationToDeviceOrientation];
    _isLandscape = NO;
    
    
    [self.talkingVc.tableView removeFromSuperview];
    [self.livePlayer.playerView addSubview:self.talkingVc.tableView];
    self.talkingVc.isNotification = NO;
    self.talkingVc.tableView.alpha = 0.4;
    self.talkingVc.tableView.backgroundColor = [UIColor colorWithHexString:@"#999999"];

    [self makeliveLancseConstraint];
    self.baseScrollView.hidden = YES;
    self.centerView.hidden = YES;
    [self focusKeyboardShow];
}
// 1. 设置样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent; // 白色的
}
// 2. 横屏时显示 statusBar
- (BOOL)prefersStatusBarHidden {
    return NO; // 显示
}
// 3. 设置隐藏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

#pragma mark
#pragma mark - LiveAction子视图
// 子控制器约束
- (void)makeSubVcConstraint {
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.baseScrollView];
    
    [self.centerView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(245);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 45));
    }];
    
    [self.baseScrollView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.bottom);
        make.left.equalTo(self.view.left);
        make.bottom.equalTo(self.view.bottom);
        make.width.equalTo(SCREEN_WIDTH);
    }];
    // 子控制器
    [self addChildViewControllers];
}
- (NSMutableArray *)childVCS {
    if (!_childVCS) {
        _childVCS = [NSMutableArray array];
        [_childVCS addObject:@"0"];
        [_childVCS addObject:@"1"];
        [_childVCS addObject:@"2"];
        [_childVCS addObject:@"3"];
    }
    return _childVCS;
}
- (void)addChildViewControllers {
    
    // 狗狗
    DogShowViewController *dogShowVC = [[DogShowViewController alloc] init];
    dogShowVC.liverIcon = self.liverIcon;
    dogShowVC.liverName = self.liverName;
    dogShowVC.liverID = _liverId;
    dogShowVC.dogInfos = self.doginfos;
    [self.childVCS replaceObjectAtIndex:0 withObject:dogShowVC];
    [self addChildViewController:dogShowVC];
    
    TalkingViewController *Vc = [[TalkingViewController alloc] initWithConversationChatter:_chatRoomID conversationType:(EMConversationTypeChatRoom)];
    //    [self.baseScrollView addSubview:self.talkingVc.tableView];
    Vc.roomID = _chatRoomID;
    self.talkingVc = Vc;
    [self.childVCS replaceObjectAtIndex:1 withObject:Vc];
    [self addChildViewController:Vc];
    
    if (_liverId.length == 0) {
        _liverId = EaseTest_Liver;
    }
    // 客服
    ServiceViewController *serviceVC = [[ServiceViewController alloc] initWithConversationChatter:_liverId conversationType:(EMConversationTypeChat)];
    serviceVC.liverImgUrl = _liverIcon;
    serviceVC.liverName = _liverName;
    [self.childVCS replaceObjectAtIndex:2 withObject:serviceVC];
    [self addChildViewController:serviceVC];
    // 商家
    SellerShowViewController *sellerShowVC = [[SellerShowViewController alloc] init];
    sellerShowVC.liverIcon = _liverIcon;
    sellerShowVC.liverName = _liverName;
    sellerShowVC.authorId = _liverId;
    [self.childVCS replaceObjectAtIndex:3 withObject:sellerShowVC];
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
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 每个子控制器的宽高
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 290;
    
    // 偏移量 - x
    // 如果是通过点击狗狗卡片进入的,滑到狗狗位置
    //    if (_isDogCard) {
    //        [scrollView setContentOffset:CGPointMake(width, 0)];
    //    }
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取视图的索引
    NSInteger index = offset / width;
    
    //根据索引返回vc的引用
    UIViewController *childVC = self.childVCS[index];

    // 判断当前vc是否加载过
    if ([childVC isViewLoaded]) {
        if(![childVC isKindOfClass:[TalkingViewController class]]) {
            [self.talkingVc.view reloadInputViews];
        }
        return;
    };
    
    // 给没加载过的控制器设置frame
    childVC.view.frame = CGRectMake(offset, 0, width, height);
    DLog(@"%@", NSStringFromCGRect(childVC.view.frame));
    // 添加控制器视图到contentScrollView上
    [scrollView addSubview:childVC.view];
    
#pragma mark - 隐藏键盘
    if ([self.lastVC isKindOfClass:[TalkingViewController class]]) {
        
        self.talkingVc = (TalkingViewController *)self.lastVC;
        
        [self.talkingVc.textField resignFirstResponder];
        
    }else if ([self.lastVC isKindOfClass:NSClassFromString(@"ServiceViewController")]){
        
        ServiceViewController *serviceVC = (ServiceViewController *)self.lastVC;
        
        [serviceVC.textField resignFirstResponder];
    }
    
    self.lastVC = childVC;
    self.scrollPoint = scrollView.contentOffset;
}
// 减速结束时调用 加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 传的调用这个代理方法的scrollview
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
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
            CGPoint center = CGPointMake(1 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            CGPoint center = CGPointMake(0 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
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

// 监听键盘
- (void)focusKeyboardShow {
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
//    //监听是否触发home键挂起程序.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
//                                                 name:UIApplicationWillResignActiveNotification object:nil];
//    //监听是否重新进入程序程序.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
//                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom).offset(-h);
            make.left.right.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
        
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom);
            make.left.right.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}


@end
