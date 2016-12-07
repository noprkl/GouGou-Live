//
//  MediaStreamingVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/6.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MediaStreamingVc.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@interface MediaStreamingVc ()<PLMediaStreamingSessionDelegate, PLRTCStreamingSessionDelegate>

@property (nonatomic, strong) PLCameraStreamingSession *session;

@end

@implementation MediaStreamingVc
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
    
    // 出去的时候销毁session
    [self.session destroy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.session.previewView];
    
    [self.session startWithFeedback:^(PLStreamStartStateFeedback feedback) {
        DLog(@"%lu", feedback);
    }];
//    self.session.stream = [];
}
- (PLCameraStreamingSession *)session {
    if (!_session) {
        
        PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
        PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
        PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
        PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
        PLStream *stream = [PLStream streamWithJSON:nil];
        
        _session = [[PLCameraStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:stream];
        
    }
    
    return _session;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
