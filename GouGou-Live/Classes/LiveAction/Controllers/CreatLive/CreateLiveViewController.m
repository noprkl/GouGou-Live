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
#import "AddShowDogImgView.h"
#import "MediaStreamingVc.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import "HTTPTool.h"
#import <CoreLocation/CoreLocation.h>

#import "AddDogShowController.h"
#import "SellerMyGoodsModel.h"
#import "NSString+MD5Code.h"

#import "LiveListRootModel.h"
#import "LiveListRespModel.h"
#import "LiveListStreamModel.h"
#import "LiveRootStreamModel.h"
#import "CreateLiveViewController+ThirdShare.h"
#import "TalkingViewController.h"

@interface CreateLiveViewController ()<UITextFieldDelegate,PLMediaStreamingSessionDelegate, PLRTCStreamingSessionDelegate, CLLocationManagerDelegate>
{
    CGFloat W;//图片view高度
}
// 直播采集视图
@property (nonatomic, strong) PLCameraStreamingSession *session;

@property (weak, nonatomic) IBOutlet UITextField *editNameText; /**< 名字编辑 */
@property (weak, nonatomic) IBOutlet UILabel *noteLabel; /**< 提示 */
@property (weak, nonatomic) IBOutlet UIButton *sellORBtn; /**< 是否出售按钮 */
@property (weak, nonatomic) IBOutlet UILabel *cityLabel; /**< 城市 */
@property(nonatomic, strong) CLLocationManager *manager; /**< 定位 */

@property(nonatomic, assign) BOOL isFirstUpdate; /**< 是否第一时间更新 */

@property(nonatomic, strong) AddShowDogImgView *photoView; /**< 上传图片 */

@property (strong, nonatomic) UIView *lineView; /**< 横线 */

@property (strong, nonatomic) UILabel *shareLabel; /**< 分享到 */

@property(nonatomic, strong) UIButton *SinaShareBtn; /**< 微博 */

@property(nonatomic, strong) UIButton *friendShareBtn; /**< 朋友圈 */

@property(nonatomic, strong) UIButton *WXShareBtn; /**< 微信 */

@property(nonatomic, strong) UIButton *QQShareBtn; /**< QQ */

@property(nonatomic, strong) UIButton *TencentShareBtn; /**< 空间 */

@property(nonatomic, strong) UIButton *beginLiveBtn; /**< 开始直播 */

@property(nonatomic, strong) NSMutableArray *photoUrl; /**< 图片地址 */


@property (nonatomic, strong) UIButton *lastBtn; /**< 上一个按钮 */

@end

@implementation CreateLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 定位
    [self findCurrentLocation];
    
    self.navigationController.navigationBarHidden = YES;
    // 设置navigationBar的透明效果
    [self.navigationController.navigationBar setAlpha:0];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];

    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLiveShowDog:) name:@"AddLiveShowDog" object:nil];
}
// 添加展播狗狗图片
- (void)addLiveShowDog:(NSNotification *)notification {
    NSArray *arr = notification.userInfo[@"AddLiveShowDog"];
    DLog(@"%@", arr);
//    if (self.photoUrl.count == 0) {
//        [self.photoUrl addObjectsFromArray:arr];
//    }else{
//        for (SellerMyGoodsModel *selectModel in self.photoUrl) {
//            // 相同id不能添加
//            for (SellerMyGoodsModel *model in arr) {
//                if ([selectModel.ID isEqualToString:model.ID]) {
//                    [self.photoUrl removeObject:model];
//                }
//            }
//        }
//        [self.photoUrl addObjectsFromArray:arr];
//    }
    [self.photoUrl removeAllObjects];
    [self.photoUrl addObjectsFromArray:arr];
    DLog(@"%@", self.photoUrl);
    self.photoView.dataArr = self.photoUrl;
    [self.sellORBtn setTitle:[NSString stringWithFormat:@"出售(%ld)", self.photoUrl.count] forState:(UIControlStateNormal)];
    [self.photoView.collectionView reloadData];
    [self makeConstraint];
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
- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    // 1
    if (![CLLocationManager locationServicesEnabled]) {
        [self showAlert:@"未定位服务"];
        self.cityLabel.text = @"";
    }
    // 2
    else if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
        [self.manager startUpdatingLocation];
    }
    // 3
    else {
        [self.manager requestAlwaysAuthorization];
        [self.manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (self.isFirstUpdate) {
        // 4
        self.isFirstUpdate = NO;
        return;
    }
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    // 编码 获得城市
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (! error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                
                // 获取城市
                NSString *city = placemark.locality;
                if (! city) {
                    // 6
                    city = placemark.administrativeArea;
                }
                self.cityLabel.text = city;
            } else if ([placemarks count] == 0) {
                [self showAlert:@"GPS定位失败"];
            }
        } else {
            [self showAlert:@"网络错误,请检查网络"];
        }
    }];
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}
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
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    btn.selected = YES;

}
// 微信分享
- (void)ClickWXShareAction:(UIButton *)btn{
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    btn.selected = YES;
}
// QQ分享
- (void)ClickQQShareAction:(UIButton *)btn{
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    btn.selected = YES;
}
// 空间分享
- (void)ClickTencentShareAction:(UIButton *)btn{
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    btn.selected = YES;
}
// 朋友圈分享
- (void)ClickFriendShareAction:(UIButton *)btn{
    self.lastBtn.selected = NO;
    self.lastBtn = btn;
    btn.selected = YES;
}
// 开始直播
- (void)ClickBeginLiveBtnAction:(UIButton *)btn{
    // 创建聊天室
//    POST 'https:/a1.easemob.com/easemob-demo/chatdemoui/chatrooms' -H 'Authorization: Bearer YWMtP_8IisA-EeK-a5cNq4Jt3QAAAT7fI10IbPuKdRxUTjA9CNiZMnQIgk0LEUE' -d '{"name":"testchatroom","description":"server create chatroom","owner":"jma1","maxusers":300,"members":["ceshia"]}'
//    NSDictionary *dict = @{@"name":self.editNameText.text,
//                           @"description":@"server create chatroom",
//                           @"owner":[UserInfos sharedUser].ID,
//                           @"maxusers":@(5000),
//                           };
//    DLog(@"%@", dict);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [self postRequestWithPath:@"gougoulive/chatrooms" params:dict success:^(id successJson) {
//        DLog(@"%@", successJson);
//    } error:^(NSError *error) {
//        DLog(@"%@", error);
//    }];
//    
//    [[AFHTTPSessionManager manager] POST:@"https://a1.easemob.com/1161161023178138/gougoulive/chatrooms" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        DLog(@"%@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"%@", error);
//    }];
    if (self.editNameText.text.length == 0) {
        [self showAlert:@"请输入房间名"];
    }else{
        // 商品id
        NSString *idStr = @"";
        if (self.photoUrl.count != 0) {
            NSMutableArray *idMutableArr = [NSMutableArray array];
            
            for (SellerMyGoodsModel *model in self.photoUrl) {
                [idMutableArr addObject:model.ID];
            }
            idStr = [idMutableArr componentsJoinedByString:@"|"];
        }
        
        // 时间戳+卖家id MD5
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYYMMddHHmmss";
        NSString *liveId = [NSString md5WithString:[NSString stringWithFormat:@"%@%@",[formatter stringFromDate:date], [UserInfos sharedUser].ID]];
        
        NSInteger count = self.photoUrl.count;
        NSDictionary *liveDict = @{
                                   @"product_id":idStr,
                                   @"live_id":liveId,
                                   @"p_num":@(count),
                                   @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                   @"area":self.cityLabel.text,
                                   @"name":self.editNameText.text
                                   };
        
        DLog(@"%@", liveDict);
        
        [self postRequestWithPath:API_Live_product params:liveDict success:^(id successJson) {
            DLog(@"%@", successJson);
            if ([successJson[@"message"] isEqualToString:@"添加成功"]) {
                LiveRootStreamModel *rootModel = [LiveRootStreamModel mj_objectWithKeyValues:successJson[@"data"][@"live"]];
                LiveListRespModel *respModel = [LiveListRespModel mj_objectWithKeyValues:rootModel.resp];
                LiveListStreamModel *streamModel = [LiveListStreamModel mj_objectWithKeyValues:rootModel.steam];
                DLog(@"%@---%@", respModel, streamModel);
                // 流对象属性
                DLog(@"%@", streamModel.publish);
                // 创建流对象
                PLStream *stream = [PLStream streamWithJSON:nil];
                stream.streamID = liveId;
                stream.title = self.editNameText.text;
                stream.hubName = respModel.hub;
                stream.disabled = respModel.disabledTill;
                stream.profiles = @[];
                [stream.hosts setValue:streamModel.publish forKey:@"publish"];
                [stream.hosts setValue:streamModel.rtmp forKey:@"rtmp"];
                // 跳转到直播页
                MediaStreamingVc *streamVc = [[MediaStreamingVc alloc] init];
                
                streamVc.stream = stream;
                streamVc.streamPublish = streamModel.publish;
                streamVc.liveID = liveId;
                NSString *chatRoom = successJson[@"data"][@"chatroom"][@"data"][@"id"];
                streamVc.chatRoomID = chatRoom;
                streamVc.hidesBottomBarWhenPushed = YES;
                streamVc.streamRtmp = streamModel.rtmp;
                NSInteger tag = self.lastBtn.tag;
               
#pragma mark
#pragma mark - 跳到群聊
                TalkingViewController *talkVc = [[TalkingViewController alloc] initWithConversationChatter:chatRoom conversationType:(EMConversationTypeChatRoom)];
                talkVc.liverid = [UserInfos sharedUser].ID;
                talkVc.roomID = chatRoom;
                talkVc.isNotification = YES;
                talkVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:talkVc animated:YES];
                
                [self.navigationController pushViewController:streamVc animated:YES];
//                DLog(@"%@", streamModel.rtmp);
//                if (tag == 900) {
//                    [CreateLiveViewController SinaShare:streamModel.rtmp success:^{
//                        [self.navigationController pushViewController:streamVc animated:YES];
//                    }];
//                    
//                }else if (tag == 901){
//                    [CreateLiveViewController WChatShare:streamModel.rtmp success:^{
//                        [self.navigationController pushViewController:streamVc animated:YES];
//                    }];
//
//                }else if (tag == 902){
//                    [CreateLiveViewController QQShare:streamModel.rtmp success:^{
//                        [self.navigationController pushViewController:streamVc animated:YES];
//                    }];
//
//                }else if (tag == 903){
//                    [CreateLiveViewController TencentShare:streamModel.rtmp success:^{
//                        [self.navigationController pushViewController:streamVc animated:YES];
//                    }];
//
//                }else if (tag == 904){
//                    [CreateLiveViewController WechatTimeShare:streamModel.rtmp success:^{
//                        [self.navigationController pushViewController:streamVc animated:YES];
//                    }];
//                }
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
#pragma mark
#pragma mark - 懒加载

- (NSMutableArray *)photoUrl {
    if (!_photoUrl) {
        _photoUrl = [NSMutableArray array];
    }
    return _photoUrl;
}
- (CLLocationManager *)manager {
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    return _manager;
}
- (AddShowDogImgView *)photoView {
    if (!_photoView) {
    
        _photoView = [[AddShowDogImgView alloc] initWithFrame:CGRectZero];
        _photoView.maxCount = ImgCount;
        _photoView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _photoView.addBlock = ^(){
            AddDogShowController *addVc = [[AddDogShowController alloc] init];
            addVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:addVc animated:YES];
        };
        _photoView.deleImg = ^(){
            [weakSelf makeConstraint];
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
        [_QQShareBtn setImage:[UIImage imageNamed:@"QQ-(1)"] forState:(UIControlStateSelected)];
        _QQShareBtn.tag = 902;
        [_QQShareBtn addTarget:self action:@selector(ClickQQShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _QQShareBtn;
}
- (UIButton *)WXShareBtn {
    if (!_WXShareBtn) {
        _WXShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_WXShareBtn setImage:[UIImage imageNamed:@"微信未点击"] forState:(UIControlStateNormal)];
        [_WXShareBtn setImage:[UIImage imageNamed:@"微信select"] forState:(UIControlStateSelected)];
        _WXShareBtn.tag = 901;

        [_WXShareBtn addTarget:self action:@selector(ClickWXShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _WXShareBtn;
}
- (UIButton *)SinaShareBtn {
    if (!_SinaShareBtn) {
        _SinaShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_SinaShareBtn setImage:[UIImage imageNamed:@"weibo_btn"] forState:(UIControlStateNormal)];
        [_SinaShareBtn setImage:[UIImage imageNamed:@"新浪微博"] forState:(UIControlStateSelected)];
        _SinaShareBtn.tag = 900;
        _SinaShareBtn.selected = YES;
        [_SinaShareBtn addTarget:self action:@selector(ClickSinaShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _SinaShareBtn;
}
- (UIButton *)TencentShareBtn {
    if (!_TencentShareBtn) {
        _TencentShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_TencentShareBtn setImage:[UIImage imageNamed:@"空间"] forState:(UIControlStateNormal)];
        [_TencentShareBtn setImage:[UIImage imageNamed:@"QQ空间"] forState:(UIControlStateSelected)];
        _TencentShareBtn.tag = 903;

        [_TencentShareBtn addTarget:self action:@selector(ClickTencentShareAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _TencentShareBtn;
}
- (UIButton *)friendShareBtn {
    if (!_friendShareBtn) {
        _friendShareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_friendShareBtn setImage:[UIImage imageNamed:@"朋友圈"] forState:(UIControlStateNormal)];
        [_friendShareBtn setImage:[UIImage imageNamed:@"朋友圈selected"] forState:(UIControlStateSelected)];
        _friendShareBtn.tag = 904;

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
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddLiveShowDog" object:nil];
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
