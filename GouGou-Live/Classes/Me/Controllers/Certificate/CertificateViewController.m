//
//  CertificateViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CertificateViewController.h"
#import "IdentityIfonView.h"
#import "IdentityPictureCell.h"
#import "NSString+CertificateImage.h"
#import "NSString+MD5Code.h"

static NSString * identityCell = @"identitiCellID";

@interface CertificateViewController ()<UITableViewDelegate,UITableViewDataSource>
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

@end

@implementation CertificateViewController
#pragma mark
#pragma mark - 网络请求 实名认证提交
- (void)postCertificateIdentfity {

    // 请求图片
    // 正面
    NSString *faceBase64 = [NSString imageBase64WithDataURL:self.faceIdentfityImg];
    
    NSDictionary *faceDict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"img":faceBase64
                           };
    
    [self postRequestWithPath:API_UploadImg params:faceDict success:^(id successJson) {
        if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
            NSString *faceStr = successJson[@"data"];
           // 背面
            NSString *backBase64 = [NSString imageBase64WithDataURL:self.backIdentfityImg];
            
            NSDictionary *backDict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"img":backBase64
                                   };
            
            [self postRequestWithPath:API_UploadImg params:backDict success:^(id successJson) {
                if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                    NSString *backStr = successJson[@"data"];
                    // 提交认证
                    NSDictionary *dict = @{
                                           @"id":@([[UserInfos sharedUser].ID integerValue]),
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([[UserInfos sharedUser].isreal isEqualToString:@"1"]) { //1.未认证 2.审核 3.已认证 4.认证失败
        
    }else if ([[UserInfos sharedUser].isreal isEqualToString:@"2"]){
        
    }else if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]){
        
    }else if ([[UserInfos sharedUser].isreal isEqualToString:@"4"]){
        
    }
}
- (void)initUI {

    self.title = @"实名认证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(requestNameAndIdentiry)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.identityInfoView];
    [self.view addSubview:self.identityTableView];
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
                
                [self postCertificateIdentfity];
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
        [cell identityWithPromptlabel:@"请上传身份证正面标签" instanceImage:[UIImage imageNamed:@"组-12"] instanceLabe:@"(示例)清晰正面照" identityImage:[UIImage imageNamed:@"图层-53-拷贝-2"] identityLabel:@"清晰正面照"];
       
        __weak typeof(self) weakSelf = self;
        cell.addIdentityBlock = ^(UIImageView *identfityView) {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
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

        [cell identityWithPromptlabel:@"请上传身份证背面标签" instanceImage:[UIImage imageNamed:@"组-11"] instanceLabe:@"(示例)清晰背面照" identityImage:[UIImage imageNamed:@"图层-53-拷贝-2"] identityLabel:@"清晰背面照"];
        __weak typeof(self) weakSelf = self;

        cell.addIdentityBlock = ^(UIImageView *identfityView) {
           
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
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
