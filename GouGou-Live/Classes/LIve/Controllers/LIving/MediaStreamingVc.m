//
//  MediaStreamingVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/6.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MediaStreamingVc.h"
#import "LivingToolView.h" // 顶部view
#import "LivingSendMessageView.h" // 编辑信息
#import "LinvingShowDogView.h" // 表格

#import "TalkingViewController.h" // 弹幕
#import "ShareAlertView.h" // 分享
#import "ShareBtnModel.h" // 分享模型
#import "NSString+MD5Code.h"
#import "SellerMyGoodsModel.h"

#import "LiveListRootModel.h"
#import "LiveListRespModel.h"
#import "LiveListStreamModel.h"
#import "LiveRootStreamModel.h"

@interface MediaStreamingVc ()<PLMediaStreamingSessionDelegate, PLRTCStreamingSessionDelegate>

@property (nonatomic, strong) PLMediaStreamingSession *session;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property(nonatomic, strong) UIButton *danmuBtn; /**< 弹幕按钮 */

@property(nonatomic, strong) UIButton *showingBtn; /**< 展播中的狗按钮 */

@property(nonatomic, strong) UILabel *showingPrice; /**< 展播中的狗价钱 */

@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播中图片 */

@property(nonatomic, strong) UIButton *watchCount; /**< 观看人数 */

@property(nonatomic, strong) LivingToolView *topView; /**< 头部view */

@property(nonatomic, strong) LivingSendMessageView *sendMessageView; /**< 编辑信息view */

@property (nonatomic, strong) UITextField *sendText; /**< 文本框 */

@property(nonatomic, strong) LinvingShowDogView *showDogView; /**< 展示狗狗 */

@property(nonatomic, strong) TalkingViewController *talkingVc; /**< 弹窗控制器 */

@property(nonatomic, strong) NSArray *shareAlertBtns; /**< 分享按钮数组 */

@end

@implementation MediaStreamingVc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    
    // 进入后横屏
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait) {
        [self forceOrientation:(UIInterfaceOrientationLandscapeRight)];
    }
    [self streamingVideo];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
    
    // 出去的时候销毁session
    [self.session destroy];
    // 取消横屏
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        [self forceOrientation:UIInterfaceOrientationPortrait];
    }
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
//    [self streamingVideo];
}
// 设置直播画面
- (void)streamingVideo {
 
    // 设置视频采集的参数
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    // 采集画面是后置摄像头 左横屏
    videoCaptureConfiguration.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    // 采集时画面 默认640
    videoCaptureConfiguration.sessionPreset = AVCaptureSessionPreset640x480;
    // 设置采集音频参数
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    // 采集时声道 默认1
    audioCaptureConfiguration.channelsPerFrame = 5;
    
    // 设置视频推流参数
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLStream *stream = _stream;
    DLog(@"%@", stream);
    // 设置音频推流参数
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    _session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:_stream];
    
    [self.session startStreamingWithPushURL:[NSURL URLWithString:_streamPublish] feedback:^(PLStreamStartStateFeedback feedback) {
        DLog(@"%lu", feedback);
        if (feedback == 0) { // 开始推流
            
        }
    }];
    
    [self.view addSubview:self.session.previewView];
    [self.session.previewView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self initUI];
}
// 设置Ui
- (void)initUI {

    [self.session.previewView addSubview:self.topView];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window addSubview:self.danmuBtn];
    [self.session.previewView addSubview:self.livingImageView];    
    [self.session.previewView addSubview:self.watchCount];
    [self addChildViewController:self.talkingVc];
    [self.session.previewView addSubview:self.talkingVc.view];
    [self.session.previewView addSubview:self.showingBtn];
    [self.session.previewView addSubview:self.showingPrice];
    [self.session.previewView addSubview:self.showDogView];
    [self.session.previewView addSubview:self.sendMessageView];
    [self.session.previewView addSubview:self.danmuBtn];

    [self makeConstraint];
}
// 约束
- (void)makeConstraint {
    [self.topView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(64);
    }];
    [self.livingImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).offset(10);
    }];
    [self.watchCount remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.livingImageView.centerY);
        make.left.equalTo(self.livingImageView.right).offset(10);
        make.width.equalTo(70);
    }];

    [self.talkingVc.view remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.view.top).offset(110);
        make.bottom.equalTo(self.danmuBtn.top).offset(-10);
        make.width.equalTo(270);
    }];
    [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(50);
    }];
    [self.showingBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.centerY);
        make.right.equalTo(self.view.right).offset(-10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    [self.showingPrice remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.showingBtn.centerX);
        make.top.equalTo(self.showingBtn.bottom).offset(10);
    }];
    [self.showDogView remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right);
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.view.bottom);
        make.width.equalTo(270);
    }];
    [self.danmuBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(12);
        make.bottom.equalTo(self.view.bottom).offset(-12);
        make.size.equalTo(CGSizeMake(26, 26));
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
    self.showDogView.hidden = NO;
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
- (LivingToolView *)topView {
    if (!_topView) {
        _topView = [[LivingToolView alloc] init];
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
            if (shareAlert.isDismiss) {
                btn.selected = NO;
            }else{
                btn.selected = YES;
            }
            [shareAlert show];
            shareAlert.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
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
- (LinvingShowDogView *)showDogView {
    if (!_showDogView) {
        _showDogView = [[LinvingShowDogView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _showDogView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
    }
    return _showDogView;
}
- (LivingSendMessageView *)sendMessageView {
    if (!_sendMessageView) {
        _sendMessageView = [[LivingSendMessageView alloc] init];
        _sendMessageView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
        _sendMessageView.textFieldBlock = ^(UITextField *textField){
            
        };
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
- (UIButton *)showingBtn {
    if (!_showingBtn) {
        _showingBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_showingBtn setImage:[UIImage imageNamed:@"组-7"] forState:(UIControlStateNormal)];
        _showingBtn.layer.cornerRadius = 15;
        _showingBtn.layer.masksToBounds = YES;
        [_showingBtn addTarget:self action:@selector(clickLivingDogAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _showingBtn;
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
