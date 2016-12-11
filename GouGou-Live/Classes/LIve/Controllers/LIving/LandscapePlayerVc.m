//
//  LandscapePlayerVc.m
//  GouGou-Live
//
//  Created by Huimor on 16/12/10.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LandscapePlayerVc.h"

#import "LandscapePlayerToolView.h" // 顶部view
#import "LivingSendMessageView.h" // 编辑信息

#import "TalkingViewController.h" // 弹幕
#import "ShareAlertView.h" // 分享
#import "ShareBtnModel.h" // 分享模型

#import <PLPlayerKit/PLPlayerKit.h>

@interface LandscapePlayerVc ()<PLPlayerDelegate>

@property (nonatomic, strong) PLPlayer *player;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property(nonatomic, strong) UIButton *danmuBtn; /**< 弹幕按钮 */

@property(nonatomic, strong) UIImageView *showingImg; /**< 展播中的狗图片 */

@property(nonatomic, strong) UILabel *showingPrice; /**< 展播中的狗价钱 */

@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播中图片 */

@property(nonatomic, strong) UIButton *watchCount; /**< 观看人数 */

@property(nonatomic, strong) LandscapePlayerToolView *topView; /**< 头部view */

@property(nonatomic, strong) LivingSendMessageView *sendMessageView; /**< 编辑信息view */

@property(nonatomic, strong) TalkingViewController *talkingVc; /**< 弹窗控制器 */

@property(nonatomic, strong) NSArray *shareAlertBtns; /**< 分享按钮数组 */

@end

@implementation LandscapePlayerVc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 设置navigationBar的透明效果
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.hidesBottomBarWhenPushed = YES;
    // 进入后横屏
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait) {
        [self forceOrientation:(UIInterfaceOrientationLandscapeRight)];
    }
    [self playerLiveMedia];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    // 取消横屏
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [self forceOrientation:UIInterfaceOrientationPortrait];
    }
    [self.player stop];
}
// 切换横竖屏
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置播放view
//    [self playerLiveMedia];
}
// 设置播放画面
- (void)playerLiveMedia {
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
   
    // 设置约束
//    [self.view remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
//    }];
    [self.player.playerView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self initUI];
}
// 设置Ui
- (void)initUI {
    
    [self.player.playerView addSubview:self.topView];
    //    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //    [window addSubview:self.danmuBtn];
    [self.player.playerView addSubview:self.livingImageView];
    [self.player.playerView addSubview:self.watchCount];
    [self addChildViewController:self.talkingVc];
    [self.player.playerView addSubview:self.talkingVc.view];
    [self.player.playerView addSubview:self.showingImg];
    [self.player.playerView addSubview:self.showingPrice];
    [self.player.playerView addSubview:self.sendMessageView];
    [self.player.playerView addSubview:self.danmuBtn];
    
    [self makeConstraint];
}
// 约束
- (void)makeConstraint {
    [self.topView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top);
        make.right.equalTo(self.view.right);
        make.height.equalTo(64);
    }];
    [self.livingImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).offset(10);
    }];
    [self.watchCount remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.livingImageView.centerY);
        make.left.equalTo(self.livingImageView.right).offset(10);
        make.width.equalTo(100);
    }];
    
    [self.talkingVc.view remakeConstraints:^(MASConstraintMaker *make) {
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
}

#pragma mark
#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.livingImageView.hidden = !self.livingImageView.hidden;
    self.watchCount.hidden = !self.watchCount.hidden;
    self.topView.hidden = !self.topView.hidden;
}
- (void)clickDanmuAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    self.talkingVc.view.hidden = btn.selected;
    self.sendMessageView.hidden = btn.selected;
}
- (void)clickLivingDogAction {
}
#pragma mark
#pragma mark - 懒加载
- (UIButton *)danmuBtn {
    if (!_danmuBtn) {
        _danmuBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_danmuBtn setImage:[UIImage imageNamed:@"弹幕"] forState:(UIControlStateNormal)];
        [_danmuBtn setImage:[UIImage imageNamed:@"禁止弹幕"] forState:(UIControlStateSelected)];
        [_danmuBtn addTarget:self action:@selector(clickDanmuAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _danmuBtn;
}
- (UIImageView *)livingImageView {
    if (!_livingImageView) {
        _livingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"直播中"]];
    }
    return _livingImageView;
}
- (UIButton *)watchCount {
    if (!_watchCount) {
        _watchCount = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_watchCount setImage:[UIImage imageNamed:@"联系人"] forState:(UIControlStateNormal)];
        _watchCount.titleLabel.font = [UIFont systemFontOfSize:14];
        [_watchCount setTitle:@"1000" forState:(UIControlStateNormal)];
        [_watchCount setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        _watchCount.enabled = NO;
    }
    return _watchCount;
}
- (LandscapePlayerToolView *)topView {
    if (!_topView) {
        _topView = [[LandscapePlayerToolView alloc] init];
        _topView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        _topView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _topView.backBlcok = ^(){
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        _topView.shareBlcok = ^(UIButton *btn){
            __block ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, weakSelf.view.bounds.size.height - 150, weakSelf.view.bounds.size.width, 150) alertModels:weakSelf.shareAlertBtns tapView:^(NSInteger btnTag) {
                
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
            } colCount:5];
            if (shareAlert.isDismiss) {
                btn.selected = NO;
            }else{
                btn.selected = YES;
            }
            [shareAlert show];
            shareAlert.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        };
        // 收藏
        _topView.collectBlcok = ^(){
            
        };
        // 举报
        _topView.reportBlcok = ^(){
            
        };

    }
    return _topView;
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

- (LivingSendMessageView *)sendMessageView {
    if (!_sendMessageView) {
        _sendMessageView = [[LivingSendMessageView alloc] init];
        _sendMessageView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
    }
    return _sendMessageView;
}

- (TalkingViewController *)talkingVc {
    if (!_talkingVc) {
        _talkingVc = [[TalkingViewController alloc] init];
        _talkingVc.view.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        _talkingVc.isHidText = YES;
    }
    return _talkingVc;
}
- (UILabel *)showingPrice {
    if (!_showingPrice) {
        _showingPrice = [[UILabel alloc] init];
        _showingPrice.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _showingPrice.font = [UIFont systemFontOfSize:14];
        _showingPrice.text = @"1000";
    }
    return _showingPrice;
}

- (UIImageView *)showingImg {
    if (!_showingImg) {
        _showingImg = [[UIImageView alloc] init];
        _showingImg.image = [UIImage imageNamed:@"组-7"];
        _showingImg.layer.cornerRadius = 15;
        _showingImg.layer.masksToBounds = YES;
    }
    return _showingImg;
}
// 切换前后摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}

- (void)swapFrontAndBackCameras {
    // Assume the session is already running
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
