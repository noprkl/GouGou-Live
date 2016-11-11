//
//  EditMyMessageViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditMyMessageViewController.h"
#import "DeletePrommtView.h"
#import "DogSizeFilter.h"
#import "EditNikeNameAlert.h"
#import <AFNetworking.h>

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
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
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
        NSString *userImage = @"nil";
        NSString *userMotto = @"暂无";
        NSString *userNike = @"暂无";
        
        if ([UserInfos sharedUser].userimgurl) {
            userImage = [UserInfos sharedUser].userimgurl;
        }
        if ([UserInfos sharedUser].usermotto) {
            userMotto = [UserInfos sharedUser].usermotto;
        }
        if ([UserInfos sharedUser].usernickname) {
            userNike = [UserInfos sharedUser].usernickname;
        }
        _detailArr = [[NSMutableArray alloc] initWithObjects:userImage, userMotto, userNike, tel, nil];
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
        
        if (indexPath.row == 0) {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, (88 - 60) / 2, 60, 60)];
            imageView.layer.cornerRadius = 30;
            imageView.layer.masksToBounds = YES;
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[UserInfos sharedUser].userimgurl] placeholderImage:[UIImage imageNamed:@"头像"]];

            self.userIconView = imageView;
            [cell.contentView addSubview:imageView];
            
        }else if (indexPath.row == 1) {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            cell.detailTextLabel.text = self.detailArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }else if (indexPath.row == 3) {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            cell.detailTextLabel.text = [UserInfos sharedUser].usertel;
        }else {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.detailTextLabel.text = self.detailArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
        return cell;

    }else if (tableView == self.bottomTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.textLabel.text = self.botttomDataArr[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        UISwitch *switchBtn = [[UISwitch alloc] init];
        switchBtn.tag = 50 + indexPath.row;
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
            case 0:
            {
                [self presentCmear];
            }
                break;
            
            case 1:
            {
                // 个人昵称编辑弹出框
                EditNikeNameAlert *editNikeAlert = [[EditNikeNameAlert alloc] init];
                [editNikeAlert show];
                
                editNikeAlert.sureBlock = ^(NSString *nickname){
                    if (![nickname isEqualToString:@""]) {
                        DLog(@"%@", nickname);
#pragma mark  上传个人昵称
                        // 请求参数
                        NSDictionary *dict = @{
                                               @"user_id":@17,
                                               @"nickname":nickname
                                               };
                        DLog(@"%@", dict);
                        
                        // 请求
                        [self postRequestWithPath:API_Nickname params:dict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                            if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                                // 修改TableView的显示
                                [self.detailArr replaceObjectAtIndex:1 withObject:nickname];

                                // 修改本地存储
                                [UserInfos sharedUser].usernickname = nickname;
                                [UserInfos setUser];
                            }
                        } error:^(NSError *error) {
                              DLog(@"%@", error);
                        }];
                        
                    }
                    [self.topTableView reloadData];

                };
                self.editAlert = editNikeAlert;
            }
                break;
            case 2:
            {
                EditNikeNameAlert *editSignAlert = [[EditNikeNameAlert alloc] init];
                
                [editSignAlert show];
                editSignAlert.sureBlock = ^(NSString *signaue){
                    if (![signaue isEqualToString:@""]) {
                        DLog(@"%@", signaue);
#pragma mark  上传个人签名

                        NSDictionary *dict = @{
                                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                               @"user_motto":signaue
                                               };
                        [self.detailArr replaceObjectAtIndex:2 withObject:signaue];
                        [self postRequestWithPath:API_Signature params:dict success:^(id successJson) {
                            [self showAlert:successJson[@"message"]];
                            DLog(@"%@", successJson);
                            if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                                // 修改TableView的显示
                                [self.detailArr replaceObjectAtIndex:1 withObject:signaue];
                                
                                // 修改本地存储
                                [UserInfos sharedUser].usermotto = signaue;
                                [UserInfos setUser];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                    [self.topTableView reloadData];
                };
                editSignAlert.title = @"请输入个性签名";
                editSignAlert.placeHolder = @"这个人很懒，他什么也没留下";
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
- (void)clickSwitchAction:(UISwitch *)swit {

    NSInteger index = swit.tag - 50;
    UISwitch *switc = (UISwitch *)self.accessosys[index];
    
    if (index == 0) {
        BOOL isButtonOn = [switc isOn];
        if (isButtonOn) {
            DLog(@"微信绑定");
        }else {
           
            DeletePrommtView *WXprommt = [[DeletePrommtView alloc] init];
            WXprommt.message = @"你确定解绑微信？";
            [WXprommt show];
            WXprommt.sureDeleteBtnBlock = ^(UIButton *btn){
                DLog(@"微信解绑");
            };
            WXprommt.cancelBlock = ^(){
                switc.on = YES;
                DLog(@"不解除");
            };
            
        }
    }else if (index == 1){
        BOOL isButtonOn = [switc isOn];
        if (isButtonOn) {
            DLog(@"腾讯绑定");
        }else {
            DeletePrommtView *Tencetprommt = [[DeletePrommtView alloc] init];
            Tencetprommt.message = @"你确定解绑腾讯？";
            [Tencetprommt show];
            Tencetprommt.sureDeleteBtnBlock = ^(UIButton *btn){
                DLog(@"腾讯解绑");
            };
            Tencetprommt.cancelBlock = ^(){
                switc.on = YES;
                DLog(@"不解除");
            };
        }

    }else if (index == 2){
        BOOL isButtonOn = [switc isOn];
        if (isButtonOn) {
            DLog(@"新浪绑定");
        }else {
            DeletePrommtView *Sinaprommt = [[DeletePrommtView alloc] init];
            Sinaprommt.message = @"你确定解绑新浪？";
            [Sinaprommt show];
            Sinaprommt.sureDeleteBtnBlock = ^(UIButton *btn){
                DLog(@"新浪解绑");
            };
            Sinaprommt.cancelBlock = ^(){
                switc.on = YES;
                DLog(@"不解除");
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
    __block   DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
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
    self.userIconView.image = image;

    NSData *data = UIImagePNGRepresentation(image);
    NSString *string = [data base64EncodedStringWithOptions:0];
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"user_img":@{
                                   @"data":@"image/png",
                                   @"base64":string
                                   }
                           };
    
    [self postImageRequestWithPath:API_Portrait params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
    //退出相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//点击Cancel按钮后执行方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)testAFN {
    //                        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //                      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    //
    //                        [manager POST:@"http://gougou.itnuc.com/api/http://gougou.itnuc.com/api/" parameters:json constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //
    //                        } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //                            DLog(@"%@", responseObject);
    //                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //
    //                        }];
}
- (void)testAFhttp {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //传入的参数
    NSDictionary *dict = @{
                                 @"user_id":@17,
                                 @"nickname":@"wuyu"
                                 };
    //你的接口地址
    NSString *url=@"http://gougou.itnuc.com/api/UserService/nickname";
    NSDictionary *json = [dict mj_JSONObject];
    //发送请求
    [manager POST:url parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
