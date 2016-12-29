//
//  EditMyMessageViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditMyMessageViewController.h"
#import "DeletePrommtView.h"
#import "ChoseCamearView.h"
#import "EditNikeNameAlert.h"
#import <AFNetworking.h>
#import <TZImagePickerController.h>

@interface EditMyMessageViewController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) UITableView *topTableView; /**< 顶部TableView */

@property(nonatomic, strong) NSArray *topDataArr; /**< 顶部数据源 */

@property(nonatomic, strong) UITableView *bottomTableView; /**< 底部TableView */
@property(nonatomic, strong) NSArray *botttomDataArr; /**< 底部数据源 */

@property(nonatomic, strong) NSMutableArray *accessosys; /**< witch数组 */

@property(nonatomic, strong) EditNikeNameAlert *editAlert; /**< 编辑框 */

@property(nonatomic, strong) UIImagePickerController *imagePicker; /**< 相机 */

@property(nonatomic, strong) UIImageView *userIconView; /**< 用户头像 */

@property(nonatomic, strong) NSMutableArray *detailArr; /**< 数据2 */

@end

static NSString *cellid = @"cellid";

@implementation EditMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}

- (void)initUI {
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    self.edgesForExtendedLayout = 0;
    
    [self.view addSubview:self.topTableView];
    [self.view addSubview:self.bottomTableView];
    [self makeConstraint];
}

- (void)makeConstraint {

    [self.topTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(220);
    }];
    [self.bottomTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(176);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)detailArr {
    if (!_detailArr) {
        NSString *tel = [UserInfos sharedUser].usertel;
        NSString *userImage = @"暂无";
        NSString *userMotto = @"暂无";
        NSString *userNike = @"暂无";
        if ([UserInfos sharedUser].userimgurl != NULL) {
            userImage = [UserInfos sharedUser].userimgurl;
        }
        if ([UserInfos sharedUser].usernickname != NULL) {
            userNike = [UserInfos sharedUser].usernickname;
        }
        if ([UserInfos sharedUser].usermotto != NULL) {
            userMotto = [UserInfos sharedUser].usermotto;
        }
        _detailArr = [[NSMutableArray alloc] initWithObjects:userImage, userNike, userMotto, tel, nil];
        DLog(@"%@", _detailArr);
    }
    return _detailArr;
}

- (NSArray *)topDataArr {
    if (!_topDataArr) {
        _topDataArr = @[@"头像", @"昵称", @"个性签名", @"手机号"];
    }
    return _topDataArr;
}

- (NSArray *)botttomDataArr {
    if (!_botttomDataArr) {
        _botttomDataArr = @[@"微信", @"腾讯", @"新浪"];
    }
    return _botttomDataArr;
}

- (UITableView *)topTableView {
    if (!_topTableView) {
        _topTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
//        [_topTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _topTableView;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        [_bottomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _bottomTableView;
}
- (NSMutableArray *)accessosys {
    if (!_accessosys) {
        _accessosys = [NSMutableArray array];
    }
    return _accessosys;
}

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.allowsEditing = YES;
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.topTableView) {
        return self.topDataArr.count;
    }else if (tableView == self.bottomTableView){
        return self.botttomDataArr.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView == self.topTableView) {
        NSString *cellid2 = @"cellid2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) { // 第1行设置
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            // 头像
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, (88 - 60) / 2, 60, 60)];
            imageView.layer.cornerRadius = 30;
            imageView.layer.masksToBounds = YES;
          
            // 头像url拼接
            NSString *urlString = [IMAGE_HOST stringByAppendingString:self.detailArr[indexPath.row]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];

            self.userIconView = imageView;
            [cell.contentView addSubview:imageView];
            
        }else if (indexPath.row == 1) { // 第2行设置
            cell.textLabel.text = self.topDataArr[indexPath.row];
            cell.detailTextLabel.text = self.detailArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }else if(indexPath.row == 2){ // 第3行设置
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.detailTextLabel.text = self.detailArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) { // 第4行设置
            cell.textLabel.text = self.topDataArr[indexPath.row];
            cell.detailTextLabel.text = [UserInfos sharedUser].usertel;
        }
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
        return cell;
    }else if (tableView == self.bottomTableView){ // 底部tableVIew
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.textLabel.text = self.botttomDataArr[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];

        // 添加开关
        UISwitch *switchBtn = [[UISwitch alloc] init];
        switchBtn.on = NO;
        switchBtn.tag = 50 + indexPath.row;
        if (indexPath.row == 0) {
            if ([UserInfos sharedUser].wxopenid != NULL && [UserInfos sharedUser].wxopenid.length != 0) {
                switchBtn.on = YES;
            }
        }
        if (indexPath.row == 1) {
            if ([UserInfos sharedUser].qqopenid != NULL && [UserInfos sharedUser].qqopenid.length != 0) {
                switchBtn.on = YES;
            }
        }
        if (indexPath.row == 2) {
            if ([UserInfos sharedUser].wbopenid != NULL && [UserInfos sharedUser].wbopenid.length != 0) {
                switchBtn.on = YES;
            }
        }
        [switchBtn addTarget:self action:@selector(clickSwitchAction:) forControlEvents:(UIControlEventValueChanged)];
        cell.accessoryView = switchBtn;
        [self.accessosys addObject:switchBtn];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.topTableView) {
        return 0;
        
    }else if (tableView == self.bottomTableView){
        return 44;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.topTableView) {
        if (indexPath.row == 0) {
            return 88;
        }
        return 44;
    }else if (tableView == self.bottomTableView){
        return 44;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.topTableView) {
        switch (indexPath.row) {
            case 0: // 设置头像
            {
                [self presentCmear];
            }
                break;
            
            case 1: // 个人昵称编辑
            {
                // 弹出框
                EditNikeNameAlert *editNikeAlert = [[EditNikeNameAlert alloc] init];
                [editNikeAlert show];
                
                editNikeAlert.sureBlock = ^(NSString *nickname){
                    if (![nickname isEqualToString:@""]) {
                        DLog(@"%@", nickname);
#pragma mark  上传个人昵称
                        // 请求参数
                        NSDictionary *dict = @{
                                               @"user_id":[UserInfos sharedUser].ID,
                                               @"nickname":nickname
                                               };
                        // 请求
                        [self postRequestWithPath:API_Nickname params:dict success:^(id successJson) {

                            [self showAlert:successJson[@"message"]];
                            if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                                // 修改TableView的显示
                                [self.detailArr replaceObjectAtIndex:1 withObject:nickname];
                                [self.topTableView reloadData];

                                // 修改本地存储
                                [UserInfos sharedUser].usernickname = nickname;
                                [UserInfos setUser];
                            }
                        } error:^(NSError *error) {
                              DLog(@"%@", error);
                        }];
                    }
                };
                self.editAlert = editNikeAlert;
            }
                break;
            case 2:
            {
                EditNikeNameAlert *editSignAlert = [[EditNikeNameAlert alloc] init];
                __weak typeof(editSignAlert) weakSign = editSignAlert;
                [editSignAlert show];
                // 上传个性签名
                if ([UserInfos sharedUser].usermotto.length != 0) {
                    weakSign.easyMessage = [UserInfos sharedUser].usermotto;
                    weakSign.placeHolder = @"";
                    NSString * string = [UserInfos sharedUser].usermotto;
                    weakSign.countText = [NSString stringWithFormat:@"%@",@(17 - string.length)];
                }else{
                    weakSign.placeHolder = @"这个人很懒，他什么也没留下";
                    weakSign.easyMessage = @"";
                    weakSign.countText = @"17";
                    
                }
                editSignAlert.sureBlock = ^(NSString *signaue){
                    if (![signaue isEqualToString:@""]) {
                        DLog(@"%@", signaue);
#pragma mark  上传个人签名
                        
                        NSDictionary *dict = @{
                                               @"user_id":[UserInfos sharedUser].ID,
                                               @"user_motto":signaue
                                               };
                        [self postRequestWithPath:API_Signature params:dict success:^(id successJson) {
                            [self showAlert:successJson[@"message"]];
                            DLog(@"%@", successJson);
                            if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                             
                                // 修改TableView的显示
                                [self.detailArr replaceObjectAtIndex:2 withObject:signaue];
                                [self.topTableView reloadData];

                                // 修改本地存储
                                [UserInfos sharedUser].usermotto = signaue;
                                [UserInfos setUser];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                };
                editSignAlert.title = @"请输入个性签名";
//                editSignAlert.placeHolder = @"这个人很懒，他什么也没留下";
                editSignAlert.noteString = @"";
                self.editAlert = editSignAlert;
            }
                break;
            default:
                break;
        }
    }else if (tableView == self.bottomTableView){
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.bottomTableView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 20, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"账号绑定";
        label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.font = [UIFont systemFontOfSize:16];
        return label;
    }
    return nil;
}
#pragma mark
#pragma mark - Action
// 开关时间
- (void)clickSwitchAction:(UISwitch *)swit {

    NSInteger index = swit.tag - 50;
//    UISwitch *switc = (UISwitch *)self.accessosys[index];
    if (index == 0) {
        BOOL isButtonOn = [swit isOn];
        if (isButtonOn) {
            DLog(@"微信绑定");
            // 判断是否用微信登陆过
                __block  DeletePrommtView *WXprommt = [[DeletePrommtView alloc] init];
                WXprommt.message = @"你将要绑定微信!";
                [WXprommt show];
                WXprommt.sureBlock = ^(UIButton *btn){
                    
                    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
                        //        [self.tableView reloadData];
                        UMSocialAuthResponse *authresponse = result;

                        if (result != nil){
                            DLog(@"%@", authresponse.uid);
                            
                            NSDictionary *dict = @{
                                                   @"type":@"1",
                                                   @"name":authresponse.uid,
                                                   @"user_id":[UserInfos sharedUser].ID
                                                   };
                            [self getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                                DLog(@"%@", successJson);
                                [self showAlert:successJson[@"message"]];
                                if ([successJson[@"message"] isEqualToString:@"绑定成功"]) {
                                    [UserInfos sharedUser].wxopenid = authresponse.uid;
                                    [UserInfos setUser];
                                    [self.bottomTableView reloadData];
                                }
                            } error:^(NSError *error) {
                                DLog(@"%@", error);
                            }];
                        }else{
                            swit.on = !swit.on;
                        }
                    }];

                    WXprommt = nil;
                    [WXprommt dismiss];
                };
    }else {
        
        __block DeletePrommtView *WXprommt = [[DeletePrommtView alloc] init];
        WXprommt.message = @"你确定解绑微信？";
        [WXprommt show];
        WXprommt.sureBlock = ^(UIButton *btn){
            NSDictionary *dict = @{
                                   @"type":@"1",
//                                   @"name":[UserInfos sharedUser].wxopenid,
                                   @"user_id":[UserInfos sharedUser].ID
                                   };
            [self getRequestWithPath:API_Del_binding params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
                if ([successJson[@"message"] isEqualToString:@"解绑成功"]) {
                    [UserInfos sharedUser].wxopenid = @"";
                    [UserInfos setUser];
                    [self.bottomTableView reloadData];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            WXprommt = nil;
            [WXprommt dismiss];
        };
        WXprommt.cancelBlock = ^(){
            swit.on = !swit.on;
        };
    }
    }else if (index == 1){
        BOOL isButtonOn = [swit isOn];
        if (isButtonOn) {
            DLog(@"QQ绑定");
            // 判断是否用qq登陆过
                __block  DeletePrommtView *QQprommt = [[DeletePrommtView alloc] init];
                QQprommt.message = @"你将要绑定腾讯!";
                [QQprommt show];
                QQprommt.sureBlock = ^(UIButton *btn){
                    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
                        //        [self.tableView reloadData];
                        UMSocialAuthResponse *authresponse = result;
                        if (authresponse != nil) {
                            DLog(@"%@", authresponse.uid);
                            
                            NSDictionary *dict = @{
                                                   @"type":@"2",
                                                   @"name":authresponse.uid,
                                                   @"user_id":[UserInfos sharedUser].ID
                                                   };
                            [self getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                                DLog(@"%@", successJson);
                                [self showAlert:successJson[@"message"]];
                                if ([successJson[@"message"] isEqualToString:@"绑定成功"]) {
                                    [UserInfos sharedUser].qqopenid = authresponse.uid;
                                    [UserInfos setUser];
                                    [self.bottomTableView reloadData];
                                }
                            } error:^(NSError *error) {
                                DLog(@"%@", error);
                            }];
                        }else{
                            swit.on = !swit.on;
                        }
                    }];
                    
                    QQprommt = nil;
                    [QQprommt dismiss];
                };
            QQprommt.cancelBlock = ^(){
                swit.on = !swit.on;
            };
        }else {
            __block DeletePrommtView *QQprommt = [[DeletePrommtView alloc] init];
            QQprommt.message = @"你确定解绑腾讯？";
            [QQprommt show];
            QQprommt.sureBlock = ^(UIButton *btn){
                NSDictionary *dict = @{
                                       @"type":@"2",
//                                       @"name":[UserInfos sharedUser].qqopenid,
                                       @"user_id":[UserInfos sharedUser].ID
                                       };
                [self getRequestWithPath:API_Del_binding params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    [self showAlert:successJson[@"message"]];
                    if ([successJson[@"message"] isEqualToString:@"解绑成功"]) {
                        [UserInfos sharedUser].qqopenid = @"";
                        [UserInfos setUser];
                        [self.bottomTableView reloadData];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
                QQprommt = nil;
                [QQprommt dismiss];
            };
            QQprommt.cancelBlock = ^(){
                swit.on = !swit.on;
            };
        }
    }else if (index == 2){
        BOOL isButtonOn = [swit isOn];
        if (isButtonOn) {
            DLog(@"微博");
                __block  DeletePrommtView *WBprommt = [[DeletePrommtView alloc] init];
                WBprommt.message = @"你将要绑定微博!";
                [WBprommt show];
                WBprommt.sureBlock = ^(UIButton *btn){
                    [[UMSocialManager defaultManager]  authWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
                        //        [self.tableView reloadData];
                        UMSocialAuthResponse *authresponse = result;
                        if (authresponse != nil) {
                            DLog(@"%@", authresponse.uid);
                            
                            NSDictionary *dict = @{
                                                   @"type":@"3",
                                                   @"name":authresponse.uid,
                                                   @"user_id":[UserInfos sharedUser].ID
                                                   };
                            [self getRequestWithPath:API_Binding params:dict success:^(id successJson) {
                                DLog(@"%@", successJson);
                                [self showAlert:successJson[@"message"]];
                                if ([successJson[@"message"] isEqualToString:@"绑定成功"]) {
                                    [UserInfos sharedUser].wbopenid = authresponse.uid;
                                    [UserInfos setUser];
                                    [self.bottomTableView reloadData];
                                }
                            } error:^(NSError *error) {
                                DLog(@"%@", error);
                            }];
                        }else{
                            swit.on = !swit.on;
                        }
                    }];
                    
                    WBprommt = nil;
                    [WBprommt dismiss];
                };

            WBprommt.cancelBlock = ^(){
                swit.on = !swit.on;
            };
        } else {
            __block DeletePrommtView *WBprommt = [[DeletePrommtView alloc] init];
            WBprommt.message = @"你确定解绑微博？";
            [WBprommt show];
            WBprommt.sureBlock = ^(UIButton *btn){
                NSDictionary *dict = @{
                                       @"type":@(3),
                                       @"user_id":[UserInfos sharedUser].ID
                                       };
                
                [self getRequestWithPath:API_Del_binding params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    [self showAlert:successJson[@"message"]];
                    if ([successJson[@"message"] isEqualToString:@"解绑成功"]) {
                        [UserInfos sharedUser].wbopenid = @"";
                        [UserInfos setUser];
                        [self.bottomTableView reloadData];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
                WBprommt = nil;
                [WBprommt dismiss];
            };
            WBprommt.cancelBlock = ^(){
                swit.on = !swit.on;
            };
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 上传头像
// 相册
- (void)presentCmear {
    __block   ChoseCamearView *sizeView = [[ChoseCamearView alloc] init];
    sizeView.dataArr = @[@"更换头像",@"从相册选择", @"拍照", @"取消"];
    [sizeView show];
    
    //            __weak typeof(sizeView) weakView = sizeView;
    
    sizeView.sizeCellBlock = ^(NSString *type){
      
        if ([type isEqualToString:@"拍照"]) {
            [sizeView dismiss];
            sizeView = nil;
            // 调用相机
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
                
                //摄像头
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:self.imagePicker animated:YES completion:nil];
            } else {
                //如果没有提示用户
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"好吧!" otherButtonTitles:nil, nil];
                [alert show];
            }

            
        } else{
             if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
                [self presentViewController:self.imagePicker animated:YES completion:nil];
                
             } else {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"好吧!" otherButtonTitles:nil, nil];
                 
                 [alert show];
             }
            [sizeView dismiss];
            sizeView = nil;
        }
    };


    
}
// 相册得到的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {

    // 图片编辑
    UIImage *newImage = [self imageWithImage:image scaledToSize:CGSizeMake(60, 60)];
    
    NSString *base64 = [self imageBase64WithDataURL:newImage];
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"user_img":base64
                           };
    
    [self postRequestWithPath:API_Portrait params:dict success:^(id successJson) {
        if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
            // 修改TableView的显示
            self.userIconView.image = image;
    
            // 修改本地存储
            [UserInfos sharedUser].userimgurl = successJson[@"data"];
            [UserInfos setUser];
        }

        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
    //退出相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
// 图片转化字符串
- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    CGFloat imageWH = image.size.width;
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWH, imageWH), NO, 0);

    //创建贝塞尔曲线
    UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageWH, imageWH)];
    //添加剪切
    [bezier addClip];
    //把图绘上去
    [image drawAtPoint:CGPointZero];
    //开启上下文
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100 / newImage.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(newImage, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}
// 图片压缩
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    CGFloat imageWH = newSize.width;

    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,imageWH, imageWH)];
    
    //开启上下文
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

//点击Cancel按钮后执行方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
