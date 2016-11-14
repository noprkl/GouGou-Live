//
//  PayingAllMoneyViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PayingAllMoneyViewController.h"
#import "StateView.h"
#import "ConsigneeView.h"
#import "DogCardView.h"
#import "SellinfoView.h"
#import "GoodsPriceView.h"
#import "PayingMoney.h"
#import "OrderNumberView.h"

@interface PayingAllMoneyViewController ()<UIScrollViewDelegate>
/** 底部scrollView */
@property (strong,nonatomic) UIScrollView *boomScrollView;
/** 订单状态View */
@property (strong,nonatomic) StateView *orderStateView;
/** 联系人信息 */
@property (strong,nonatomic) ConsigneeView *consigneeViw;
/** 狗狗详情 */
@property (strong,nonatomic) DogCardView *dogCardView;
/** 横线 */
@property (strong,nonatomic) UIView *lineView;
/** 认证商家 */
@property (strong,nonatomic) SellinfoView *sellInfoView;
/** 商品总价 */
@property (strong,nonatomic) GoodsPriceView *goodsPriceView;
/** 横线 */
@property (strong,nonatomic) UIView *lineView2;
/** 付款状态 */
@property (strong,nonatomic) PayingMoney *payMonyView;
/** 订单编号 */
@property (strong,nonatomic) OrderNumberView *orderNumberView;

@end

@implementation PayingAllMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
}

- (void)initUI {
    
    [self.view addSubview:self.boomScrollView];
    [self.boomScrollView addSubview:self.orderStateView];
    [self.boomScrollView addSubview:self.consigneeViw];
    [self.boomScrollView addSubview:self.sellInfoView];
    [self.boomScrollView addSubview:self.lineView];
    [self.boomScrollView addSubview:self.dogCardView];
    [self.boomScrollView addSubview:self.goodsPriceView];
    [self.boomScrollView addSubview:self.lineView2];
    [self.boomScrollView addSubview:self.payMonyView];
    [self.boomScrollView addSubview:self.orderNumberView];
}

#pragma mark
#pragma mark - 初始化
- (UIScrollView *)boomScrollView {
    
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _boomScrollView.delegate = self;
        _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 750);
        _boomScrollView.bounces = NO;
    }
    return _boomScrollView;
}
-(StateView *)orderStateView {
    
    if (!_orderStateView) {
        _orderStateView = [[StateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _orderStateView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _orderStateView;
}

- (ConsigneeView *)consigneeViw {
    
    if (!_consigneeViw) {
        _consigneeViw = [[ConsigneeView alloc] initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 89)];
        _consigneeViw.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _consigneeViw;
}


- (SellinfoView *)sellInfoView {
    
    if (!_sellInfoView) {
        _sellInfoView = [[SellinfoView alloc] initWithFrame:CGRectMake(0, 153, SCREEN_WIDTH, 44)];
        _sellInfoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _sellInfoView;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 197, SCREEN_WIDTH, 1)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView;
}

- (DogCardView *)dogCardView {
    
    if (!_dogCardView) {
        _dogCardView = [[DogCardView alloc] initWithFrame:CGRectMake(0, 198, SCREEN_WIDTH, 98)];
        _dogCardView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _dogCardView;
}

- (GoodsPriceView *)goodsPriceView {
    
    if (!_goodsPriceView) {
        _goodsPriceView = [[GoodsPriceView alloc] initWithFrame:CGRectMake(0, 306, SCREEN_WIDTH, 147)];
        _goodsPriceView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _goodsPriceView;
}
- (UIView *)lineView2 {
    
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 453, SCREEN_WIDTH, 1)];
        _lineView2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _lineView2;
}

- (PayingMoney *)payMonyView {
    
    if (!_payMonyView) {
        _payMonyView = [[PayingMoney alloc] initWithFrame:CGRectMake(0, 454, SCREEN_WIDTH, 44)];
        _payMonyView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _payMonyView;
}

- (OrderNumberView *)orderNumberView {
    
    if (!_orderNumberView) {
        _orderNumberView = [[OrderNumberView alloc] initWithFrame:CGRectMake(0, 509, SCREEN_WIDTH, 145)];
        _orderNumberView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _orderNumberView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
