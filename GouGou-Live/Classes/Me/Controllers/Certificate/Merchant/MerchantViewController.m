//
//  MerchantViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define ImgCount 3

#import "MerchantViewController.h"
#import "CertificateViewController.h"

#import "UnCertificateVIew.h"
#import "DoneCertificateView.h"
#import "AddUpdataImagesView.h"
#import "AddressChooseView.h"
#import "MyShopProvinceModel.h"
#import "NSString+CertificateImage.h"


static NSString * MedrchantCell = @"MedrchantCell";

@interface MerchantViewController ()
/** 未认证 */
@property (strong,nonatomic) UnCertificateVIew *unCertificateVIew;
/** 已经实名认证 */
@property (strong,nonatomic) DoneCertificateView *doneCertificateView;
/** 照片 */
@property (strong,nonatomic) AddUpdataImagesView *photoView;

@property(nonatomic, strong) NSMutableArray *photoUrl; /**< 图片地址 */

@property(nonatomic, strong) NSArray *proviceDataArr; /**< 省数据 */
@property(nonatomic, strong) NSMutableArray *cityDataArr; /**< 市数据 */
@property(nonatomic, strong) NSMutableArray *desticDataArr; /**< 县数据 */

@property(nonatomic, strong) NSString *provice; /**< 省 */
@property(nonatomic, strong) NSString *city; /**< 市 */
@property(nonatomic, strong) NSString *district; /**< 县 */

@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
    
    [self requestGetAreaData];
}
- (void)requestGetAreaData {
    [self getRequestWithPath:API_Province params:@{@"id":@(0)} success:^(id successJson) {
        if (successJson) {
            self.proviceDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self getRequestWithPath:API_Province params:@{@"id":@(1)} success:^(id successJson) {
        if (successJson) {
            [self.cityDataArr addObjectsFromArray:[MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self getRequestWithPath:API_Province params:@{@"id":@(36)} success:^(id successJson) {
        if (successJson) {
            [self.desticDataArr addObjectsFromArray:[MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (NSArray *)proviceDataArr {
    if (!_proviceDataArr) {
        _proviceDataArr = [NSArray array];
    }
    return _proviceDataArr;
}
- (NSMutableArray *)cityDataArr {
    if (!_cityDataArr) {
        _cityDataArr = [NSMutableArray array];
    }
    return _cityDataArr;
}
- (NSMutableArray *)desticDataArr {
    if (!_desticDataArr) {
        _desticDataArr = [NSMutableArray array];
    }
    return _desticDataArr;
}
- (NSMutableArray *)photoUrl {
    if (!_photoUrl) {
        _photoUrl = [NSMutableArray array];
    }
    return _photoUrl;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    if (![[UserInfos sharedUser].isreal isEqualToString:@"3"]) {
        [self.view addSubview:self.unCertificateVIew];

    }else{
   
        if ([[UserInfos sharedUser].isreal isEqualToString:@"0"]) {// 1：非商家 2：商家 3：审核中 4: 审核失败
        }else if ([[UserInfos sharedUser].isreal isEqualToString:@"2"]){
            
        }else if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]){
            
        }else if ([[UserInfos sharedUser].isreal isEqualToString:@"4"]){
            
        }
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(clickHandinCertitycate)];
        
        [self.view addSubview:self.doneCertificateView];
        [self.view addSubview:self.photoView];
    }
    
    
}
// 点击提交认证
- (void)clickHandinCertitycate {
    NSString *goodsText = self.doneCertificateView.infoTextfiled.text;
    NSString *adressText = self.doneCertificateView.infoTextfiled.text;
    NSString *areasText = self.doneCertificateView.areasTextField.text;
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
                            NSString *base64 = [NSString imageBase64WithDataURL:self.photoView.dataArr[0]];
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
                                                                @"invite_id":@([phoneNumText integerValue])
                                                                };
                                        DLog(@"%@", dict2);
                                        [self postRequestWithPath:API_MerchantAuth params:dict2 success:^(id successJson) {
                                            [self showAlert:successJson[@"message"]];
                                            if (successJson[@"message"]) { //0：失败 1：成功 2：邀请电话不存在 3: 个人信息未实名  4:已提交，审核中 请勿重复提交
                                                [UserInfos sharedUser].ismerchant = @"3";
                                                [UserInfos setUser];
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
            CertificateViewController *certifi = [[CertificateViewController alloc] init];
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
        _doneCertificateView.areasBlock = ^(){
            // 省市区级联
            __block AddressChooseView * choose = [[AddressChooseView alloc] init];
            
            __weak typeof(choose) weakChose = choose;
            choose.provinceArr = weakSelf.proviceDataArr;
            choose.cityArr = weakSelf.cityDataArr;
            choose.desticArr = weakSelf.desticDataArr;
            // 选中第一行 第二行请求
            choose.firstBlock = ^(MyShopProvinceModel *model){
                [weakSelf getRequestWithPath:API_Province params:@{@"id":@(model.ID)} success:^(id successJson) {
                    if (successJson) {
                        weakChose.cityArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                        [weakChose.areaPicker selectRow:0 inComponent:1 animated:YES];
                        [weakChose.areaPicker reloadComponent:1];
                        
                        MyShopProvinceModel *cityModel = weakChose.cityArr[0];
                        
                        // 请求第3行
                        [weakSelf getRequestWithPath:API_Province params:@{@"id":@(cityModel.ID)} success:^(id successJson) {
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
                weakSelf.provice = province;
                weakSelf.city = city;
                weakSelf.district = district;
                weakSelf.doneCertificateView.areasTextField.text = [NSString stringWithFormat:@"%@,%@,%@",province, city, district];
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
        _photoView = [[AddUpdataImagesView alloc] initWithFrame:CGRectMake(0, 267, SCREEN_WIDTH, W + 20)];
        _photoView.maxCount = ImgCount;
      
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
@end
