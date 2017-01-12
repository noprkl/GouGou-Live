//
//  FavoriteLivePlayerVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FavoriteLivePlayerVc.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerBackTopView.h"
#import "PlayerBackDownView.h"
#import "AppDelegate.h"
@interface FavoriteLivePlayerVc ()
{
    BOOL _isSliding; // 是否正在滑动
    NSTimer *_timer;
    id _playTimeObserver; // 观察者
}

@property (strong, nonatomic) UIView *playerView;

@property (nonatomic, strong) AVPlayerItem *playerItem; /**<  */
@property (nonatomic, strong) AVPlayerLayer *playerLayer; /**<  */
@property (nonatomic, strong) AVPlayer *player; /**<  */

@property (strong, nonatomic) PlayerBackTopView *topView;
@property (strong, nonatomic) UILabel *liveTitleLabel;
@property (strong, nonatomic) UIButton *backBtn;


@property (strong, nonatomic) PlayerBackDownView *downView;
@property (strong, nonatomic) UISlider *progressSlider;
@property (strong, nonatomic) UILabel *beginTimeLabel;
@property (strong, nonatomic) UILabel *endTimeLabel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIButton *playBtn;
@property (strong, nonatomic) UIButton *screenBtn;

// 播放状态
@property (nonatomic, assign) BOOL isPlaying;
// 播放完毕
@property (nonatomic, assign) BOOL isFinish;

@property (nonatomic, strong) NSString *playBackURL; /**< 回放地址 */

@property (nonatomic, strong) UILabel *playAlert; /**< 播放提示 */

@end

@implementation FavoriteLivePlayerVc
- (void)getRequestPlayBackURL {
    NSDictionary *dict = @{@"live_id":_liveID};
    DLog(@"%@", dict);
    [self getRequestWithPath:API_PlayBack params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = successJson[@"data"];
        NSDictionary *info = arr[0];
        self.liveTitleLabel.text = info[@"merchant_name"];
        self.playBackURL = info[@"live"];
        [self updatePlayerWithURL:[NSURL URLWithString:self.playBackURL]];
        [self play];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 进入横屏
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

    [self getRequestPlayBackURL];
    // 设置初始化
    [self initUI];
        // setPortraintLayout
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleDefault) animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 出去竖屏
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
    self.navigationController.navigationBarHidden = NO;

    [self pause];
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
        
        // 设置frame
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark
#pragma mark - Action
- (AVPlayer *)player{
    if (!_player) {
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _isSliding = NO;
//        DLog(@"%@", NSStringFromCGRect(self.playerView.frame));
        _playerLayer.frame = self.view.bounds;
        [self.playerView.layer addSublayer:_playerLayer];
    }
    return _player;
}
- (void)updatePlayerWithURL:(NSURL *)url {
    _playerItem = [AVPlayerItem playerItemWithURL:url]; // create item
    [_player  replaceCurrentItemWithPlayerItem:_playerItem]; // replaceCurrentItem
    [self addObserverAndNotification]; // 添加观察者，发布通知
}

- (void)ClickBackButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ClickRotationAction:(UIButton *)sender {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        [self forceOrientation:UIInterfaceOrientationPortrait];

    }
    if (orientation == UIDeviceOrientationPortrait) {
        [self forceOrientation:(UIInterfaceOrientationLandscapeRight)];
    }
}
- (void)clickPlayOrPauseAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_isPlaying) {
        [self pause];
    } else {
        [self play];
    }
}

- (void)playerSliderTouchDown:(id)sender {
    [self pause];
}

- (void)playerSliderTouchUpInside:(id)sender {
    _isSliding = NO; // 滑动结束
    [self play];
}

// 不要拖拽的时候改变， 手指抬起来后缓冲完成再改变
- (void)playerSliderValueChanged:(id)sender {
    _isSliding = YES;
    [self pause];
    // 跳转到拖拽秒处
    CMTime changedTime = CMTimeMakeWithSeconds(self.progressSlider.value, 1.0);
    DLog(@"%.2f", self.progressSlider.value);
    [_playerItem seekToTime:changedTime completionHandler:^(BOOL finished) {
        // 跳转完成后 继续播放
        [self play];
    }];
}

/**
 *  添加观察者 、通知 、监听播放进度
 */
- (void)addObserverAndNotification {
    [self.playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil]; // 观察status属性， 一共有三种属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil]; // 观察缓冲进度
    [self addNotification]; // 添加通知
}

// 观察播放进度
- (void)monitoringPlayback:(AVPlayerItem *)item {
    __weak typeof(self)WeakSelf = self;
    
    // 播放进度, 每秒执行30次， CMTime 为30分之一秒
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            // 当前播放秒
            float currentPlayTime = (double)item.currentTime.value/ item.currentTime.timescale;
            // 更新slider, 如果正在滑动则不更新
        if (_isSliding == NO) {
            [WeakSelf updateVideoSlider:currentPlayTime];
        }
        _isFinish = NO;
    }];
}

// 更新滑动条
- (void)updateVideoSlider:(float)currentTime {
    self.progressSlider.value = currentTime;
    self.beginTimeLabel.text = [NSString convertTime:currentTime];
}

#pragma mark-
#pragma mark 添加通知
- (void)addNotification {
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playbackFinished:(NSNotification *)notification {
    DLog(@"视频播放完成通知");
    _playerItem = [notification object];
    _isFinish = YES;
    self.playBtn.selected = YES;
}

#pragma mark-
#pragma mark KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
            // 判断status 的 状态
            AVPlayerItemStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
            if (status == AVPlayerStatusReadyToPlay) {
                NSLog(@"准备播放");
                // CMTime 本身是一个结构体
                CMTime duration = item.duration; // 获取视频长度
                NSLog(@"%.2f", CMTimeGetSeconds(duration));
                // 设置视频时间
                [self setMaxDuration:CMTimeGetSeconds(duration)];
                // 播放
                [self play];
                
                [self monitoringPlayback:self.playerItem]; // 监听播放
                self.playAlert.hidden = YES;
            } else if (status == AVPlayerStatusFailed) {
                DLog(@"AVPlayerStatusFailed");
                [self showAlert:@"播放失败"];
                self.playAlert.hidden = NO;
            } else {
                DLog(@"AVPlayerStatusUnknown");
            }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
        CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
        [self.progressView setProgress:timeInterval / totalDuration animated:YES];
    }
}

// 设置最大时间
- (void)setMaxDuration:(CGFloat)duration {
    self.progressSlider.maximumValue = duration; // maxValue = CMGetSecond(item.duration)
    self.endTimeLabel.text = [NSString convertTime:duration];
}

// 已缓冲进度
- (NSTimeInterval)availableDurationRanges {
    NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges]; // 获取item的缓冲数组
    // discussion Returns an NSArray of NSValues containing CMTimeRanges
    
    // CMTimeRange 结构体 start duration 表示起始位置 和 持续时间
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue]; // 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds; // 计算总缓冲时间 = start + duration
    return result;
}

#pragma mark-
#pragma mark 播放 暂停
- (void)play {
    _isPlaying = YES;
    if (_isFinish) {
        [_playerItem seekToTime:kCMTimeZero]; // 跳转到初始
    }
    [self.player play]; // 调用avplayer 的play方法
    DLog(@"播放");
}

- (void)pause {
    _isPlaying = NO;
    [self.player pause];
    DLog(@"暂停");
}
#pragma mark
#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.3 animations:^{
        self.topView.hidden = !self.topView.hidden;
        self.downView.hidden = !self.downView.hidden;
    }];
}

#pragma mark
#pragma mark - UI
- (void)initUI {
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.topView];
    [self.view insertSubview:self.topView atIndex:100];
    [self.topView addSubview:self.backBtn];
    [self.topView addSubview:self.liveTitleLabel];

    [self.view addSubview:self.downView];
    [self.view insertSubview:self.downView atIndex:100];
    [self.downView addSubview:self.playBtn];
    [self.downView addSubview:self.beginTimeLabel];
    [self.downView addSubview:self.progressView];
    [self.progressView addSubview:self.progressSlider];
    [self.downView addSubview:self.endTimeLabel];
    [self.downView addSubview:self.screenBtn];
    [self.playerView addSubview:self.playAlert];
    [self makeConstraints];
}
- (void)makeConstraints {
    [self.playerView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    [self.topView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.playerView);
        make.height.equalTo(34);
    }];
    [self.backBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.centerY);
        make.left.equalTo(self.topView.left).offset(10);
        make.size.equalTo(CGSizeMake(34, 34));
    }];
    [self.liveTitleLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.centerY).offset(0);
        make.left.equalTo(self.topView.left).offset(40);
        make.right.equalTo(self.topView.right).offset(-20);
    }];
    [self.downView remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.playerView);
        make.height.equalTo(44);
    }];
    [self.playBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downView.centerY);
        make.left.equalTo(self.downView.left).offset(0);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    [self.beginTimeLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downView.centerY);
        make.left.equalTo(self.playBtn.right).offset(10);
    }];
    [self.progressView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downView.centerY);
        make.left.equalTo(self.downView.left).offset(90);
        make.right.equalTo(self.downView.right).offset(-90);
    }];
    [self.progressSlider remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downView.centerY);
        make.left.equalTo(self.downView.left).offset(90);
        make.right.equalTo(self.downView.right).offset(-90);
    }];
    [self.screenBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downView.centerY);
        make.right.equalTo(self.downView.right);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    [self.endTimeLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downView.centerY);
        make.right.equalTo(self.downView.right).offset(-40);
    }];
    [self.playAlert remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.playerView.center);
    }];
}
#pragma mark
#pragma mark - 懒加载

- (UIButton *)screenBtn {
    if (!_screenBtn) {
        _screenBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_screenBtn setImage:[UIImage imageNamed:@"缩小"] forState:(UIControlStateNormal)];
        [_screenBtn addTarget:self action:@selector(ClickRotationAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _screenBtn;
}
- (UISlider *)progressSlider {
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        _progressSlider.minimumValue = 0;
        _progressSlider.value = 0;
        [_progressSlider setThumbImage:[UIImage imageNamed:@"椭圆-7"] forState:(UIControlStateNormal)];

        [_progressSlider addTarget:self action:@selector(playerSliderTouchDown:) forControlEvents:(UIControlEventTouchDown)];
        [_progressSlider addTarget:self action:@selector(playerSliderTouchUpInside:) forControlEvents:(UIControlEventTouchUpInside)];
        [_progressSlider addTarget:self action:@selector(playerSliderValueChanged:) forControlEvents:(UIControlEventValueChanged)];

    }
    return _progressSlider;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:(UIProgressViewStyleDefault)];
        _progressView.progress = 0;
    }
    return _progressView;
}
- (UILabel *)endTimeLabel {
    if (!_endTimeLabel) {
        _endTimeLabel = [[UILabel alloc] init];
        _endTimeLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _endTimeLabel.text = @"00:00";
        _endTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _endTimeLabel;
}
- (UILabel *)beginTimeLabel {
    if (!_beginTimeLabel) {
        _beginTimeLabel = [[UILabel alloc] init];
        _beginTimeLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _beginTimeLabel.text = @"00:00";
        _beginTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _beginTimeLabel;
}
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_playBtn setImage:[UIImage imageNamed:@"播放"] forState:(UIControlStateNormal)];
        [_playBtn setImage:[UIImage imageNamed:@"暂停"] forState:(UIControlStateSelected)];

        [_playBtn addTarget:self action:@selector(clickPlayOrPauseAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _playBtn;
}
- (PlayerBackDownView *)downView {
    if (!_downView) {
        _downView = [[PlayerBackDownView alloc] init];
        _downView.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _downView;
}
- (UILabel *)liveTitleLabel {
    if (!_liveTitleLabel) {
        _liveTitleLabel = [[UILabel alloc] init];
        _liveTitleLabel.text = @"标题";
        _liveTitleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _liveTitleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _liveTitleLabel;
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setImage:[UIImage imageNamed:@"返回-拷贝"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(ClickBackButtonAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _backBtn;
}
- (PlayerBackTopView *)topView {
    if (!_topView) {
        _topView = [[PlayerBackTopView alloc] init];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        
    }
    return _topView;
}
- (UIView *)playerView {
    if (!_playerView) {
        _playerView = [[UIView alloc] init];
        _playerView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    }
    return _playerView;
}
- (UILabel *)playAlert {
    if (!_playAlert) {
        _playAlert = [[UILabel alloc] init];
        _playAlert.text = @"播放失败";
        _playAlert.font = [UIFont systemFontOfSize:14];
        _playAlert.hidden = YES;
        _playAlert.tintColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _playAlert;
}
- (void)dealloc {
    [self removeObserveAndNOtification];
    [_player removeTimeObserver:_playTimeObserver]; // 移除playTimeObserver
}

- (void)removeObserveAndNOtification {
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
// 1. 设置样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault; // 黑的
}
// 2. 横屏时显示 statusBar
- (BOOL)prefersStatusBarHidden {
    return NO; // 显示
}

// 3. 设置隐藏动画
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

// 转动
- (BOOL)shouldAutorotate {
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}
// 代理方法监听屏幕方向
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        DLog(@"进入横屏");
        
        _screenBtn.selected = YES;
        //        _playerLayer.frame = self.playerView.frame;
        _playerLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }else {
        DLog(@"进入竖屏");
        // 取消横屏
        _playerLayer.frame = CGRectMake(40, 40, SCREEN_WIDTH - 80, SCREEN_HEIGHT - 80);

    }
}


@end
