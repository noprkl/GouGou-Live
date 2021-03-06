//
//  CertificateVc.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CertificateVc.h"
#import "IdentityIfonView.h"
#import "IdentityPictureCell.h"
#import "NSString+CertificateImage.h"
#import "NSString+MD5Code.h"

#import "HaveCommitCertificateView.h"
#import "CerfificateFaildView.h"
#import "CerFiticateSuccessView.h"
#import "PersonalMessageModel.h"

static NSString * identityCell = @"identitiCellID";

@interface CertificateVc ()<UITableViewDelegate,UITableViewDataSource>
/** 身份信息 */
@property (strong,nonatomic) IdentityIfonView *identityInfoView;
/** 身份验证tableView */
@property (strong,nonatomic) UITableView *identityTableView;
/** 接收姓名 */
@property (strong,nonatomic) UITextField *acceptName;
/** 接收身份证号 */
@property (strong,nonatomic) UITextField *acceptIdebtity;

@property(nonatomic, strong) UIImage *faceIdentfityImg; /**< 省份证正面图片 */
@property(nonatomic, strong) UIImage *backIdentfityImg; /**< 省份证背面图片 */

@property (nonatomic, strong) HaveCommitCertificateView *haveCommitView; /**< 审核中 */
@property (nonatomic, strong) CerfificateFaildView *faildView; /**< 审核失败 */
@property (nonatomic, strong) CerFiticateSuccessView *successView; /**< 审核成功 */
@end

@implementation CertificateVc
#pragma mark
#pragma mark - 网络请求 实名认证提交
- (void)postCertificateIdentfity {
    
    // 请求图片
    // 正面
    NSString *faceBase64 = [NSString imageBase64WithDataURL:self.faceIdentfityImg withSize:CGSizeMake(self.faceIdentfityImg.size.width, self.faceIdentfityImg.size.height)];
    
    NSDictionary *faceDict = @{
                               @"user_id":[UserInfos sharedUser].ID,
                               @"img":faceBase64
                               };
    
    [self postRequestWithPath:API_UploadImg params:faceDict success:^(id successJson) {
        if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
            NSString *faceStr = successJson[@"data"];
            // 背面
            NSString *backBase64 = [NSString imageBase64WithDataURL:self.backIdentfityImg withSize:CGSizeMake(self.backIdentfityImg.size.width, self.backIdentfityImg.size.height)];
            
            NSDictionary *backDict = @{
                                       @"user_id":[UserInfos sharedUser].ID,
                                       @"img":backBase64
                                       };
            
            [self postRequestWithPath:API_UploadImg params:backDict success:^(id successJson) {
                if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                    NSString *backStr = successJson[@"data"];
                    // 提交认证
                    NSDictionary *dict = @{
                                           @"id":[UserInfos sharedUser].ID,
                                           @"user_name":self.acceptName.text,
                                           @"user_auth_id":self.acceptIdebtity.text,
                                           @"user_auth_img_front":faceStr,
                                           @"user_auth_img_back":backStr
                                           };
                    DLog(@"%@", dict);
                    [self postRequestWithPath:API_Authenticate params:dict success:^(id successJson) {
                        
                        [self showAlert:successJson[@"message"]];
                        if ([successJson[@"message"] isEqualToString:@"信息提交成功"]) {
                            [UserInfos sharedUser].isreal = @"2";
                            [UserInfos sharedUser].username = self.acceptName.text;
                            [UserInfos setUser];
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    } error:^(NSError *error) {
                        DLog(@"%@", error);
                    }];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
        
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getrequestPersonalMessage {
    NSDictionary *dict = @{
                           @"id":[UserInfos sharedUser].ID
                           };
    [self getRequestWithPath:API_Personal params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"code"] isEqualToString:@"1"]) {
            NSArray *arr = [PersonalMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            PersonalMessageModel *model = [arr lastObject];
            [UserInfos sharedUser].ismerchant = model.isMerchant;
            [UserInfos sharedUser].isreal = model.isReal;
            [UserInfos setUser];
            
            if ([[UserInfos sharedUser].isreal isEqualToString:@"1"]) { //1.未认证 2.审核 3.已认证 4.认证失败
                
                self.title = @"实名认证";
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(requestNameAndIdentiry)];
                self.view.backgroundColor = [UIColor whiteColor];
                
                [self.view addSubview:self.identityInfoView];
                [self.view addSubview:self.identityTableView];
                
            }else if ([[UserInfos sharedUser].isreal isEqualToString:@"2"]){
                [self.view addSubview:self.haveCommitView];
            }else if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]){
                [self.view addSubview:self.successView];
            }else if ([[UserInfos sharedUser].isreal isEqualToString:@"4"]){
                [self.view addSubview:self.faildView];
            }
            
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getrequestPersonalMessage];
}
// UI
- (void)initUI {
    
    self.title = @"实名认证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(requestNameAndIdentiry)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.identityInfoView];
    [self.view addSubview:self.identityTableView];
}
- (HaveCommitCertificateView *)haveCommitView {
    if (!_haveCommitView) {
        _haveCommitView = [[HaveCommitCertificateView alloc] initWithFrame:self.view.bounds];
        __weak typeof(self) weakSelf = self;
        _haveCommitView.backBlock = ^(){
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _haveCommitView;
}
- (CerfificateFaildView *)faildView {
    if (!_faildView) {
        _faildView = [[CerfificateFaildView alloc] initWithFrame:self.view.bounds];
        
        __weak typeof(self) weakSelf = self;
        _faildView.backBlcok = ^(){
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        _faildView.recommitBlock = ^(){
            weakSelf.faildView.hidden = YES;
            [weakSelf initUI];
        };
    }
    return _faildView;
}
- (CerFiticateSuccessView *)successView {
    if (!_successView) {
        _successView = [[CerFiticateSuccessView alloc] initWithFrame:self.view.bounds];
        _successView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        __weak typeof(self) weakSelf = self;
        _successView.backBlock = ^(){
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _successView;
}
#pragma 网络请求
- (void)requestNameAndIdentiry {
    [self.acceptName resignFirstResponder];
    [self.acceptIdebtity resignFirstResponder];
    
    if (self.acceptName.text.length == 0) {
        
        [self showAlert:@"姓名不能为空"];
        
    } else if (![self.acceptName.text isChinese]) {
        
        [self showAlert:@"姓名必须为中文"];
        
    } else if (self.acceptName.text.length > 4){
        
        [self showAlert:@"姓名最多四个汉字"];
    } else {
        if (self.acceptIdebtity.text.length == 0) {
            [self showAlert:@"身份证号不能为空"];
        }else{
            BOOL flag = [[NSString alloc] judgeIdentityStringValid:self.acceptIdebtity.text];
            
            if (!flag) {
                
                [self showAlert:@"您输入的身份证格式不正确"];
            } else {
                if (self.faceIdentfityImg == nil) {
                    [self showAlert:@"请选择正面照片"];
                }else{
                    if (self.backIdentfityImg == nil) {
                        [self showAlert:@"请选择背面照片"];
                    }else{
                        [self postCertificateIdentfity];
                    }
                }
            }
        }
    }
}

- (IdentityIfonView *)identityInfoView {
    
    if (!_identityInfoView) {
        _identityInfoView = [[IdentityIfonView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 88)];
        __weak typeof(self) weakself = self;
        
        _identityInfoView.nameTextBlock = ^(UITextField *textfiled){
            
            weakself.acceptName = textfiled;
        };
        
        _identityInfoView.identiityTextBlock = ^(UITextField * textfiled) {
            
            weakself.acceptIdebtity = textfiled;
        };
        
    }
    return _identityInfoView;
}

- (UITableView *)identityTableView {
    
    if (!_identityTableView) {
        _identityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT - 130 - 64) style:UITableViewStylePlain];
        
        _identityTableView.delegate = self;
        _identityTableView.dataSource = self;
        //        _identityTableView.bounces = NO;
        
        _identityTableView.showsVerticalScrollIndicator = NO;
        [_identityTableView registerClass:[IdentityPictureCell class] forCellReuseIdentifier:identityCell];
    }
    return _identityTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 428;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IdentityPictureCell * cell = [tableView dequeueReusableCellWithIdentifier:identityCell];
    
    if (indexPath.row == 0) {
        if (self.faceIdentfityImg == nil) {
            [cell identityWithPromptlabel:@"请上传身份证正面标签" instanceImage:[UIImage imageNamed:@"组-12"] instanceLabe:@"(示例)清晰正面照" identityImage:[UIImage imageNamed:@"图层-53-拷贝-2"] identityLabel:@"清晰正面照"];
        }else{
            
            [cell identityWithPromptlabel:@"请上传身份证正面标签" instanceImage:[UIImage imageNamed:@"组-12"] instanceLabe:@"(示例)清晰正面照" identityImage:self.faceIdentfityImg identityLabel:@"清晰正面照"];
        }
        
        __weak typeof(self) weakSelf = self;
        cell.addIdentityBlock = ^(UIImageView *identfityView) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.isSelectOriginalPhoto = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    UIImage *image = [photos lastObject];
                    identfityView.image = image;
                    self.faceIdentfityImg = image;
                }else{
                    DLog(@"出错了");
                }
            }];
            
            //            [self pushToAddFacePhoto:identfityView];
        };
        
    } else if (indexPath.row == 1) {
        
        if (self.backIdentfityImg == nil) {
            [cell identityWithPromptlabel:@"请上传身份证背面标签" instanceImage:[UIImage imageNamed:@"组-11"] instanceLabe:@"(示例)清晰背面照" identityImage:[UIImage imageNamed:@"图层-53-拷贝-2"] identityLabel:@"清晰背面照"];
        }else{
            [cell identityWithPromptlabel:@"请上传身份证背面标签" instanceImage:[UIImage imageNamed:@"组-11"] instanceLabe:@"(示例)清晰背面照" identityImage:self.backIdentfityImg identityLabel:@"清晰背面照"];
        }
        __weak typeof(self) weakSelf = self;
        
        cell.addIdentityBlock = ^(UIImageView *identfityView) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.isSelectOriginalPhoto = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    UIImage *image = [photos lastObject];
                    identfityView.image = image;
                    self.backIdentfityImg = image;
                }else{
                    DLog(@"出错了");
                }
            }];
            
            //            [self pushToAddBackPhoto:identfityView];
        };
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
#pragma mark
#pragma mark - 相机调用

- (void)pushToAddFacePhoto:(UIImageView *)identifityView {
    
    UIImagePickerController * pickVC = [[UIImagePickerController alloc] init];
    
    [self.navigationController pushViewController:pickVC animated:YES];
    
}
- (void)pushToAddBackPhoto:(UIImageView *)identifityView {
    // 调用相机
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
