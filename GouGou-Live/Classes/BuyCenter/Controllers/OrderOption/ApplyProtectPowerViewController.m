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

@interface ApplyProtectPowerViewController ()<UIScrollViewDelegate>
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
/** 照片 */
//@property (strong,nonatomic) UpLoadPictureView *upLoadPictureView;

@property(nonatomic, strong) AddUpdataImagesView *photoView; /**< 图片 */

/** 提交申请 */
@property (strong,nonatomic) UIButton * handinApplicationBtn;
/** 接受view */
@property (strong,nonatomic) UIImageView *acceptImageView;

@end

@implementation ApplyProtectPowerViewController
#pragma mark
#pragma mark - 网络请求
- (void)postAddProtectProwerRequest {

    NSDictionary * dict = @{@"user_id":@(17),
                            @"order_id":@(12),
                            @"content":@"text",
                            @"has_money":@(1),
                            @"money":@(10),
                            @"has_photo":@(1),
                            };
    [self postRequestWithPath:API_Add_activist params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self postAddProtectProwerRequest];
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
    
}

- (void)addControllers {

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
//        _boomScrollView.bounces = NO;
        _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        _boomScrollView.showsVerticalScrollIndicator = NO;
    }
    return _boomScrollView;
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
        // 设置当前时间
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
//        _handinApplicationBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        [_handinApplicationBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_handinApplicationBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_handinApplicationBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        _handinApplicationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _handinApplicationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_handinApplicationBtn addTarget:self action:@selector(handinAplication:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handinApplicationBtn;
}
#pragma mark - 按钮点击方法
- (void)handinAplication:(UIButton *)button {


    self.sureApplyRefundView.refundBlock = ^(UITextField *textfiled) {
    
        BOOL flag = [NSString validateNumber:textfiled.text];
        if (flag) {
            
            NSInteger money = [textfiled.text integerValue];
            
            if (money < 0 ) {
                
                DLog(@"退款金额不能为0");
            }
            else if (money > [self.costView.moneyMessage integerValue]) {
                
                DLog(@"退款金额不能大于交易金额");
                
            } else {
            
                // 跳转
            }
        };
    };
    
}

//实现图片选择器代理

//参数：图片选择器  字典参数

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
 
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    self.acceptImageView.image = image;
 
    DLog(@"%@",image);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
