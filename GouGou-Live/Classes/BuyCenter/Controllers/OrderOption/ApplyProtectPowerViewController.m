//
//  ApplyProtectPowerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.


#import "ApplyProtectPowerViewController.h"
#import "ProtecePowerPromptView.h"  // 维权提示框
#import "PowerOrderStateView.h" // 订单状态
#import "SellinfoView.h"  // 商家信息
#import "DogDetailCardView.h"    // 狗狗详情卡片
#import "CostView.h"            // 花费
#import "SureApplyRefundview.h"  // 是否申请退款
#import "UpLoadPictureView.h"    // 上传照片

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
@property (strong,nonatomic) UpLoadPictureView *upLoadPictureView;
/** 提交申请 */
@property (strong,nonatomic) UIButton * handinApplicationBtn;

@end

@implementation ApplyProtectPowerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
    
    [self setNavBarItem];
    
}

- (void)initUI {

    self.title = @"申请维权";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    [self.view addSubview:self.boomScrollView];
    [self.boomScrollView addSubview:self.powerOrderView];
    [self.boomScrollView addSubview:self.sellInfoView];
    [self.boomScrollView addSubview:self.dogDetailView];
    [self.boomScrollView addSubview:self.costView];
    [self.boomScrollView addSubview:self.sureApplyRefundView];
    [self.boomScrollView addSubview:self.upLoadPictureView];
    [self.boomScrollView addSubview:self.handinApplicationBtn];
}

- (UIScrollView *)boomScrollView {
    
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _boomScrollView.delegate = self;
        _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 750);
        _boomScrollView.bounces = NO;
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

- (UpLoadPictureView *)upLoadPictureView {

    if (!_upLoadPictureView) {
        _upLoadPictureView = [[UpLoadPictureView alloc] initWithFrame:CGRectMake(0, 480, SCREEN_WIDTH, 160)];
        _upLoadPictureView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _upLoadPictureView;
}

- (UIButton *)handinApplicationBtn {

    if (!_handinApplicationBtn) {
    
        _handinApplicationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _handinApplicationBtn.frame = CGRectMake(0, 640, SCREEN_WIDTH, 47);
        [_handinApplicationBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_handinApplicationBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_handinApplicationBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        _handinApplicationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _handinApplicationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_handinApplicationBtn addTarget:self action:@selector(handinAplication:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handinApplicationBtn;
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
