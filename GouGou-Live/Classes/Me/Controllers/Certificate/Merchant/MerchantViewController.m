//
//  MerchantViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define ImgCount 3

#import "MerchantViewController.h"
#import "CertificateVc.h"

#import "UnCertificateVIew.h"
#import "DoneCertificateView.h"
#import "AddUpdataImagesView.h"
#import "AddressChooseView.h"
#import "MyShopProvinceModel.h"
#import "NSString+CertificateImage.h"

#import "HaveCommitCertificateView.h"
#import "CerfificateFaildView.h"
#import "CerFiticateSuccessView.h"
#import "PersonalMessageModel.h"

static NSString * MedrchantCell = @"MedrchantCell";

@interface MerchantViewController ()
/** 未实名认证 */
@property (strong,nonatomic) UnCertificateVIew *unCertificateVIew;
/** 已经实名认证 */
@property (strong,nonatomic) DoneCertificateView *doneCertificateView;

@property (nonatomic, strong) HaveCommitCertificateView *haveCommitView; /**< 审核中 */
@property (nonatomic, strong) CerfificateFaildView *faildView; /**< 审核失败 */
@property (nonatomic, strong) CerFiticateSuccessView *successView; /**< 审核成功 */


/** 照片 */
@property (strong,nonatomic) AddUpdataImagesView *photoView;
/** 上传佐证 */
@property (strong,nonatomic) UILabel *upLoadlabel;

@property (nonatomic, strong) UILabel *pictureCountLabel; /**< 提示 */

@property(nonatomic, strong) NSMutableArray *photoUrl; /**< 图片地址 */

@property(nonatomic, strong) NSArray *proviceDataArr; /**< 省数据 */
@property(nonatomic, strong) NSArray *cityDataArr; /**< 市数据 */
@property(nonatomic, strong) NSArray *desticDataArr; /**< 县数据 */

@property(nonatomic, strong) NSString *provice; /**< 省 */
@property(nonatomic, strong) NSString *city; /**< 市 */

@property(nonatomic, strong) NSString *district; /**< 县 */


//@property (nonatomic, strong) UIButton *cityAdressBtn; /**< 城市选择按钮 */
@property (nonatomic, strong) UILabel *cityAdressBtn; /**< 城市选择按钮 */

@end

@implementation MerchantViewController
// 机那里进行请求判断当前状态
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
            if (![[UserInfos sharedUser].isreal isEqualToString:@"3"]) {
                [self.view addSubview:self.unCertificateVIew];
            }else{
                
                if ([[UserInfos sharedUser].ismerchant isEqualToString:@"1"] || [[UserInfos sharedUser].ismerchant isEqualToString:@"0"]) {// 1：非商家 2：商家 3：审核中 4: 审核失败
                    [self initUI];
                }else if ([[UserInfos sharedUser].ismerchant isEqualToString:@"2"]){
                    [self.view addSubview:self.successView];
                }else if ([[UserInfos sharedUser].ismerchant isEqualToString:@"3"]){
                    [self.view addSubview:self.haveCommitView];
                }else if ([[UserInfos sharedUser].ismerchant isEqualToString:@"4"]){
                    [self.view addSubview:self.faildView];
                }
            }
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getrequestPersonalMessage];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 释放
    self.unCertificateVIew.timer = nil;
//    dispatch_source_cancel(self.unCertificateVIew.timer);
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
        __weak typeof(self) weakSelf = self;
        _successView.backBlock = ^(){
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _successView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
    
    [self requestGetAreaData];
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(clickHandinCertitycate)];
    
    [self.view addSubview:self.doneCertificateView];
    [self.view addSubview:self.photoView];
    [self.view addSubview:self.upLoadlabel];
    [self.view addSubview:self.pictureCountLabel];
//    [self.upLoadlabel makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.doneCertificateView.bottom).offset(10);
//        make.left.right.equalTo(self.doneCertificateView);
//        make.height.equalTo(44);
//    }];
    [self.pictureCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoView.bottom);
        make.left.right.equalTo(self.doneCertificateView);
        make.height.equalTo(30);
    }];
    
}
- (NSArray *)proviceDataArr {
    if (!_proviceDataArr) {
        _proviceDataArr = [NSArray array];
    }
    return _proviceDataArr;
}
- (NSArray *)cityDataArr {
    if (!_cityDataArr) {
        _cityDataArr = [NSArray array];
    }
    return _cityDataArr;
}
- (NSArray *)desticDataArr {
    if (!_desticDataArr) {
        _desticDataArr = [NSArray array];
    }
    return _desticDataArr;
}
- (void)requestGetAreaData {
    [self getRequestWithPath:API_Province params:@{@"id":@(0)} success:^(id successJson) {
        if (successJson) {
            self.proviceDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        }
        //        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self getRequestWithPath:API_Province params:@{@"id":@(1)} success:^(id successJson) {
        if (successJson) {
            self.cityDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        }
        //        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self getRequestWithPath:API_Province params:@{@"id":@(36)} success:^(id successJson) {
        if (successJson) {
            //            self.desticDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            self.desticDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            
        }
        //        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (NSMutableArray *)photoUrl {
    if (!_photoUrl) {
        _photoUrl = [NSMutableArray array];
    }
    return _photoUrl;
}

// 点击提交认证
- (void)clickHandinCertitycate {
    NSString *goodsText = self.doneCertificateView.infoTextfiled.text;
    NSString *adressText = self.doneCertificateView.adressTextField.text;
    NSString *areasText = self.cityAdressBtn.text;
    NSString *phoneNumText = self.doneCertificateView.phoneNumTextfiled.text;

    if (goodsText.length == 0) {
        [self showAlert:@"商品名不能为空"];
    }else{
        if (areasText.length == 0) {
            [self showAlert:@"地址不能为空"];
        }else{
            if (adressText.length == 0) {
                [self showAlert:@"请填写详细地址"];
            }else{
                if (phoneNumText.length != 0 && ![NSString valiMobile:phoneNumText]) {
                [self showAlert:@"请输入正确的手机号"];
                }
                if (self.photoView.dataArr.count == 0) {
                    [self showAlert:@"请添加1-3张图片"];
                }else{
                    
                        for (NSInteger i = 0; i < self.photoView.dataArr.count; i ++) {
                            UIImage *image = self.photoView.dataArr[0];
                            NSString *base64 = [NSString imageBase64WithDataURL:image withSize:CGSizeMake(image.size.width, image.size.height)];
                            NSDictionary *dict = @{
                                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                                   @"img":base64
                                                   };
                            [self postRequestWithPath:API_UploadImg params:dict success:^(id successJson) {
                                if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                                    [self.photoUrl addObject:successJson[@"data"]];
                                   
                                    if (self.photoUrl.count == self.photoView.dataArr.count) {
                                        NSString *str = [self.photoUrl componentsJoinedByString:@"|"];
                                        DLog(@"%@", str);
                                        NSDictionary *dict2 = @{
                                                                @"uid":@([[UserInfos sharedUser].ID integerValue]),
                                                                @"shop_name":goodsText,
                                                                @"shop_region":areasText,
                                                                @"shop_area":adressText,
                                                                @"shop_photo":str,
                                                                @"invite_id":phoneNumText
                                                                };
                                        DLog(@"%@", dict2);
                                        [self postRequestWithPath:API_MerchantAuth params:dict2 success:^(id successJson) {
                                            [self showAlert:successJson[@"message"]];
                                            if ([successJson[@"message"] isEqualToString:@"信息提交成功"]) { //0：失败 1：成功 2：邀请电话不存在 3: 个人信息未实名  4:已提交，审核中 请勿重复提交
                                                [UserInfos sharedUser].ismerchant = @"3";
                                                [UserInfos setUser];
                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                    [self.navigationController popToRootViewControllerAnimated:YES];
                                                });
                                            }
                                            DLog(@"%@", successJson);
                                        } error:^(NSError *error) {
                                            DLog(@"%@", error);
                                        }];
                                    }

                                }
                            } error:^(NSError *error) {
                                DLog(@"%@", error);
                            }];
                        }
                }
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UnCertificateVIew *)unCertificateVIew {
    if (!_unCertificateVIew) {
        _unCertificateVIew = [[UnCertificateVIew alloc] initWithFrame:self.view.bounds];
        _unCertificateVIew.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

        __weak typeof(self) weakSelf = self;
        _unCertificateVIew.certificateBlack = ^(){
            CertificateVc *certifi = [[CertificateVc alloc] init];
            [weakSelf.navigationController pushViewController:certifi animated:YES];
        };
    }
    return _unCertificateVIew;
}

- (DoneCertificateView *)doneCertificateView {
    if (!_doneCertificateView) {
        _doneCertificateView = [[DoneCertificateView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64))];
        _doneCertificateView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        __weak typeof(self) weakSelf = self;
        __weak typeof(_doneCertificateView) weakCertifi = _doneCertificateView;
        _doneCertificateView.areasBlock = ^(UILabel *btn){
            weakSelf.cityAdressBtn = btn;
            [weakCertifi.infoTextfiled resignFirstResponder];
//            [weakCertifi.areasTextField resignFirstResponder];
            [weakCertifi.adressTextField resignFirstResponder];
            [weakCertifi.phoneNumTextfiled resignFirstResponder];
            // 省市区级联
            __block AddressChooseView * choose = [[AddressChooseView alloc] init];
            
            __weak typeof(choose) weakChose = choose;
            
            choose.provinceArr = [weakSelf.proviceDataArr mutableCopy];
            choose.cityArr = [weakSelf.cityDataArr mutableCopy];
            choose.desticArr = [weakSelf.desticDataArr mutableCopy];
            // 选中第一行 第二行请求
            choose.firstBlock = ^(MyShopProvinceModel *model){
                [weakSelf getRequestWithPath:API_Province params:@{@"id":@(model.ID)} success:^(id successJson) {
                    [weakChose.cityArr removeAllObjects];
                    [weakChose.desticArr removeAllObjects];
                    [weakChose.areaPicker reloadAllComponents];
                    if (successJson) {
                        weakChose.cityArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                        [weakChose.areaPicker selectRow:0 inComponent:1 animated:YES];
                        [weakChose.areaPicker reloadComponent:1];
                        
                        MyShopProvinceModel *cityModel = weakChose.cityArr[0];
                        
                        // 请求第3行
                        [weakSelf getRequestWithPath:API_Province params:@{@"id":@(cityModel.ID)} success:^(id successJson) {
                            [weakChose.desticArr removeAllObjects];
                            [weakChose.areaPicker reloadAllComponents];
                            if (successJson) {
                                weakChose.desticArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                                [weakChose.areaPicker selectRow:0 inComponent:2 animated:YES];
                                [weakChose.areaPicker reloadComponent:2];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            };
            // 选中第二行 第三行请求
            choose.secondBlock = ^(MyShopProvinceModel *model){
                
                [weakSelf getRequestWithPath:API_Province params:@{@"id":@(model.ID)} success:^(id successJson) {
                    if (successJson) {
                        weakChose.desticArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                        [weakChose.areaPicker selectRow:0 inComponent:2 animated:YES];
                        [weakChose.areaPicker reloadComponent:2];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            };
            
            choose.areaBlock = ^(NSString *province,NSString *city,NSString *district){
                NSString *cityAdress;
                if (district.length == 0) {
                    district = @"";
                    cityAdress = [NSString stringWithFormat:@"%@,%@",province, city];
                }else{
                    cityAdress = [NSString stringWithFormat:@"%@,%@,%@",province, city, district];
                }
                weakSelf.provice = province;
                weakSelf.city = city;
                weakSelf.district = district;
                weakSelf.cityAdressBtn.text =cityAdress;
            };
            [choose show];
        };
    }
    return _doneCertificateView;
}
- (AddUpdataImagesView *)photoView {
    
    if (!_photoView) {
        __block CGFloat W = 0;
        if (ImgCount <= kMaxImgCount) {
            W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / ImgCount;
        }else{
            W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
        }
        _photoView = [[AddUpdataImagesView alloc] initWithFrame:CGRectMake(0, 307, SCREEN_WIDTH, W + 20)];
        _photoView.maxCount = ImgCount;
      
        __weak typeof(self) weakSelf = self;
        __weak typeof(_photoView) weakPhoto = _photoView;
        _photoView.addBlock = ^(){

            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.isSelectOriginalPhoto = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;

            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    [weakPhoto.dataArr addObject:photos[0]];
                    
                    [weakPhoto.collectionView reloadData];
                    CGFloat row = weakPhoto.dataArr.count / kMaxImgCount;
                    CGRect rect = weakPhoto.frame;
                    rect.size.height = (row + 1) * (W + 10) + 10;
                    weakPhoto.frame = rect;
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    }
    return _photoView;
}
// 上传佐证label
- (UILabel *)upLoadlabel {
    if (!_upLoadlabel) {
        _upLoadlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 262, SCREEN_WIDTH, 44)];
        _upLoadlabel.text = @"   上传佐证";
        _upLoadlabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _upLoadlabel.font = [UIFont systemFontOfSize:16];
        _upLoadlabel.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _upLoadlabel;
}
- (UILabel *)pictureCountLabel {
    if (!_pictureCountLabel) {
        _pictureCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _pictureCountLabel.text = [NSString stringWithFormat:@"%@%@",@"   ",@"请上传1-3张展示上家实力的图片"];
        _pictureCountLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _pictureCountLabel.font = [UIFont systemFontOfSize:12];
        _pictureCountLabel.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _pictureCountLabel;
}
@end
