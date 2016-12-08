//
//  PlayerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/28.
//  Copyright © 2016年 LXq. All rights reserved.
//  播放界面

#import "PlayerViewController.h"
#import <PLPlayerKit/PLPlayerKit.h>

@interface PlayerViewController () <PLPlayerDelegate>

@property (nonatomic, strong) PLPlayer *player;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initUI];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player stop];
}

- (void)initUI {
    
    // 初始化 PLPlayerOption 对象
    PLPlayerOption *playerOption = [PLPlayerOption defaultOption];
    
    // 更改需要修改的 option 属性键所对应的值
    [playerOption setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [playerOption setOptionValue:@2000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [playerOption setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [playerOption setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [playerOption setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];

    NSURL *url = [NSURL URLWithString:@"RTMPrtmp://pili-live-rtmp.zhuaxingtech.com/gougoulive/mytest"];
    self.player = [PLPlayer playerWithURL:url option:playerOption];
    self.player.delegate = self;
    
    // 添加子视图
    [self.view addSubview:self.player.playerView];
    [self.player play];

}
// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    // 当发生错误时，会回调这个方法
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
