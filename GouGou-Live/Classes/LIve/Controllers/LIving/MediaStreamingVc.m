//
//  MediaStreamingVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/6.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MediaStreamingVc.h"
#import "LivingToolView.h" // 顶部view
//#import "LivingSendMessageView.h" // 编辑信息
#import "LinvingShowDogView.h" // 表格

//#import "TalkingViewController.h" // 弹幕
//#import "EaseMessageViewController.h"
#import "ShareAlertView.h" // 分享
#import "ShareBtnModel.h" // 分享模型
#import "NSString+MD5Code.h"
#import "SellerMyGoodsModel.h"

#import "LiveListRootModel.h"
#import "LiveListRespModel.h"
#import "LiveListStreamModel.h"
#import "LiveRootStreamModel.h"

#import "LiveListDogInfoModel.h"
#import "CreateLiveViewController+ThirdShare.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface MediaStreamingVc ()<PLMediaStreamingSessionDelegate, PLRTCStreamingSessionDelegate, LiveListDogInfoModelDelegate>

@property (nonatomic, strong) PLMediaStreamingSession *session;

@property (nonatomic, strong) AVCaptureSession *captureSession;

//@property(nonatomic, strong) UIButton *danmuBtn; /**< 弹幕按钮 */

@property(nonatomic, strong) UIButton *showingBtn; /**< 展播中的狗按钮 */

@property(nonatomic, strong) UILabel *showingPrice; /**< 展播中的狗价钱 */

@property(nonatomic, strong) UIImageView *livingImageView; /**< 直播中图片 */

@property(nonatomic, strong) UIButton *watchCount; /**< 观看人数 */

@property(nonatomic, strong) LivingToolView *topView; /**< 头部view */

//@property(nonatomic, strong) LivingSendMessageView *sendMessageView; /**< 编辑信息view */

@property (nonatomic, strong) UITextField *sendText; /**< 文本框 */

@property(nonatomic, strong) LinvingShowDogView *showDogView; /**< 展示狗狗 */

//@property(nonatomic, strong) TalkingViewController *talkingVc; /**< 弹窗控制器 */
//@property(nonatomic, strong) EaseMessageViewController *talkingVc; /**< 弹窗控制器 */
@property(nonatomic, strong) NSArray *shareAlertBtns; /**< 分享按钮数组 */

@property (nonatomic, strong) NSTimer *timer; /**< 计时器 */

@property (nonatomic, strong) UIView *endView; /**< 结束 */
@property (nonatomic, strong) UIButton *endbackbutton; /**< 结束返回按钮 */
@property (nonatomic, strong) UILabel *endliveLabel; /**< 结束提示图 */
@property (nonatomic, strong) UILabel *endwatchLabel; /**< 结束观看人数 */
@property (nonatomic, strong) UILabel *endshowCountlabel; /**< 结束展播数 */
@property (nonatomic, strong) UILabel *endsoldCountLabel; /**< 结束出售数 */

@end

@implementation MediaStreamingVc

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
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

    [self getRequestShowingDog];
    [self streamingVideo];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
    
    // 出去的时候销毁session
    [self.session destroy];

    // 取消横屏
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

  // 离开聊天室
    [[EMClient sharedClient].roomManager leaveChatroom:_chatRoomID completion:^(EMChatroom *aChatroom, EMError *aError) {
        DLog(@"%@", aError);
    }];
    // 释放、停止定时器
    [self.timer invalidate];
    self.timer = nil;
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
// 切横屏
- (void)forwardInvocationLandscapeRight {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    // 分享

    if (self.shareType == 10) {
        
    }else if (self.shareType == 0){
        [CreateLiveViewController SinaShare:self.streamRtmp success:^{
            [self forwardInvocationLandscapeRight];
        }];
    }else if (self.shareType == 1){
        [CreateLiveViewController WChatShare:self.streamRtmp success:^{
            [self forwardInvocationLandscapeRight];
        }];
    }else if (self.shareType == 2){
        [CreateLiveViewController QQShare:self.streamRtmp success:^{
            [self forwardInvocationLandscapeRight];

        }];
    }else if (self.shareType == 3){
        [CreateLiveViewController TencentShare:self.streamRtmp success:^{
            [self forwardInvocationLandscapeRight];

        }];
    }else if (self.shareType == 4){
        [CreateLiveViewController WechatTimeShare:self.streamRtmp success:^{
            [self forwardInvocationLandscapeRight];

        }];
    }
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
    videoStreamingConfiguration.videoSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    PLStream *stream = _stream;
    DLog(@"%@", stream);
    // 设置音频推流参数
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    _session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:_stream];
    // 自动重连
    _session.autoReconnectEnable = YES;
    [self.session startStreamingWithPushURL:[NSURL URLWithString:_streamPublish] feedback:^(PLStreamStartStateFeedback feedback) {
        DLog(@"%ld", feedback);
        if (feedback == 0) { // 开始推流
           
        }
    }];
    
    [self.view addSubview:self.session.previewView];
    [self.session.previewView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.session.delegate = self;
    [self initUI];
    // 开始请求
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getRequestWatchCount) userInfo:nil repeats:YES];
}
// 观看人数
- (void)getRequestWatchCount {
    NSDictionary *dict = @{
                           @"live_id":_liveID
                           };
    [self getRequestWithPath:API_live_view params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson[@"data"]) {
            NSString *watchCount = successJson[@"data"];
            [self.watchCount setTitle:watchCount forState:(UIControlStateNormal)];
            self.topView.watchPeople = watchCount;
            self.endwatchLabel.text = [NSString stringWithFormat:@"观看人数 %@", watchCount];
        }else{
            [self.watchCount setTitle:@"0" forState:(UIControlStateNormal)];
            self.topView.watchPeople = @"0";
            self.endwatchLabel.text = [NSString stringWithFormat:@"观看人数 0"];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    // 直播状态
    [self getRequestLiveState];
}
// 出售的狗
- (void)getRequestShowingDog {
    NSDictionary *dict = @{
                           @"live_id":_liveID
                           };
    [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson[@"data"]) {
            NSArray *dogArr = [LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            self.showDogView.dataArr = dogArr;
            LiveListDogInfoModel *showingModel = dogArr[0];
            if (showingModel.pathSmall != NULL) {
                NSURL *url = [NSURL URLWithString:[IMAGE_HOST stringByAppendingString:showingModel.pathSmall]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                [self.showingBtn setImage:image forState:(UIControlStateNormal)];
            }
            self.showingPrice.text = showingModel.price;
            [self.showDogView reloadData];
            self.endshowCountlabel.text = [NSString stringWithFormat:@"展播 %ld", dogArr.count];
        }else{
            self.showDogView.hidden = YES;
            self.showingBtn.hidden = YES;
            self.showingPrice.hidden = YES;
            self.endshowCountlabel.text = [NSString stringWithFormat:@"展播 0"];
            self.endsoldCountLabel.text = [NSString stringWithFormat:@"出售 0"];
        }
    } error:^(NSError *error) {
        
    }];
}
// 直播状态(直播被禁 )
- (void)getRequestLiveState{
    NSDictionary *dict = @{
                           @"live_id":_liveID
                           };
    [self getRequestWithPath:API_Live_status params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"code"] integerValue] == 0) {// 被关闭
            // 被禁止原因
            self.endliveLabel.text = successJson[@"data"][@"con"];
            self.endView.hidden = NO;
            // 结束推流
            [self.session stopStreaming];
            // 销毁
//            [self.session destroy];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 推流代理
// 正常断开、连接
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session streamStateDidChange:(PLStreamState)state {
    // 正常断开推流
    if (state == PLStreamStateDisconnected) {
        // 保存视频
        self.endView.hidden = NO;
//        NSDictionary *dict =@{
//                              @"live_id":_liveID,
//                              @"user_id":[UserInfos sharedUser].ID
//                              };
//        [self getRequestWithPath:API_save params:dict success:^(id successJson) {
//            DLog(@"%@", successJson);
//        } error:^(NSError *error) {
//            DLog(@"%@", error);
//        }];
    }
    if (state == PLStreamStateConnecting || state == PLStreamStateConnected || state == PLStreamStateDisconnecting || state == PLStreamStateAutoReconnecting) {
        self.endView.hidden = YES;
    }
}
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session didDisconnectWithError:(NSError *)error {
    // 非正常断开的情况
    // 重连
    if (session.streamState == PLStreamStateError || session.streamState == PLStreamStateDisconnected) {
        // 保存视频
        self.endView.hidden = NO;
//        NSDictionary *dict =@{
//                              @"live_id":_liveID,
//                              @"user_id":[UserInfos sharedUser].ID
//                              };
//        [self getRequestWithPath:API_save params:dict success:^(id successJson) {
//            DLog(@"%@", successJson);
//        } error:^(NSError *error) {
//            DLog(@"%@", error);
//        }];
    }
    if (session.streamState == PLStreamStateConnecting || session.streamState == PLStreamStateConnected || session.streamState == PLStreamStateDisconnecting || session.streamState == PLStreamStateAutoReconnecting) {
        self.endView.hidden = YES;
    }
}
//开始推流时，会每间隔 3s 调用该回调方法来反馈该 3s 内的流状态，包括视频帧率、音频帧率、音视频总码率
- (void)mediaStreamingSession:(PLMediaStreamingSession *)session streamStatusDidUpdate:(PLStreamStatus *)status {
    // 出错状态 或者已经断开状态 保存视频
    if (session.streamState == PLStreamStateError || session.streamState == PLStreamStateDisconnected) {
        // 保存视频
//        NSDictionary *dict =@{
//                              @"live_id":_liveID,
//                              @"user_id":[UserInfos sharedUser].ID
//                              };
//        [self getRequestWithPath:API_save params:dict success:^(id successJson) {
//            DLog(@"%@", successJson);
//        } error:^(NSError *error) {
//            DLog(@"%@", error);
//        }];
        self.endView.hidden = NO;
    }
    if (session.streamState == PLStreamStateConnecting || session.streamState == PLStreamStateConnected || session.streamState == PLStreamStateDisconnecting || session.streamState == PLStreamStateAutoReconnecting) {
        self.endView.hidden = YES;
    }
}
// 设置Ui
- (void)initUI {

    [self.session.previewView addSubview:self.topView];
    [self.session.previewView addSubview:self.livingImageView];
    [self.session.previewView addSubview:self.watchCount];
//    [self addChildViewController:self.talkingVc];
//    [self.session.previewView addSubview:self.talkingVc.view];
    [self.session.previewView addSubview:self.showingBtn];
    [self.session.previewView addSubview:self.showingPrice];
    
    [self.view addSubview:self.showDogView];
    [self.view insertSubview:self.showDogView atIndex:100];
//    [self.session.previewView addSubview:self.sendMessageView];
//    [self.session.previewView addSubview:self.danmuBtn];

    [self makeConstraint];
    [self focusKeyboardShow];
    [self addEndView];
    
}
// 约束
- (void)makeConstraint {
    [self.topView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(54);
    }];
    [self.livingImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).offset(20);
    }];
    [self.watchCount remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.livingImageView.centerY);
        make.left.equalTo(self.livingImageView.right).offset(10);
        make.width.equalTo(70);
    }];
//    [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view);
//        make.height.equalTo(50);
//    }];
//    [self.talkingVc.view remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.left);
//        make.top.equalTo(self.view.top).offset(110);
//        make.bottom.equalTo(self.sendMessageView.bottom);
//        make.width.equalTo(250);
//    }];
   
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
        make.top.equalTo(self.topView.bottom).offset(0);
//        make.bottom.equalTo(self.sendMessageView.top);
          make.bottom.equalTo(self.view.bottom);
        make.width.equalTo(250);
    }];
//    [self.danmuBtn remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.left).offset(12);
//        make.bottom.equalTo(self.view.bottom).offset(-12);
//        make.size.equalTo(CGSizeMake(26, 26));
//    }];
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
//    self.talkingVc.view.hidden = btn.selected;
//    self.sendMessageView.hidden = btn.selected;
}
- (void)clickLivingDogAction {
    self.showDogView.hidden = NO;
}
#pragma mark
#pragma mark - 懒加载
//- (UIButton *)danmuBtn {
//    if (!_danmuBtn) {
//        _danmuBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        [_danmuBtn setImage:[UIImage imageNamed:@"弹幕"] forState:(UIControlStateNormal)];
//        [_danmuBtn setImage:[UIImage imageNamed:@"禁止弹幕"] forState:(UIControlStateSelected)];
//        _danmuBtn.selected = YES;
//        [_danmuBtn addTarget:self action:@selector(clickDanmuAction:) forControlEvents:(UIControlEventTouchDown)];
//    }
//    return _danmuBtn;
//}
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
        [_watchCount setTitle:@"0" forState:(UIControlStateNormal)];
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
            weakSelf.endView.hidden = NO;
        };
        _topView.shareBlcok = ^(UIButton *btn){
            __block ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, weakSelf.view.bounds.size.height - 150, weakSelf.view.bounds.size.width, 150) alertModels:weakSelf.shareAlertBtns tapView:^(NSInteger btnTag) {
                
                NSInteger index = btnTag - 20;
                switch (index) {
                    case 0:
                    {
                    // 朋友圈
                    [CreateLiveViewController WechatTimeShare:weakSelf.streamRtmp success:^{
                        [weakSelf forwardInvocationLandscapeRight];
                    }];
                    shareAlert = nil;
                    [shareAlert dismiss];
                    }
                        break;
                    case 1:
                    {
                    // 微信
                    [CreateLiveViewController WChatShare:weakSelf.streamRtmp success:^{
                        [weakSelf forwardInvocationLandscapeRight];
                    }];
                    shareAlert = nil;
                    [shareAlert dismiss];
                    }
                        break;
                    case 2:
                    {
                    // QQ空间

                    [CreateLiveViewController TencentShare:weakSelf.streamRtmp success:^{
                        [weakSelf forwardInvocationLandscapeRight];
                    }];
                    shareAlert = nil;
                    [shareAlert dismiss];
                    }
                        break;
                    case 3:
                    {
                    // 新浪微博
                    [CreateLiveViewController SinaShare:weakSelf.streamRtmp success:^{
                        [weakSelf forwardInvocationLandscapeRight];
                    }];
                    shareAlert = nil;
                    [shareAlert dismiss];
                    }
                        break;
                    case 4:
                    {
                    // QQ
                    [CreateLiveViewController QQShare:weakSelf.streamRtmp success:^{
                        [weakSelf forwardInvocationLandscapeRight];
                    }];
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
        _topView.faceBlcok = ^(){
            // 摄像头前后切换
            [weakSelf.session toggleCamera];
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
        _showDogView.hidden = YES;
        _showDogView.showDelegate = self;
    }
    return _showDogView;
}
#pragma mark
#pragma mark - 代理
- (void)clickShowingDog:(LiveListDogInfoModel *)model {
    // 修改正在展播的狗
    NSDictionary *showDict = @{
                               @"live_id":self.liveID,
                               @"id":model.ID,
                               @"user_id":[UserInfos sharedUser].ID
                               };
    DLog(@"%@", showDict);
    [self getRequestWithPath:API_Live_product_list_weight params:showDict success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
    if (model.pathSmall != NULL) {
        NSURL *url = [NSURL URLWithString:[IMAGE_HOST stringByAppendingString:model.pathSmall]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        [self.showingBtn setImage:image forState:(UIControlStateNormal)];
    }
    self.showingPrice.text = model.price;
}
//- (LivingSendMessageView *)sendMessageView {
//    if (!_sendMessageView) {
//        _sendMessageView = [[LivingSendMessageView alloc] init];
//        _sendMessageView.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
//        _sendMessageView.hidden = YES;
//        __weak typeof(self) weakSelf = self;
//        _sendMessageView.sendBlock = ^(NSString *text){
//            if (![text isEqualToString:@""]) {
//                [weakSelf.talkingVc sendTextMessage:text];
//                // 消息发送
////                EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:text];
////                NSString *from = [[EMClient sharedClient] currentUsername];
////                //生成Message
////                EMMessage *message = [[EMMessage alloc] initWithConversationID:weakSelf.chatRoomID from:from to:weakSelf.chatRoomID body:body ext:nil];
////                message.chatType = EMChatTypeChatRoom;
////                [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
////                    DLog(@"%@", error);
////                }];
//            }
//        };
//    }
//    return _sendMessageView;
//}

//- (EaseMessageViewController *)talkingVc {
//    if (!_talkingVc) {
//        _talkingVc = [[EaseMessageViewController alloc] initWithConversationChatter:_chatRoomID conversationType:(EMConversationTypeChatRoom)];
////        [[EMClient sharedClient].roomManager joinChatroom:_chatRoomID completion:^(EMChatroom *aChatroom, EMError *aError) {
////            DLog(@"%@", aError);
////        }];
//        _talkingVc.view.backgroundColor = [[UIColor colorWithHexString:@"#999999"] colorWithAlphaComponent:0.4];
////        _talkingVc.ishidText = YES;
//        _talkingVc.view.hidden = YES;
//        _talkingVc.chatToolbar.hidden = YES;
////        _talkingVc.roomID = _chatRoomID;
//    }
//    return _talkingVc;
//}
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
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}
- (void)swapFrontAndBackCameras {
    // Assume the session is already running

    NSArray *inputs = self.captureSession.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [self.captureSession beginConfiguration];
            
            [self.captureSession removeInput:input];
            [self.captureSession addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [self.captureSession commitConfiguration];
            break;
        }
    } 
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
    
    //监听是否触发home键挂起程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    //监听是否重新进入程序程序.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
//        [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view.bottom).offset(-h);
//            make.left.right.equalTo(self.view);
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
//        }];
        
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
//        [self.sendMessageView remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view.bottom);
//            make.left.right.equalTo(self.view);
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
//        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
#pragma mark - 导航条颜色
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
#pragma mark - 监听home键
// 触发home按下
- (void)applicationWillResignActive:(NSNotification *)notification {
    [self.session stopCaptureSession];
}
// 重新进来后响应
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    [self forwardInvocationLandscapeRight];
    [self.session startCaptureSession];
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
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
    // 保存视频
    NSDictionary *dict =@{
                          @"live_id":_liveID,
                          @"user_id":[UserInfos sharedUser].ID
                          };
    [self getRequestWithPath:API_save params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    [self.endView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
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
        make.width.equalTo(200);
    }];
}
@end
