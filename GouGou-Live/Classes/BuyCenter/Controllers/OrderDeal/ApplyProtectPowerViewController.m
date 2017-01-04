//
//  ApplyProtectPowerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//  申请维权（订单操作）

#define ImgCount 3

#import "ApplyProtectPowerViewController.h"
#import "ProtecePowerPromptView.h"  // 维权提示框
#import "PowerOrderStateView.h" // 订单状态
#import "SellinfoView.h"  // 商家信息
#import "DogDetailCardView.h"    // 狗狗详情卡片
#import "CostView.h"            // 花费
#import "SureApplyRefundview.h"  // 是否申请退款
#import "UpLoadPictureView.h"    // 上传照片
#import "AddUpdataImagesView.h"  // 图片
#import "OrderDetailModel.h" //模型
#import "NSString+CertificateImage.h"

@interface ApplyProtectPowerViewController ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate>
/** 底部scrollView */
@property (strong,nonatomic) UIScrollView *boomScrollView;
/** 订单状态 */
@property (strong,nonatomic) PowerOrderStateView *powerOrderView;
/** 商家信息 */
@property (strong,nonatomic) SellinfoView *sellInfoView;
/** 狗狗详情 */
@property (strong,nonatomic) DogDetailCardView *dogDetailView;
/** 花费 */
@property (strong,nonatomic) CostView *costView;
/** 是否申请退款 */
@property (strong,nonatomic) SureApplyRefundview *sureApplyRefundView;
/**< 图片 */
@property(nonatomic, strong) AddUpdataImagesView *photoView;
/** 提交申请 */
@property (strong,nonatomic) UIButton * handinApplicationBtn;

@property (nonatomic, assign) BOOL isMoney; /**< 是否需要金钱 */

///** 接受view */
//@property (strong,nonatomic) UIImageView *acceptImageView;
@property (strong, nonatomic) NSString *refunMoney; /**< 接收退款 */
@property (strong, nonatomic) NSString *descContent;   /**< 接收描述 */

@property (nonatomic, strong) OrderDetailModel *detailModel; /**< 详情信息 */


@property (nonatomic, strong) NSMutableArray *photoArr; /**< 图片路径 */

@end

@implementation ApplyProtectPowerViewController
#pragma mark
#pragma mark - 网络请求
- (void)postAddProtectProwerRequest {
    NSInteger hasMoney = 1;
    if (!_isMoney){ // 无需金钱
        self.refunMoney = @"";
        hasMoney = 2;
    }
    for (NSInteger i = 0; i < self.photoView.dataArr.count; i ++) {
        NSString *base64 = [NSString imageBase64WithDataURL:self.photoView.dataArr[0] withSize:CGSizeMake(SCREEN_WIDTH / 3, SCREEN_WIDTH / 3)];
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                               @"img":base64
                               };
        [self postRequestWithPath:API_UploadImg params:dict success:^(id successJson) {
            if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                [self.photoArr addObject:successJson[@"data"]];
                
                if (self.photoArr.count == self.photoView.dataArr.count) {
                    // 图片base64字符串
                    NSString *str = [self.photoArr componentsJoinedByString:@"|"];
                    DLog(@"%@", str);
                    DLog(@"%@", self.refunMoney);
                    NSDictionary * dict = @{
                                            @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                            @"order_id":_orderID,
                                            @"content":self.descContent,
                                            @"has_money":@(hasMoney),
                                            @"money":self.refunMoney,
                                            @"has_photo":@(2),
                                            @"img":str
                                            };
                    DLog(@"%@", dict);
                    [self postRequestWithPath:API_Add_activist params:dict success:^(id successJson) {
                        DLog(@"%@", successJson);
                        [self showAlert:successJson[@"message"]];
                        if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        
                    } error:^(NSError *error) {
                        DLog(@"%@",error);
                    }];
                }
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }

}
- (void)getOrderDetailWithOrderID:(NSString *)orderId {
    NSDictionary *dict = @{
                           @"id":orderId
                           };
    [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.detailModel = [OrderDetailModel mj_objectWithKeyValues:successJson[@"data"]];
        // 设置订单状态
        NSString *state = @"";
        if ([self.detailModel.status isEqualToString:@"1"]) {
            state = @"待付款";
        }else if ([self.detailModel.status isEqualToString:@"2"]) {
            state = @"待付定金";
        }else if ([self.detailModel.status isEqualToString:@"3"]) {
            state = @"待付尾款";
        }else if ([self.detailModel.status isEqualToString:@"4"]) {
            state = @"";
        }else if ([self.detailModel.status isEqualToString:@"5"]) {
            state = @"待付全款";
        }else if ([self.detailModel.status isEqualToString:@"6"]) {
            state = @"";
        }else if ([self.detailModel.status isEqualToString:@"7"]) {
            state = @"待发货";
        }else if ([self.detailModel.status isEqualToString:@"8"]) {
            state = @"待收货";
        }else if ([self.detailModel.status isEqualToString:@"9"]) {
            state = @"已评价";
        }else if ([self.detailModel.status isEqualToString:@"10"]) {
            state = @"待评价";
        }else if ([self.detailModel.status isEqualToString:@"20"]) {
            state = @"订单取消";
        }
        self.powerOrderView.orderStateMessage = state;
        self.powerOrderView.orderCode = _orderID;
      
        self.sellInfoView.currentTime = self.detailModel.createTime;
        self.sellInfoView.buynessName = self.detailModel.userName;
        self.sellInfoView.buynessImg = self.detailModel.userImgUrl;
        
        // 狗狗详情
        if (self.detailModel.pathSmall.length != 0) {
            
            NSString *urlString = [IMAGE_HOST stringByAppendingString:self.detailModel.pathSmall];
            [self.dogDetailView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
        }
        self.dogDetailView.dogNameLabel.text = self.detailModel.name;
        self.dogDetailView.dogAgeLabel.text = self.detailModel.ageName;
        self.dogDetailView.dogSizeLabel.text = self.detailModel.sizeName;
        self.dogDetailView.dogColorLabel.text = self.detailModel.colorName;
        self.dogDetailView.dogKindLabel.text = self.detailModel.kindName;
        self.dogDetailView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:self.detailModel.priceOld];
        self.dogDetailView.nowPriceLabel.text = self.detailModel.price;
        
        // 付款状况
        self.costView.fontMoney.text = self.detailModel.productDeposit;
        self.costView.remainderMoeny.text = self.detailModel.productBalance;
        self.costView.totalMoney.text = [NSString stringWithFormat:@"%.2lf", [self.detailModel.price floatValue] + [self.detailModel.traficFee floatValue]];
        
        self.sureApplyRefundView.realMoney = [NSString stringWithFormat:@"%.2lf", [self.detailModel.productRealDeposit floatValue] + [self.detailModel.productRealBalance floatValue]];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isMoney = NO;
    [self getOrderDetailWithOrderID:_orderID];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
    [self addControllers];
}
- (void)initUI {
    self.title = @"申请维权";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.boomScrollView];
    [self.view addSubview:self.handinApplicationBtn];
    [self.boomScrollView addSubview:self.powerOrderView];
    [self.boomScrollView addSubview:self.sellInfoView];
    [self.boomScrollView addSubview:self.dogDetailView];
    [self.boomScrollView addSubview:self.costView];
    [self.boomScrollView addSubview:self.sureApplyRefundView];
    [self.boomScrollView addSubview:self.photoView];
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)addControllers {
    
    self.edgesForExtendedLayout = 0;
    // 底部按钮
    [_handinApplicationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    [_boomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.handinApplicationBtn.top);
    }];
}

#pragma mark
#pragma mark - 懒加载
- (UIScrollView *)boomScrollView {
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] init];
        _boomScrollView.delegate = self;
        if (SCREEN_WIDTH>320) {// 根据手机适配
            _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-50);
        }else{
            _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+20);
        }
//              _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _boomScrollView.showsVerticalScrollIndicator = NO;
    }
    return _boomScrollView;
}
- (NSMutableArray *)photoArr {
    
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}
- (PowerOrderStateView *)powerOrderView {
    if (!_powerOrderView) {
        _powerOrderView = [[PowerOrderStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _powerOrderView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _powerOrderView;
}

- (SellinfoView *)sellInfoView {
    if (!_sellInfoView) {
        _sellInfoView = [[SellinfoView alloc] initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 44)];
        _sellInfoView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];

    }
    return _sellInfoView;
}

- (DogDetailCardView *)dogDetailView {
    if (!_dogDetailView) {
        _dogDetailView = [[DogDetailCardView alloc] initWithFrame:CGRectMake(0, 99, SCREEN_WIDTH, 110)];
        _dogDetailView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _dogDetailView;
}

- (CostView *)costView {
    if (!_costView) {
        _costView = [[CostView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 44)];
        _costView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _costView;
}

- (SureApplyRefundview *)sureApplyRefundView {
    if (!_sureApplyRefundView) {
        _sureApplyRefundView = [[SureApplyRefundview alloc] initWithFrame:CGRectMake(0, 264, SCREEN_WIDTH, 216)];
        _sureApplyRefundView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        __weak typeof(self) weakself = self;
        _sureApplyRefundView.refundBlock = ^(NSString * money) {
            weakself.refunMoney = money;
        };
        _sureApplyRefundView.openBlock = ^(BOOL isMoney) {
            _isMoney = isMoney;
        };
        _sureApplyRefundView.descBlock = ^(NSString *desc){
            weakself.descContent = desc;
        };
    }
    return _sureApplyRefundView;
}
- (AddUpdataImagesView *)photoView {
    if (!_photoView) {
        __block CGFloat W = 0;
        if (ImgCount <= kMaxImgCount) {
            W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / ImgCount;
        }else{
            W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
        }
        _photoView = [[AddUpdataImagesView alloc] initWithFrame:CGRectMake(0, 480, SCREEN_WIDTH, W + 20)];
        _photoView.maxCount = ImgCount;
        __weak typeof(self) weakSelf = self;
        __weak typeof(_photoView) weakPhoto = _photoView;
        _photoView.addBlock = ^(){
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            imagePickerVc.isSelectOriginalPhoto = YES;

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

- (UIButton *)handinApplicationBtn {
    if (!_handinApplicationBtn) {
        _handinApplicationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_handinApplicationBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_handinApplicationBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_handinApplicationBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        _handinApplicationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _handinApplicationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_handinApplicationBtn addTarget:self action:@selector(handinOPenAplication) forControlEvents:(UIControlEventTouchDown)];
    }
    return _handinApplicationBtn;
}
#pragma mark - 提交按钮点击方法
- (void)handinOPenAplication {
    
    if (self.isMoney) {
        NSString * refunMoneYStr = self.refunMoney;
        if (refunMoneYStr.length == 0 ) {
            [self showAlert:@"退款金额不能为空"];
        }else{
            
            if (self.descContent.length == 0) {
                [self showAlert:@"描述内容不能为空"];
            } else {
                if (self.photoView.dataArr.count == 0) {
                    [self showAlert:@"上传图片不能为空"];
                } else {
                    [self postAddProtectProwerRequest];
                }
            }
        }
    }else{ // 无需金钱
        if (self.descContent.length == 0) {
            [self showAlert:@"描述内容不能为空"];
        } else {
            if (self.photoView.dataArr.count == 0) {
                [self showAlert:@"上传图片不能为空"];
            } else {
                [self postAddProtectProwerRequest];
            }
        }
    }
}
- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.boomScrollView setContentOffset:CGPointMake(0, h)animated:YES];
//        [self.handinApplicationBtn remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.bottom).offset(-h - 50);
//            make.left.right.equalTo(self.view);
//            make.height.equalTo(50);
//        }];
    }];
}
-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.boomScrollView setContentOffset:CGPointMake(0, 0)animated:YES];
//        [self.handinApplicationBtn remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.bottom).offset(-50);
//            make.left.right.equalTo(self.view);
//            make.height.equalTo(50);
//        }];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
