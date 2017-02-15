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

//#import "TalkingViewController.h"

//#import "EaseMessageViewController.h"

#import "ServiceViewController.h"

#import "DogShowViewController.h"

#import "SellerShowViewController.h"

#import <PLPlayerKit/PLPlayerKit.h>

#import "LandscapePlayerToolView.h" // 顶部view

#import "DeletePrommtView.h"

#import "ShareAlertView.h" // 分享
#import "ShareBtnModel.h" // 分享模型
#import "LivingSendMessageView.h" // 编辑弹幕信息

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



//@property(nonatomic, strong) UIButton *danmuBtn; /**< 弹幕按钮 */

@property(nonatomic, strong) UIImageView *showingImg; /**< 展播中的狗图片 */

@property(nonatomic, strong) UILabel *showingPrice; /**< 展播中的狗价钱 */

@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播中图片 */

@property(nonatomic, strong) LandscapePlayerToolView *livetopView; /**< 头部view */

//@property(nonatomic, strong) LivingSendMessageView *sendMessageView; /**< 编辑信息view */

//@property(nonatomic, strong) EaseMessageViewController *talkingVc; /**< 弹窗控制器 */



//@property (nonatomic, strong) EaseMessageViewController *lanceMessageVc; /**< 横屏聊天 */



@property (nonatomic, strong) ServiceViewController *serviceVc; /**< 客服 */



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

// 播放状态

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) UILabel *playAlert; /**< 播放提示 */

@property (nonatomic, assign) CGPoint scrollPoint; /**< 滑动位置 */

@property (nonatomic, strong) UIView *dogShowView; /**< 狗狗展示 */

@property (nonatomic, strong) UIView *endView; /**< 结束 */

@property (nonatomic, strong) UIButton *endbackbutton; /**< 结束返回按钮 */

@property (nonatomic, strong) UILabel *endliveLabel; /**< 结束提示图 */

@property (nonatomic, strong) UILabel *endwatchLabel; /**< 结束观看人数 */

@property (nonatomic, strong) UILabel *endshowCountlabel; /**< 结束展播数 */

@property (nonatomic, strong) UILabel *endsoldCountLabel; /**< 结束出售数 */

@property (nonatomic, strong) NSTimer *stateTimer; /**< 直播状态倒计时 */

@end

@implementation LivingViewController

#pragma mark

#pragma mark - viewcontroller生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 子视图
    
    [self makeSubVcConstraint];
    
    [self getRequestLiveMessage];
    
    // 添加观看观看历史
    
    if ([UserInfos getUser]) {
        
        NSDictionary *dictHistory = @{
                                      
                                      @"id":_liveID,
                                      @"user_id":[UserInfos sharedUser].ID
                                      };
        
        [self getRequestWithPath:API_Add_view_history params:dictHistory success:^(id successJson) {
            
            DLog(@"%@", successJson);
            
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
        
    }else{
        
        NSDictionary *dictHistory = @{
                                      @"id":_liveID
                                      };
        
        [self getRequestWithPath:API_Add_view_history params:dictHistory success:^(id successJson) {
            DLog(@"%@", successJson);
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    // 请求直播
    
    // 设置直播参数
    
    self.roomNameLabel.text = _liverName;
    
    [self.watchLabel setTitle:_watchCount forState:(UIControlStateNormal)];
    
    [self.livetopView.watchCount setTitle:_watchCount forState:(UIControlStateNormal)];
   
    // 设置navigationBar的透明效果
    
    [self.navigationController.navigationBar setAlpha:0];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.hidesBottomBarWhenPushed = YES;
    self.stateTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getRequestLiveStatus) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController.navigationBar setAlpha:1];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    // 取消横屏
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        
        [self forceOrientation:UIInterfaceOrientationPortrait];
        
    }
    
    // 停止播放
    
    [self.livePlayer pause];
    // 删除会话
    
    [[EMClient sharedClient].chatManager deleteConversation:_chatRoomID isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
        
    }];
//    [self.stateTimer invalidate];
//    self.stateTimer = nil;

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
        
        // 设置直播展示的狗
        
        if (self.rootModel.info.count > 0) {
            
            [self.livePlayer.playerView addSubview:self.showingImg];
            
            [self.livePlayer.playerView addSubview:self.showingPrice];
            
            [self.showingImg remakeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.view.centerY);
                
                make.right.equalTo(self.view.right).offset(-10);
                
                make.size.equalTo(CGSizeMake(30, 30));
                
            }];
            
            
            
            [self.showingPrice remakeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self.showingImg.centerX);
                
                make.top.equalTo(self.showingImg.bottom).offset(10);
                
            }];
            
            
            
            ShowIngDogModel *showDogModel = self.rootModel.info[0];
            
            if (showDogModel.pathSmall != NULL) {
                
                NSString *imgStr = [IMAGE_HOST stringByAppendingString:showDogModel.pathSmall];
                
                [self.showingImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"组-7"]];
                
            }
            
            self.showingPrice.text = showDogModel.price;
            
            self.endshowCountlabel.text = [NSString stringWithFormat:@"展播 %ld", self.rootModel.info.count];
            
        }else{
            
            self.endshowCountlabel.text = [NSString stringWithFormat:@"展播 0"];
            
            self.endsoldCountLabel.text = [NSString stringWithFormat:@"出售 0"];
            
        }
        
        
        
    } error:^(NSError *error) {
        
        DLog(@"%@", error);
        
    }];
    
}

// 实现 <PLPlayerDelegate> 来控制流状态的变更

- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    
    // 除了 Error 状态，其他状态都会回调这个方法
    
    // 主播停止播放
    
    if (state == PLPlayerStateAutoReconnecting) {
        
        self.notePlayer.hidden = NO;
        
        self.notePlayer.text = @"重连中..";
        
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
        self.endView.hidden = NO;
    }else{
        self.notePlayer.hidden = YES;
        self.endView.hidden = YES;
    }
    
    DLog(@"%@", error);
}

// 直播状态

- (void)getRequestLiveStatus{
    
    NSDictionary *dict = @{
                           @"live_id":_liveID
                           };
    
    [self getRequestWithPath:API_Live_status params:dict success:^(id successJson) {
        
        DLog(@"%@", successJson);
        if ([successJson[@"code"] integerValue] == 2) {
            // 被禁止原因
            self.endliveLabel.text = successJson[@"data"][@"con"];
            self.endView.hidden = NO;
            // 结束推流
            [self.stateTimer invalidate];
            self.stateTimer = nil;
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
    // 直播人数
    [self getRequestWithPath:API_live_view params:dict success:^(id successJson) {
        
        DLog(@"%@", successJson);
        if (successJson[@"data"]) {
            NSString *watchCount = successJson[@"data"];
            [self.watchLabel setTitle:watchCount forState:(UIControlStateNormal)];
            [self.livetopView.watchCount setTitle:watchCount forState:(UIControlStateNormal)];
            self.endwatchLabel.text = [NSString stringWithFormat:@"观看人数 %@", watchCount];
        }else{
            [self.watchLabel setTitle:@"0" forState:(UIControlStateNormal)];
            [self.livetopView.watchCount setTitle:@"0" forState:(UIControlStateNormal)];
            self.endwatchLabel.text = [NSString stringWithFormat:@"观看人数 0"];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
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
    
    
    
    //    [self addChildViewController:self.lanceMessageVc];
    
    //    [self.livePlayer.playerView addSubview:self.lanceMessageVc.view];
    
    //    [self.livePlayer.playerView addSubview:self.sendMessageView];
    
    //    [self.livePlayer.playerView addSubview:self.danmuBtn];
    // 播放控件约束
    [self makeLiveSubviewConstraint];
    
    // 添加结束时控制器
    [self addEndView];
}
// 竖屏播放控件约束
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
    
    //    self.danmuBtn.hidden = YES;
    
    //    self.sendMessageView.hidden = YES;
    
    self.showingImg.hidden = YES;
    
    self.showingPrice.hidden = YES;
    
    //    self.lanceMessageVc.view.hidden = YES;
    
    
    
    [self.livePlayerView remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.view);
        
        make.height.equalTo(245);
        
    }];
    
    [self.livePlayer.playerView remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(self.livePlayerView);
        
        make.height.equalTo(245);
        
    }];
    
    [self.backBtn remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.livePlayer.playerView.left);
        
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
        
        make.size.equalTo(CGSizeMake(26, 26));
        
    }];
    
    [self.reportBtn remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.backBtn.centerY);
        
        make.right.equalTo(self.shareBtn.left).offset(-10);
        
        make.size.equalTo(CGSizeMake(26, 26));
        
    }];
    
    [self.collectBtn remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.shareBtn.centerX);
        
        make.top.equalTo(self.shareBtn.bottom).offset(10);
        
        make.size.equalTo(CGSizeMake(26, 26));
        
    }];
    
    
    
    [self.watchLabel remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.backBtn.left);
        
        make.bottom.equalTo(self.livePlayer.playerView.bottom).offset(-10);
        
        make.width.equalTo(70);
        
    }];
    
    [self.screenBtn remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.shareBtn.centerX);
        
        make.bottom.equalTo(self.livePlayer.playerView.bottom).offset(-10);
        
        make.size.equalTo(CGSizeMake(26, 26));
        
    }];
    
    [self.notePlayer remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.livePlayer.playerView.centerX);
        
        make.top.equalTo(self.livePlayer.playerView.top).offset(50);
        
    }];
    
}

#pragma mark
#pragma mark - 直播全屏
// 横屏约束

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
    
    //    self.danmuBtn.hidden = NO;
    
    //    self.sendMessageView.hidden = NO;
    
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
    
    //    self.lanceMessageVc.view.hidden = NO;
    
    
    
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
    
    
    
    //    [self.danmuBtn remakeConstraints:^(MASConstraintMaker *make) {
    
    //        make.left.equalTo(self.view.left).offset(12);
    
    //        make.bottom.equalTo(self.view.bottom).offset(-15);
    
    //        make.size.equalTo(CGSizeMake(26, 26));
    
    //    }];
    
    
    
    //    [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
    
    //        make.centerY.equalTo(self.danmuBtn.centerY);
    
    //        make.left.bottom.right.equalTo(self.view);
    
    //        make.height.equalTo(45);
    
    //    }];
    
    //    [self.lanceMessageVc.view remakeConstraints:^(MASConstraintMaker *make) {
    
    //        make.left.equalTo(self.view.left);
    
    //        make.top.equalTo(self.view.top).offset(110);
    
    //        make.bottom.equalTo(self.sendMessageView.bottom);
    
    //        make.width.equalTo(250);
    
    //    }];
    
    
    
    [self.notePlayer remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.livePlayer.playerView.centerX);
        
        make.top.equalTo(self.livePlayer.playerView.top).offset(150);
        
    }];
    
}
//- (EaseMessageViewController *)lanceMessageVc {

//    if (!_lanceMessageVc) {

//        _lanceMessageVc = [[EaseMessageViewController alloc] initWithConversationChatter:_chatRoomID conversationType:(EMConversationTypeChatRoom)];

//        //        [[EMClient sharedClient].roomManager joinChatroom:_chatRoomID completion:^(EMChatroom *aChatroom, EMError *aError) {

//        //            DLog(@"%@", aError);

//        //        }];

//        _lanceMessageVc.view.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];

////        _lanceMessageVc.ishidText = YES;

////        _lanceMessageVc.isNotification = NO;

//        _lanceMessageVc.view.hidden = YES;

//        _lanceMessageVc.chatToolbar.hidden = YES;

////        _lanceMessageVc.roomID = _chatRoomID;

//    }

//    return _lanceMessageVc;

//}



#pragma mark

#pragma mark - Action

- (void)clickBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.stateTimer invalidate];
    self.stateTimer = nil;

    // 取消横屏
    
}

- (void)clickReportBtnAction {
    
    
    
    // 举报
    
    DeletePrommtView *report = [[DeletePrommtView alloc] init];
    
    report.message = @"确定举报该用户";
    
    report.sureBlock = ^(UIButton *btn){
        
        DLog(@"举报");
        
        
        
        NSDictionary * dict = @{
                                
                                @"id":self.liverId,
                                
                                @"live_id":_liveID,
                                
                                @"user_id":[UserInfos sharedUser].ID
                                
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

- (void)clickScreenBtnAction:(UIButton *)btn {
    
    if (btn.selected) { // 转竖屏
        
        [self forceOrientationPriate];
        
    }else { // 转横屏
        
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
        
        _livePlayerView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        
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
        
        [_backBtn setContentMode:(UIViewContentModeCenter)];
        
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
        
        [_reportBtn setContentMode:(UIViewContentModeCenter)];
        
        
        
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
        
        [_shareBtn setContentMode:(UIViewContentModeCenter)];
        
        
        
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
        
        [_collectBtn setContentMode:(UIViewContentModeCenter)];
        
        
        
        [_collectBtn setImage:image forState:(UIControlStateNormal)];
        
        [_collectBtn setImage:[UIImage imageNamed:@"喜欢点击"] forState:(UIControlStateSelected)];
        
        [_collectBtn addTarget:self action:@selector(clickCollectBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
        
        
    }
    
    return _collectBtn;
    
}

- (UIButton *)screenBtn {
    
    if (!_screenBtn) {
        
        _screenBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        
        
        _screenBtn.layer.cornerRadius = 3;
        
        _screenBtn.layer.masksToBounds = YES;
        
        
        
        _screenBtn.backgroundColor = [[UIColor colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5];
        
        _screenBtn.frame = CGRectMake((SCREEN_WIDTH - kWidth - 10), 215, kWidth, kWidth);
        
        [_screenBtn setContentMode:(UIViewContentModeCenter)];
        
        
        
        [_screenBtn setImage:[UIImage imageNamed:@"缩小"] forState:(UIControlStateNormal)];
        
        [_screenBtn addTarget:self action:@selector(clickScreenBtnAction:) forControlEvents:(UIControlEventTouchDown)];
        
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
    
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        
        self.livetopView.hidden = !self.livetopView.hidden;
        
        self.livingImageView.hidden = !self.livetopView.hidden;
        
        self.watchLabel.hidden = !self.livetopView.hidden;
        
    }
    
}

//- (void)clickDanmuAction:(UIButton *)btn {

//    btn.selected = !btn.selected;

//    self.lanceMessageVc.view.hidden = btn.selected;

//    self.sendMessageView.hidden = btn.selected;

//}

//- (UIButton *)danmuBtn {

//    if (!_danmuBtn) {

//        _danmuBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];

//        [_danmuBtn setImage:[UIImage imageNamed:@"弹幕"] forState:(UIControlStateNormal)];

//        [_danmuBtn setImage:[UIImage imageNamed:@"禁止弹幕"] forState:(UIControlStateSelected)];

//        _danmuBtn.hidden = YES;

//        [_danmuBtn addTarget:self action:@selector(clickDanmuAction:) forControlEvents:(UIControlEventTouchDown)];

//    }

//    return _danmuBtn;

//}



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
            
            [weakSelf forceOrientationPriate];
            
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



//- (LivingSendMessageView *)sendMessageView {

//    if (!_sendMessageView) {

//        _sendMessageView = [[LivingSendMessageView alloc] init];

//        _sendMessageView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];

//        _sendMessageView.hidden = YES;

//        __weak typeof(self) weakSelf = self;

//        _sendMessageView.sendBlock = ^(NSString *text){

//            if (text.length != 0) {

////                [weakSelf.lanceMessageVc sendTextMessage:text];

//

//                // 消息发送

//                EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:text];

//                NSString *from = [[EMClient sharedClient] currentUsername];

//                //生成Message

//                EMMessage *message = [[EMMessage alloc] initWithConversationID:weakSelf.chatRoomID from:from to:weakSelf.chatRoomID body:body ext:nil];

//                message.chatType = EMChatTypeChatRoom;

//                [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {

//                    DLog(@"%@", error);

//                }];

//            }

//        };

//    }

//    return _sendMessageView;

//}

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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.isLandscape = NO;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        
        [invocation setSelector:selector];
        
        [invocation setTarget:[UIDevice currentDevice]];
        
        int val = UIInterfaceOrientationPortrait;
        
        [invocation setArgument:&val atIndex:2];
        
        [invocation invoke];
        
    }
    
}

// 竖屏转横屏

- (void)forceOrientationLandscapeRight {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.isLandscape = YES;
    
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
        
        make.left.right.bottom.equalTo(self.view);
        
    }];
    
    // 子控制器
    
    [self addChildViewControllers];
    
}

- (NSMutableArray *)childVCS {
    
    if (!_childVCS) {
        
        _childVCS = [NSMutableArray array];
        
    }
    
    return _childVCS;
    
}

- (void)addChildViewControllers {
    
    
    
    //    EaseMessageViewController *talkVc = [[EaseMessageViewController alloc] initWithConversationChatter:_chatRoomID conversationType:(EMConversationTypeChatRoom)];
    
    //    talkVc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290);
    
    ////    talkVc.isNotification = YES;
    
    //    [self.baseScrollView addSubview:talkVc.view];
    
    //    [self addChildViewController:talkVc];
    
    //    [self.childVCS addObject:talkVc];
    
    
    
    // 狗狗
    
    DogShowViewController *dogShowVC = [[DogShowViewController alloc] init];
    
    dogShowVC.liverIcon = self.liverIcon;
    
    dogShowVC.liverName = self.liverName;
    
    dogShowVC.liverID = _liverId;
    dogShowVC.liveid = _liveID;
    dogShowVC.dogInfos = self.doginfos;
    
    dogShowVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290);
    
    [self.baseScrollView addSubview:dogShowVC.view];
    
    [self.childVCS addObject:dogShowVC];
    
    [self addChildViewController:dogShowVC];
    
    
    
    if (_liverId.length == 0) {
        
        _liverId = @"";
        
    }
    
    // 客服
    
    ServiceViewController *serviceVC = [[ServiceViewController alloc] initWithConversationChatter:_liverId conversationType:(EMConversationTypeChat)];
    
    serviceVC.liverImgUrl = _liverIcon;
    
    serviceVC.liverName = _liverName;
    
    serviceVC.view.frame = CGRectMake(SCREEN_WIDTH * 1, 0, SCREEN_WIDTH , SCREEN_HEIGHT - 290);
    
    self.serviceVc = serviceVC;
    
    [self.baseScrollView addSubview:serviceVC.view];
    
    [self.childVCS addObject:serviceVC];
    
    [self addChildViewController:serviceVC];
    
    
    
    // 商家
    
    SellerShowViewController *sellerShowVC = [[SellerShowViewController alloc] init];
    
    sellerShowVC.liverIcon = _liverIcon;
    
    sellerShowVC.liverName = _liverName;
    
    sellerShowVC.authorId = _liverId;
    
    sellerShowVC.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290);
    
    [self.baseScrollView addSubview:sellerShowVC.view];
    
    [self.childVCS addObject:sellerShowVC];
    
    [self addChildViewController:sellerShowVC];
    
    
    
    _baseScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childVCS.count, 0);
    
    
    
    // 进入后第一次加载hot
    
    self.baseScrollView.contentOffset = CGPointMake(0, 0);
    
    [self scrollViewDidEndDecelerating:self.baseScrollView];
    
}

#pragma mark
#pragma mark - scrollview代理

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 每个子控制器的宽高
    
    CGFloat width = self.view.frame.size.width;
    
    // 偏移量 - x
    
    CGFloat offset = scrollView.contentOffset.x;
  
    // 限制位置
    if (offset < 0.5 * width) {
        offset = 0;
    }else if (offset >= 0.5 * width && offset < 1.5 * width){
        offset = width;
    }else if (offset >= 1.5 * width ){
        offset = 2 * width;
    }
    self.scrollPoint = CGPointMake(offset, 0);

    // 获取视图的索引
    
    NSInteger index = offset / width;
    
    //根据索引返回vc的引用
    
    UIViewController *childVC = self.childVCS[index];
    
    
    
    // 判断当前vc是否加载过
    
    if ([childVC isViewLoaded]) {
        
        return;
        
    };
    
    
    
#pragma mark - 隐藏键盘
    
    // 如果屏幕转动，让输入框隐藏
    
    //    [self.talkingVc.textField resignFirstResponder];
    
    [self.serviceVc.textField resignFirstResponder];
}

// 减速结束时调用 加载子控制器view的方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    
    // 传的调用这个代理方法的scrollview
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}

- (UIScrollView *)baseScrollView {
    
    if (!_baseScrollView) {
        
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 290, SCREEN_WIDTH, SCREEN_HEIGHT - 290)];
        
        _baseScrollView.scrollEnabled = NO;
        
        _baseScrollView.pagingEnabled = YES;
        
        _baseScrollView.showsVerticalScrollIndicator = NO;
        
        // 将子控制器的view 加载到MainVC的ScrollView上  这里用的是加载时的屏幕宽
        
        
        
        // 设置scroll初始偏移量
        
        [_baseScrollView setScrollIndicatorInsets:UIEdgeInsetsMake(0, -1, 0, 0)];
        
        // 减速结束加载控制器视图 代理
        
        _baseScrollView.delegate = self;
        
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
            
            CGPoint center = CGPointMake(0 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            
            
            
            return YES;
            
        };
        
        _centerView.serviceBlock = ^(UIButton *btn){
            
            CGPoint center = CGPointMake(1 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            
            return YES;
            
        };
        
        _centerView.sellerBlock = ^(UIButton *btn){
            
            CGPoint center = CGPointMake(2 * SCREEN_WIDTH, weakSelf.baseScrollView.contentOffset.y);
            
            
            
            [weakSelf.baseScrollView setContentOffset:center animated:YES];
            
            return YES;
            
        };
        
    }
    
    return _centerView;
    
}

- (NSArray *)childTitles {
    
    if (!_childTitles) {
        
        //        _childTitles = @[@"聊天", @"狗狗", @"客服", @"认证商家"];
        
        _childTitles = @[@"狗狗", @"客服", @"认证商家"];
        
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
    
}

- (void)removeKeyboardFocus {
    
    // 注销键盘通知
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    
    //键盘高度
    
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat h = keyBoardFrame.size.height;
    
    
    
    //    [UIView animateWithDuration:0.3 animations:^{
    
    //        [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
    
    //            make.bottom.equalTo(self.view.bottom).offset(-h);
    
    //            make.left.right.equalTo(self.view);
    
    //            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    
    //        }];
    
    //    }];
    
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    
    //    [UIView animateWithDuration:0.3 animations:^{
    
    //        [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
    
    //            make.bottom.equalTo(self.view.bottom);
    
    //            make.left.right.equalTo(self.view);
    
    //            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    
    //        }];
    
    //    }];
    
}

- (BOOL)shouldAutorotate {
    
    return YES;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
    
}

// 代理方法监听屏幕方向
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    
    
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        
        DLog(@"进入横屏");
        _screenBtn.selected = YES;
        
        //            self.talkingVc.chatToolbar.hidden = NO;
        [self makeliveLancseConstraint];
        self.baseScrollView.hidden = YES;
        self.centerView.hidden = YES;
        [self focusKeyboardShow];
        
    }else {
        
        DLog(@"进入竖屏");
        // 取消横屏
        _screenBtn.selected = NO;
        self.baseScrollView.hidden = NO;
        [self.baseScrollView setContentOffset:self.scrollPoint];
        self.centerView.hidden = NO;

        //        self.talkingVc.chatToolbar.hidden = YES;
        [self removeKeyboardFocus];
        [self makeLiveSubviewConstraint];
    }
}

#pragma mark
#pragma mark - 结束时的控件

- (UIView *)endView {
    
    if (!_endView) {
        
        _endView = [[UIView alloc] init];
        
        _endView.hidden = YES;
        
        _endView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        
    }
    
    return _endView;
    
}

- (UILabel *)endliveLabel {
    
    if (!_endliveLabel) {
        
        _endliveLabel = [[UILabel alloc] init];
        
        _endliveLabel.text = @"直播已经结束";
        
        _endliveLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        
        _endliveLabel.font = [UIFont systemFontOfSize:16];
        
    }
    
    return _endliveLabel;
    
}

- (UILabel *)endwatchLabel {
    
    if (!_endwatchLabel) {
        
        _endwatchLabel = [[UILabel alloc] init];
        
        _endwatchLabel.text = @"观看人数 0";
        
        _endwatchLabel.font = [UIFont systemFontOfSize:14];
        
        _endwatchLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        
    }
    
    return _endwatchLabel;
    
}

- (UILabel *)endshowCountlabel {
    
    if (!_endshowCountlabel) {
        
        _endshowCountlabel = [[UILabel alloc] init];
        
        _endshowCountlabel.text = @"展播 0";
        
        _endshowCountlabel.font = [UIFont systemFontOfSize:14];
        
        _endshowCountlabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        
    }
    
    return _endshowCountlabel;
    
}

- (UILabel *)endsoldCountLabel {
    
    if (!_endsoldCountLabel) {
        
        _endsoldCountLabel = [[UILabel alloc] init];
        
        _endsoldCountLabel.text = @"售出 0";
        
        _endsoldCountLabel.font = [UIFont systemFontOfSize:14];
        
        _endsoldCountLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        
    }
    
    return _endsoldCountLabel;
    
}

- (UIButton *)endbackbutton {
    
    if (!_endbackbutton) {
        
        _endbackbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_endbackbutton setTitle:@"返回首页" forState:(UIControlStateNormal)];
        
        _endbackbutton.tintColor = [UIColor colorWithHexString:@"#ffffff"];
        
        _endbackbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _endbackbutton.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        [_endbackbutton addTarget:self action:@selector(clickEndBackAction) forControlEvents:(UIControlEventTouchDown)];
        
    }
    
    return _endbackbutton;
    
}

- (void)clickEndBackAction {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    [self.stateTimer invalidate];
    self.stateTimer = nil;
    
}

/** 添加结束的view */

- (void)addEndView {
    
    [self.view addSubview:self.endView];
    
    [self.view insertSubview:self.endView atIndex:1000];
    
    [self.endView addSubview:self.endliveLabel];
    
    [self.endView addSubview:self.endshowCountlabel];
    
    [self.endView addSubview:self.endsoldCountLabel];
    
    [self.endView addSubview:self.endwatchLabel];
    
    [self.endView addSubview:self.endbackbutton];
    
    
    
    [self.endView remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.livePlayerView.top);
        
        make.left.equalTo(self.livePlayerView.left);
        
        make.bottom.equalTo(self.livePlayerView.bottom);
        
        make.right.equalTo(self.livePlayerView.right);
        
    }];
    
    [self.endliveLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.endView.centerX);
        
        make.top.equalTo(self.endView.top).offset(100);
        
    }];
    
    [self.endshowCountlabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.endView.centerX).offset(-10);
        
        make.top.equalTo(self.endliveLabel.bottom).offset(10);
        
    }];
    
    [self.endsoldCountLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.endView.centerX).offset(10);
        
        make.top.equalTo(self.endliveLabel.bottom).offset(10);
        
    }];
    
    [self.endwatchLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.endView.centerX);
        make.top.equalTo(self.endshowCountlabel.bottom).offset(10);
    }];

    self.endbackbutton.layer.masksToBounds = YES;
    self.endbackbutton.layer.cornerRadius = 10;
    [self.endbackbutton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.endView.centerX);
        make.top.equalTo(self.endwatchLabel.bottom).offset(10);
        make.width.equalTo(SCREEN_WIDTH / 3);
    }];
}

@end

