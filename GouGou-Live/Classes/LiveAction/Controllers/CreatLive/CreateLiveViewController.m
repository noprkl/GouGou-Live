//
//  CreateLiveViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//
// 最大图片数
#define ImgCount 15

#import "CreateLiveViewController.h"
#import "AddUpdataImagesView.h"
#import "MediaStreamingVc.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@interface CreateLiveViewController ()<UITextFieldDelegate,PLMediaStreamingSessionDelegate, PLRTCStreamingSessionDelegate>
{
    CGFloat W;//图片view高度
}
// 直播采集视图
@property (nonatomic, strong) PLCameraStreamingSession *session;

@property (weak, nonatomic) IBOutlet UITextField *editNameText; /**< 名字编辑 */
@property (weak, nonatomic) IBOutlet UILabel *noteLabel; /**< 提示 */
@property (weak, nonatomic) IBOutlet UIButton *sellORBtn; /**< 是否出售按钮 */
@property (weak, nonatomic) IBOutlet UILabel *cityLabel; /**< 城市 */


@property(nonatomic, strong) AddUpdataImagesView *photoView; /**< 上传图片 */

@property (strong, nonatomic) UIView *lineView; /**< 横线 */

@property (strong, nonatomic) UILabel *shareLabel; /**< 分享到 */

@property(nonatomic, strong) UIButton *SinaShareBtn; /**< 微博 */

@property(nonatomic, strong) UIButton *friendShareBtn; /**< 朋友圈 */

@property(nonatomic, strong) UIButton *WXShareBtn; /**< 微信 */

@property(nonatomic, strong) UIButton *QQShareBtn; /**< QQ */

@property(nonatomic, strong) UIButton *TencentShareBtn; /**< 空间 */

@property(nonatomic, strong) UIButton *beginLiveBtn; /**< 开始直播 */

@property(nonatomic, strong) NSMutableArray *photoArr; /**< 图片数组 */

@property(nonatomic, strong) NSMutableArray *photoUrl; /**< 图片地址 */

@end

@implementation CreateLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    // 设置navigationBar的透明效果
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}
- (void)initUI {
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.photoView];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.shareLabel];
    [self.view addSubview:self.QQShareBtn];
    [self.view addSubview:self.SinaShareBtn];
    [self.view addSubview:self.TencentShareBtn];
    [self.view addSubview:self.WXShareBtn];
    [self.view addSubview:self.friendShareBtn];
    [self.view addSubview:self.beginLiveBtn];

    self.editNameText.delegate = self;
    
    [self makeConstraint];

}
// 约束
- (void)makeConstraint {
    
    if (self.sellORBtn.selected) {
        if (ImgCount <= kMaxImgCount) {
            W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / ImgCount;
        }else{
            W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
        }
        CGFloat row = self.photoView.dataArr.count / kMaxImgCount;
        W = (row + 1) * (W + 10) + 10;
        [self.photoView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sellORBtn.bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.height.equalTo(W + 20);
        }];
        
    }else{
        [self.photoView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sellORBtn.bottom).offset(10);
            make.left.right.equalTo(self.view);
            make.height.equalTo(1);
        }];
    }
    
    [self.lineView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.bottom).offset(10);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(225, 1));
    }];
    [self.shareLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.bottom).offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    [self.QQShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareLabel.bottom).offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];
    [self.friendShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.QQShareBtn.left).offset(-20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.WXShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.friendShareBtn.left).offset(-20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.TencentShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.QQShareBtn.right).offset(20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.SinaShareBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TencentShareBtn.right).offset(20);
        make.centerY.equalTo(self.QQShareBtn.centerY);
    }];
    [self.beginLiveBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.QQShareBtn.bottom).offset(15);
        make.centerX.equalTo(self.view.centerX);
        make.size.equalTo(CGSizeMake(310, 44));
    }];
}
#pragma mark
#pragma mark - Action
- (IBAction)clickSellORBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.photoView.hidden = !sender.selected;
    [self makeConstraint];
}
- (IBAction)clickDeleteBtnAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 微博分享
- (void)ClickSinaShareAction:(UIButton *)btn{
    [self SinaShare];
}
// 微信分享
- (void)ClickWXShareAction:(UIButton *)btn{
    [self WChatShare];
}
// QQ分享
- (void)ClickQQShareAction:(UIButton *)btn{
    
}
// 空间分享
- (void)ClickTencentShareAction:(UIButton *)btn{
    
}
// 朋友圈分享
- (void)ClickFriendShareAction:(UIButton *)btn{
    
}
// 开始直播
- (void)ClickBeginLiveBtnAction:(UIButton *)btn{
    MediaStreamingVc *streamVc = [[MediaStreamingVc alloc] init];
    streamVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:streamVc animated:YES];
//    [self.view addSubview:self.session.previewView];
//    [self.session startWithPushURL:[NSURL URLWithString:@"rtmp://pili-publish.zhuaxingtech.com/gougoulive/php-sdk-test1480995971?e=1481084024&token=NFwFP_3cqha4JuMAtZTp2CdOHAHiglVY3o9X47by:Kx77k1avGKkz9vLp-JoeSvIleik= "] feedback:^(PLStreamStartStateFeedback feedback) {
//        
//    }];
//    [self.session startWithFeedback:^(PLStreamStartStateFeedback feedback) {
//        DLog(@"%lu", feedback);
//    }];
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)photoArr {
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}
- (NSMutableArray *)photoUrl {
    if (!_photoUrl) {
        _photoUrl = [NSMutableArray array];
    }
    return _photoUrl;
}
- (AddUpdataImagesView *)photoView {
    if (!_photoView) {
    
        _photoView = [[AddUpdataImagesView alloc] initWithFrame:CGRectZero];
        _photoView.maxCount = ImgCount;
        _photoView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        __weak typeof(_photoView) weakPhoto = _photoView;
        _photoView.addBlock = ^(){
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    [weakPhoto.dataArr addObject:photos[0]];
                    
                    [weakPhoto.collectionView reloadData];
                    weakSelf.photoArr = weakPhoto.dataArr;
                    [weakSelf makeConstraint];
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
    }
    return _photoView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}
- (UILabel *)shareLabel {
    if (!_shareLabel) {
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.text = @"分享到";
        _shareLabel.font = [UIFont systemFontOfSize:12];
        _shareLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _shareLabel;
    
}
- (UIButton *)QQShareBtn {
    if (!_QQShareBtn) {
        _QQShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_QQShareBtn setImage:[UIImage imageNamed:@"QQgray"] forState:(UIControlStateNormal)];
        [_QQShareBtn addTarget:self action:@selector(ClickQQShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _QQShareBtn;
}
- (UIButton *)WXShareBtn {
    if (!_WXShareBtn) {
        _WXShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_WXShareBtn setImage:[UIImage imageNamed:@"微信未点击"] forState:(UIControlStateNormal)];
        [_WXShareBtn addTarget:self action:@selector(ClickWXShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _WXShareBtn;
}
- (UIButton *)SinaShareBtn {
    if (!_SinaShareBtn) {
        _SinaShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_SinaShareBtn setImage:[UIImage imageNamed:@"weibo_btn"] forState:(UIControlStateNormal)];
        [_SinaShareBtn addTarget:self action:@selector(ClickSinaShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _SinaShareBtn;
}
- (UIButton *)TencentShareBtn {
    if (!_TencentShareBtn) {
        _TencentShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_TencentShareBtn setImage:[UIImage imageNamed:@"空间"] forState:(UIControlStateNormal)];
        [_TencentShareBtn addTarget:self action:@selector(ClickTencentShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _TencentShareBtn;
}
- (UIButton *)friendShareBtn {
    if (!_friendShareBtn) {
        _friendShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_friendShareBtn setImage:[UIImage imageNamed:@"朋友圈"] forState:(UIControlStateNormal)];
        [_friendShareBtn addTarget:self action:@selector(ClickFriendShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _friendShareBtn;
}
- (UIButton *)beginLiveBtn {
    if (!_beginLiveBtn) {
        _beginLiveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_beginLiveBtn setTitle:@"开始直播" forState:(UIControlStateNormal)];
        [_beginLiveBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _beginLiveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _beginLiveBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        _beginLiveBtn.layer.cornerRadius = 9;
        _beginLiveBtn.layer.masksToBounds = YES;
        
        [_beginLiveBtn addTarget:self action:@selector(ClickBeginLiveBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _beginLiveBtn;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location < 12) {
        return YES;
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.noteLabel.hidden = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
   
    if ([textField.text isEqualToString:@""]) {
        self.noteLabel.hidden = NO;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
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
