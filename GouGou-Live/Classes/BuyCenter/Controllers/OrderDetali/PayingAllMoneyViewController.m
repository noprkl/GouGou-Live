//
//  PayingAllMoneyViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//  订单详情（代付全款）

#import "PayingAllMoneyViewController.h"
#import "StateView.h"  // 订单状态
#import "ConsigneeView.h"  // (联系)收货人
#import "SellerDogCardView.h"   // 狗狗详情
#import "SellinfoView.h"   // 卖家信息
#import "GoodsPriceView.h"  // 商品价格
#import "PayingMoney.h"    // 付款状况
#import "OrderNumberView.h"  // 订单编号

#import "BottomButtonView.h"   // 按钮创建

#import "OrderDetailModel.h"

@interface PayingAllMoneyViewController ()<UIScrollViewDelegate>
/** 底部scrollView */
@property (strong,nonatomic) UIScrollView *boomScrollView;
/** 订单状态View */
@property (strong,nonatomic) StateView *orderStateView;
/** 联系人信息 */
@property (strong,nonatomic) ConsigneeView *consigneeViw;
/** 狗狗详情 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 认证商家 */
@property (strong,nonatomic) SellinfoView *sellInfoView;
/** 商品总价 */
@property (strong,nonatomic) GoodsPriceView *goodsPriceView;
/** 付款状态 */
@property (strong,nonatomic) PayingMoney *payMonyView;
/** 订单编号 */
@property (strong,nonatomic) OrderNumberView *orderNumberView;
/** 按钮 */
@property (strong,nonatomic) BottomButtonView *bottomButton;
/** 订单详情模型 */
@property (strong,nonatomic) OrderDetailModel *orderInfo;

@end

@implementation PayingAllMoneyViewController
#pragma mark - 网络请求
- (void)getAllMoneyRequest {
    
    NSDictionary * dict = @{@"id":@([_detailModel.ID intValue])};
    DLog(@"%@",dict);
    DLog(@"%@",[UserInfos sharedUser].ID);
    [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson[@"Message"]);
        DLog(@"%@",successJson[@"data"]);
        // 详情状态
        self.orderInfo = [OrderDetailModel mj_objectWithKeyValues:successJson[@"data"]];
        self.orderStateView.stateMessage = @"待付全款";
        self.orderStateView.timeMessage = [NSString stringFromDateString:self.orderInfo.createTime];
        // 联系人地址
        self.consigneeViw.buyUserName = self.orderInfo.buyUserName;
        self.consigneeViw.buyUserTel = self.orderInfo.buyUserTel;
        self.consigneeViw.recevieProvince = self.orderInfo.recevieProvince;
        self.consigneeViw.recevieCity = self.orderInfo.recevieCity;
        self.consigneeViw.recevieDistrict = self.orderInfo.recevieDistrict;
        self.consigneeViw.recevieAddress = self.orderInfo.recevieAddress;
        // 商家
        if (self.orderInfo.userImgUrl.length != 0) {
            NSString * imgString = [IMAGE_HOST stringByAppendingString:self.orderInfo.userImgUrl];
            [self.sellInfoView.buynessImg sd_setImageWithURL:[NSURL URLWithString:imgString] placeholderImage:[UIImage imageNamed:@"主播头像"]];
        }
        self.sellInfoView.buynessName = self.orderInfo.merchantName;
        self.sellInfoView.currentTime = [NSString stringFromDateString:self.orderInfo.createTime];
        // 狗狗详情
        if (self.orderInfo.pathSmall.length != 0) {
            NSString *urlString = [IMAGE_HOST stringByAppendingString:self.orderInfo.pathSmall];
            [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
        }
        self.dogCardView.dogNameLabel.text = self.orderInfo.name;
        self.dogCardView.dogAgeLabel.text = self.orderInfo.ageName;
        self.dogCardView.dogSizeLabel.text = self.orderInfo.sizeName;
        self.dogCardView.dogColorLabel.text = self.orderInfo.colorName;
        self.dogCardView.dogKindLabel.text = self.orderInfo.kindName;
        self.dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:self.orderInfo.priceOld];
        self.dogCardView.nowPriceLabel.text = self.orderInfo.price;
        // 商品总价
        self.goodsPriceView.totalsMoney = self.orderInfo.price;
        self.goodsPriceView.traficFee  = self.orderInfo.traficFee;
        self.goodsPriceView.cutMoney = [NSString stringWithFormat:@"%ld",[self.orderInfo.productDeposit integerValue] + [self.orderInfo.productBalance integerValue] - [self.orderInfo.traficRealFee integerValue] - [self.orderInfo.productRealDeposit integerValue] - [self.orderInfo.productRealBalance integerValue]];
        
        // 全款
        self.payMonyView.totalMoney = self.orderInfo.price;
        
        // 订单编号
        self.orderNumberView.buyUserId = self.orderInfo.ID;
        self.orderNumberView.createTimes = [NSString stringFromDateString:self.orderInfo.createTime];
//        self.orderNumberView.depositTimes = [NSString stringFromDateString:self.orderInfo.depositTime];
//        self.orderNumberView.balanceTimes = [NSString stringFromDateString:self.orderInfo.balanceTime];
//        self.orderNumberView.deliveryTimes = [NSString stringFromDateString:self.orderInfo.deliveryTime];

        
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getAllMoneyRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self addcontrollers];
    
    
    
//    CGFloat maxY = CGRectGetMaxY(rect);
    
    
//    DLog(@"%f",maxY);
}

- (void)initUI {
    
    [self.view addSubview:self.boomScrollView];
    
    [self.boomScrollView addSubview:self.orderStateView];
    [self.boomScrollView addSubview:self.consigneeViw];
    [self.boomScrollView addSubview:self.sellInfoView];
    [self.boomScrollView addSubview:self.dogCardView];
    [self.boomScrollView addSubview:self.goodsPriceView];
    [self.boomScrollView addSubview:self.payMonyView];
    [self.boomScrollView addSubview:self.orderNumberView];
    [self.boomScrollView addSubview:self.bottomButton];
 
}

- (void)addcontrollers {
    
    __weak typeof(self) weakself = self;
    
    [_orderStateView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.boomScrollView);
        make.height.equalTo(44);
        
    }];
    
    [_consigneeViw mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.orderStateView.bottom).offset(10);
        make.height.equalTo(89);
        
    }];
    
    [_sellInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.consigneeViw.bottom).offset(10);
        make.height.equalTo(44);
        
    }];
    
    [_dogCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.sellInfoView.bottom).offset(1);
        make.height.equalTo(120);
    }];
    
    [_goodsPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.dogCardView.bottom).offset(10);
        make.height.equalTo(147);
    }];
    
    [_payMonyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.goodsPriceView.bottom).offset(1);
        make.height.equalTo(44);
    }];
    
    [_orderNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.payMonyView.bottom).offset(10);
        make.height.equalTo(145);
        
    }];
    
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.orderNumberView.bottom).offset(1);
        make.height.equalTo(44);
    }];
}

#pragma mark
#pragma mark - 初始化
- (UIScrollView *)boomScrollView {
    
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _boomScrollView.delegate = self;
        _boomScrollView.showsVerticalScrollIndicator = NO;

        _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 780);
        _boomScrollView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        _boomScrollView.bounces = NO;
    }
    return _boomScrollView;
}
- (StateView *)orderStateView {
    
    if (!_orderStateView) {
        _orderStateView = [[StateView alloc] init];
        _orderStateView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _orderStateView.stateMessage = @"代付全款";
    }
    return _orderStateView;
}

- (ConsigneeView *)consigneeViw {
    
    if (!_consigneeViw) {
        _consigneeViw = [[ConsigneeView alloc] init];
        _consigneeViw.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _consigneeViw;
}


- (SellinfoView *)sellInfoView {
    
    if (!_sellInfoView) {
        _sellInfoView = [[SellinfoView alloc] init];
        _sellInfoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _sellInfoView;
}

- (SellerDogCardView *)dogCardView {
    
    if (!_dogCardView) {
        _dogCardView = [[SellerDogCardView alloc] init];
        _dogCardView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _dogCardView;
}

- (GoodsPriceView *)goodsPriceView {
    
    if (!_goodsPriceView) {
        _goodsPriceView = [[GoodsPriceView alloc] init];
        _goodsPriceView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _goodsPriceView;
}

- (PayingMoney *)payMonyView {
    
    if (!_payMonyView) {
        _payMonyView = [[PayingMoney alloc] init];
        _payMonyView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _payMonyView;
}

- (OrderNumberView *)orderNumberView {
    
    if (!_orderNumberView) {
        _orderNumberView = [[OrderNumberView alloc] init];
        _orderNumberView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _orderNumberView;
}

- (BottomButtonView *)bottomButton {

    if (!_bottomButton) {
        _bottomButton = [[BottomButtonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) title:@[@"取消订单",@"联系卖家",@"支付全款"]];
        _bottomButton.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        __weak typeof(self) weakself = self;
        
        _bottomButton.difFuncBlock = ^ (UIButton *button) {
            
            if ([button.titleLabel.text isEqual:@"取消订单"]) {
                
                [weakself clickCancleOrder:weakself.detailModel];
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:weakself.detailModel.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = weakself.detailModel.saleUserId;
                 viewController.chatID = weakself.detailModel.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [weakself.navigationController pushViewController:viewController animated:YES];
            } else if ([button.titleLabel.text isEqual:@"支付全款"]) {
                
                [weakself payMoneyWithOrderID:weakself.detailModel.ID payStyle:button.titleLabel.text];
            }
        };
    }
    return _bottomButton;
}


@end
