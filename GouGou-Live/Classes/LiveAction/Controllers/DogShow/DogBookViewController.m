//
//  DogBookViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogBookViewController.h"
#import "SellerAndDogCardView.h"
#import "TransformStyleView.h"
#import "ChoseShopAdressViewController.h"
#import "ChosedAdressView.h" // 收货地址内容有值
#import "MyShopAdressModel.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "ChosePayStyleView.h"
#import "PayMoneyPrompt.h"
#import "PromptView.h"
#import "NSString+MD5Code.h"
#import "ForgetPayPsdViewController.h"
#import "BuySuccessVc.h"

@interface DogBookViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property(nonatomic, strong) UITableView *tablevView; /**< 表格 */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UILabel *bookMoneyLabel; /**< 应付定金 */

@property(nonatomic, strong) UIButton *payCount; /**< 结算按钮 */

@property(nonatomic, strong) UITableViewCell *bookMoneyCell4; /**< 应付定金cell */

@property(nonatomic, strong) UITableViewCell *lastMoneyCell5; /**< 剩余金额cell */

@property(nonatomic, strong) ChosedAdressView *chosedView; /**< 收货地址 */

@property(nonatomic, strong) UITableViewCell *transformCell3; /**< 支付运费方式cell */

@property(nonatomic, strong) UITextView *noteTextView; /**< 备注 */

@property(nonatomic, strong) UILabel *placeLabel; /**< 站位字符 */

@property(nonatomic, strong) MyShopAdressModel *defaultModel; /**< 默认地址 */

@property (nonatomic, assign) BOOL requestOrNotifi; /**< 请求 */

@end

@implementation DogBookViewController

#pragma mark - 网络请求

// 结算
- (void)clickPayBtnAction:(UIButton *)btn {
    // 请求个人资产
    [self postGetUserAsset];
    if (![UserInfos getUser]){
        [self showAlert:@"请登录"];
    }else {
        __block  ChosePayStyleView *choseStyle = [[ChosePayStyleView alloc] init];
        choseStyle.title = @"请选择付款额度方式";
        choseStyle.dataArr = @[@"支付全款", @"支付定金"];
        choseStyle.bottomBlock = ^(NSString *style){
            if ([style isEqualToString:@""]) {
                [self showAlert:@"请选择付款额度方式"];
            }else{
            
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"id":_model.ID,
                                   @"address_id":@(_defaultModel.ID)
                                   };
            DLog(@"%@", dict);

            [self postRequestWithPath:API_Order params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
                if ([successJson[@"message"] isEqualToString:@"已加入购物车"]) {
                    NSString *orderId = successJson[@"data"];
                    if ([style isEqualToString:@"支付全款"]) {
                        // 生成待支付全款订单
                        NSDictionary *typeDict = @{
                                                   @"user_id":[UserInfos sharedUser].ID,
                                                   @"order_id":orderId,
                                                   @"type":@(1)
                                                   };
                        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                            if ([successJson[@"message"] isEqualToString:@"支付全额"]) {
                                NSString *price = successJson[@"data"][@"product_price"];
                                NSString *orderid = successJson[@"data"][@"order_id"];
                                [self clickPayAllMoney:orderid price:price wallentPay:orderId];
                                choseStyle = nil;
                                [choseStyle dismiss];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }else if ([style isEqualToString:@"支付定金"]) {
                        // 生成待支付定金订单
                        NSDictionary *typeDict = @{
                                                   @"user_id":[UserInfos sharedUser].ID,
                                                   @"order_id":orderId ,
                                                   @"type":@(2)
                                                   };
                        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                            if ([successJson[@"message"] isEqualToString:@"支付订金"]) {
                                NSString *price = successJson[@"data"][@"product_deposit"];
                                NSString *orderid = successJson[@"data"][@"order_id"];
                                [self clickPayFontMoney:orderid productDeposit:price wallentPay:orderId];
                                choseStyle = nil;
                                [choseStyle dismiss];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            }
            };
        [choseStyle show];
    }
}
/** 定金支付 */
- (void)clickPayFontMoney:(NSString *)modelID productDeposit:(NSString *)productDeposit wallentPay:(NSString *)wallentId{
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    payMonery.payMoney = [NSString stringWithFormat:@"%.2lf", [productDeposit floatValue]];
    payMonery.dataArr = @[@"支付定金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *payAway){
        DLog(@"%@", payAway);
    };
    payMonery.payCellBlock = ^(NSString *payWay){
        [self payMoneyFroWay:payWay orderID:modelID money:productDeposit wallentPay:wallentId status:2];
    };
}
/** 全款支付 */
- (void)clickPayAllMoney:(NSString *)modelID price:(NSString *)price wallentPay:(NSString *)wallentId{
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    payMonery.payMoney = price;
    payMonery.dataArr = @[@"支付全款",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };
    payMonery.payCellBlock = ^(NSString *payWay){
        [self payMoneyFroWay:payWay orderID:modelID money:price wallentPay:wallentId status:5];
    };
}

#pragma mark
#pragma mark - 支付方式选择
- (void)payMoneyFroWay:(NSString *)payWay orderID:(NSString *)orderID money:(NSString *)money wallentPay:(NSString *)wallentId status:(int)status {
    if ([payWay isEqualToString:@"账户余额支付"]) {
        
        //        [self postGetWalletPayRequest];
        
        // 支付密码提示框
        PromptView * prompt = [[PromptView alloc] init];
        prompt.backgroundColor = [UIColor whiteColor];
        
        // 点击提示框确认按钮请求支付密码
        __weak typeof(prompt) weakPrompt = prompt;
        prompt.clickSureBtnBlock = ^(NSString *text){
            
            // 验证密码
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"pay_password":[NSString md5WithString:text]
                                   };
            [self postRequestWithPath:API_Validation_pwd params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                weakPrompt.noteStr = successJson[@"message"];
                if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                    [self walletPayWithOrderId:wallentId price:money payPwd:[NSString md5WithString:text] states:status];
                    [weakPrompt dismiss];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        [prompt show];
        prompt.forgetBlock = ^(){
            ForgetPayPsdViewController *forgetVc = [[ForgetPayPsdViewController alloc] init];
            forgetVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:forgetVc animated:YES];
        };
    }
    if ([payWay isEqualToString:@"支付宝支付"]) {
        [self aliPayWithOrderId:orderID totalFee:[money floatValue]];
    }
    if ([payWay isEqualToString:@"微信支付"]) {
        
        [self WeChatPayWithOrderID:orderID totalFee:[money floatValue]];
    }
}
/** 钱包支付 2定金 3全款 */
- (void)walletPayWithOrderId:(NSString *)orderID price:(NSString *)price payPwd:(NSString *)payPwd states:(int)state {

    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"order_id":orderID,
                           @"user_price":price,
                           @"user_pwd":payPwd,
                           @"status":@(state)
                           };
    DLog(@"%@", dict);
    [self postRequestWithPath:API_Wallet params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        /**
         5','余额不足'
         '0','支付失败'
         '1','支付成功'
         '4','请先设置支付密码'
         '3','密码错误'
         '2','参数不能为空'
         */
        if ([successJson[@"message"] isEqualToString:@"支付成功"]) {
            BuySuccessVc *paySuccessVc = [[BuySuccessVc alloc] init];
            paySuccessVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:paySuccessVc animated:YES];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
/** 微信支付 */
- (void)WeChatPayWithOrderID:(NSString *)orderID totalFee:(float)fee {
    // /gougou.itnuc.com/weixinpay/wxapi.php?order=wx12345678&total_fee=1&mark=testpya
    NSString *money = [NSString stringWithFormat:@"%.0lf", fee * 100];
    
    NSDictionary *dict = @{
                           @"order":orderID,
                           @"total_fee":money,
                           @"mark":@"爪行宠物直播"
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:@"weixinpay/wxapi.php" params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        PayReq * req = [[PayReq alloc] init];
        req.partnerId = [successJson objectForKey:@"partnerid"] != [NSNull null] ? successJson[@"partnerid"]:@"";
        req.prepayId = [successJson objectForKey:@"prepayid"] != [NSNull null] ?successJson[@"prepayid"]:@"";
        req.nonceStr = [successJson objectForKey:@"noncestr"] != [NSNull null] ?successJson[@"noncestr"]:@"";
        NSNumber *timeStamp = [successJson objectForKey:@"timestamp"] != [NSNull null] ?successJson[@"timestamp"]:@"";
        req.timeStamp = [timeStamp intValue];
        
        req.package = [successJson objectForKey:@"package"] != [NSNull null] ?successJson[@"package"]:@"";
        req.sign = [successJson objectForKey:@"sign"] != [NSNull null] ?successJson[@"sign"]:@"";
        req.openID = [successJson objectForKey:@"appid"] != [NSNull null] ?successJson[@"appid"]:@"";
        
        DLog(@"sign:%@, openID:%@, partnerId:%@, prepayId:%@, nonceStr:%@, timeStamp:%u, package:%@", req.sign, req.openID, req.partnerId, req.prepayId, req.nonceStr, req.timeStamp, req.package);
        
        BOOL flag = [WXApi sendReq:req];
        if (flag) {
            
            DLog(@"支付成功");
            BuySuccessVc *paySuccessVc = [[BuySuccessVc alloc] init];
            paySuccessVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:paySuccessVc animated:YES];
        }else{
            DLog(@"支付失败");
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
/** 支付宝支付 */
- (void)aliPayWithOrderId:(NSString *)orderID totalFee:(float)fee {
    //htp://gougou.itnuc.com/appalipay/signatures_url.php?id=111111111111&total_fee=1
    NSString *money = [NSString stringWithFormat:@"%.0lf", fee * 100];

    NSDictionary *dit = @{
                          @"id":orderID,
                          @"total_fee":money
                          };
    DLog(@"%@", dit);
    [self getRequestWithPath:@"appalipay/signatures_url.php" params:dit success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"msg"]];
        [self aliPayWithOrderString:successJson[@"data"]];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)aliPayWithOrderString:(NSString *)orderStr {
    if (orderStr != nil) {
        
        NSString *appScheme = @"ap2016112203105439";
        
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            DLog(@"reslut = %@",resultDic);
            //
            if ([resultDic[@"resultStatus"] intValue] == 9000) {
                BuySuccessVc *paySuccessVc = [[BuySuccessVc alloc] init];
                paySuccessVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:paySuccessVc animated:YES];
            }
        }];
    }
}

// 所有地址
- (void)postGetAdressRequest {
    if (self.defaultModel.userName.length == 0) {
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID integerValue])
                               };
        
        [self getRequestWithPath:API_Address params:dict success:^(id successJson) {
            [self showAlert:successJson[@"message"]];
            if (successJson[@"code"]) {
                // 数据解析
                NSArray *adressArr = [NSArray array];
                adressArr = [[MyShopAdressModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]] mutableCopy];
                for (MyShopAdressModel *model in adressArr) {
                    if (model.isDefault == 1) {
                        self.defaultModel = model;
                        self.chosedView.shopAdress = model;
                    }
                }
                // 刷新
                [self.tablevView reloadData];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
// 用户资产
- (void)postGetUserAsset {
    
    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           };
    
    [self getRequestWithPath:API_UserAsset params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSString *userAsset;
        if ([successJson[@"message"] isEqualToString:@"请求成功"]) {
            userAsset = successJson[@"data"][@"asset"];
        }else {
            userAsset = @"0.00";
        }
        [UserInfos sharedUser].userAsset = userAsset;
        [UserInfos setUser];

    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self setNavBarItem];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = YES;
    [self postGetAdressRequest];
    // 通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAcceptShopAdressFromAdress:) name:@"ShopAdress" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)getAcceptShopAdressFromAdress:(NSNotification *)adress {
    self.defaultModel = nil;
    MyShopAdressModel *defaultAdress = adress.userInfo[@"ShopAdress"];
    self.defaultModel = defaultAdress;
    DLog(@"%@", defaultAdress);
    self.chosedView.shopAdress = defaultAdress;
    DLog(@"%@",self.defaultModel.userAddress);
    [self.tablevView reloadData];
}
- (void)initUI {

    self.title = @"订购狗狗";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tablevView];
    [self.view addSubview:self.bookMoneyLabel];
    [self.view addSubview:self.payCount];
    
    [self makeConstraint];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    // 地址通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShopAdressFromAdress:) name:@"ShopAdress" object:nil];
}
- (void)makeConstraint {
    [self.payCount makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 50));
    }];
    [self.bookMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payCount);
        make.left.equalTo(self.view.left).offset(10);
    }];
    [self.tablevView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.payCount.top);
        make.left.right.equalTo(self.view);
    }];
}
- (void)setModel:(LiveListDogInfoModel *)model {
    _model = model;
}
#pragma mark
#pragma mark - TableView

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[
                     @"收货地址",@"狗狗信息", @"运费", @"订单总金额：", @"应付定金：", @"剩余金额：", @"备注"
                     ];
    }
    return _dataArr;
}
- (UITableView *)tablevView {
    if (!_tablevView) {
        _tablevView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tablevView.delegate = self;
        _tablevView.dataSource = self;
        _tablevView.bounces = NO;
        _tablevView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _tablevView;
}

#pragma mark
#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    switch (indexPath.row) {
        case 0:
        {
            if (self.defaultModel.userTel.length > 0) { // 添加地址
                ChosedAdressView *chosedView = [[ChosedAdressView alloc] init];
                chosedView.shopAdress = self.defaultModel;
                chosedView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 85);
                [cell.contentView addSubview:chosedView];
               
                self.chosedView = chosedView;
            }else{
                cell.textLabel.text = self.dataArr[indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
            break;

        case 1:
        {
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerAndDogCardView *sellerAnddog = [[SellerAndDogCardView alloc] init];
            if (_liverIcon.length != 0) {
                NSString *urlString = [IMAGE_HOST stringByAppendingString:_liverIcon];
                [sellerAnddog.sellerIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
            }
            sellerAnddog.sellerName.text = _liverName;
            sellerAnddog.dateLabel.text = [NSString stringFromDateString:self.model.createTime];
            if (self.model.pathSmall != NULL) {
                NSString *urlString = [IMAGE_HOST stringByAppendingString:self.model.pathSmall];
                [sellerAnddog.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
            }
            sellerAnddog.dogNameLabel.text = self.model.name;
            sellerAnddog.dogKindLabel.text = self.model.kindname;
            sellerAnddog.dogAgeLabel.text = self.model.agename;
            sellerAnddog.dogSizeLabel.text = self.model.sizename;
            sellerAnddog.dogColorLabel.text = self.model.colorname;
            sellerAnddog.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:[NSString stringWithFormat:@"￥%@", self.model.price]];
            sellerAnddog.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.model.price];
            sellerAnddog.backgroundColor = [UIColor whiteColor];
            [cell addSubview:sellerAnddog];

            [sellerAnddog makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(UIEdgeInsetsMake(10, 0, 10, 0));
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
            break;
        case 2:
        {
            cell.textLabel.text = self.dataArr[2];
            cell.detailTextLabel.text = self.model.traficMoney;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case 3:
        {
            cell.textLabel.attributedText = [self getChoseAttributeString1:self.dataArr[indexPath.row] string2:self.model.price];
            cell.detailTextLabel.text = @"直接下单";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
            [btn sizeToFit];
            [btn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(choseBuyDogType:) forControlEvents:(UIControlEventTouchDown)];
            cell.accessoryView = btn;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            self.transformCell3 = cell;
            
        }
            break;
        case 4:
        {
        NSString *despot = [NSString stringWithFormat:@"%0.2lf", ([self.model.price floatValue] / 10)];
            cell.textLabel.attributedText = [self getAttributeWithString1:self.dataArr[indexPath.row] string2:despot];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            self.bookMoneyCell4 = cell;
        }
            break;
        case 5:
        {
            NSString *final = [NSString stringWithFormat:@"%0.2lf", ([self.model.price floatValue] * 0.9)];
            cell.textLabel.attributedText = [self getAttributeWithString1:self.dataArr[indexPath.row] string2:final];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            self.lastMoneyCell5 = cell;
        }
            break;
        case 6:
        {
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            
            [cell addSubview:self.noteTextView];
            [self.noteTextView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
            }];
            
        }
            break;

        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 1) {
//        return 170;
//    }else if (indexPath.row == 6){
//        return 163;
//    }
    if (indexPath.row == 0) {
        if (self.defaultModel.userTel.length != 0) {
            return 85;
        }else{
            return 44;
        }
    }else if (indexPath.row == 1){
        return 170;
    }else if (indexPath.row == 6){
        return 122;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        ChoseShopAdressViewController *choseVC = [[ChoseShopAdressViewController alloc] init];
        choseVC.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:choseVC animated:YES];
    }
}
- (void)choseBuyDogType:(UIButton *)btn {
    TransformStyleView *transView = [[TransformStyleView alloc] init];
    transView.detailPlist = @[@"价格 ¥80", @"按实结算"];
    transView.transformCellBlock = ^(NSString *type){
        DLog(@"%@", type);
        
        btn.selected = YES;
        
#pragma mark 改变字体
        NSString *final = [NSString stringWithFormat:@"%0.2lf", ([self.model.price floatValue] * 0.9)];
        self.lastMoneyCell5.textLabel.attributedText = [self getChoseAttributeString1:self.dataArr[5] string2:final];
        
        NSString *despot = [NSString stringWithFormat:@"%0.2lf", ([self.model.price floatValue] / 10)];
        self.bookMoneyCell4.textLabel.attributedText = [self getChoseAttributeString1:self.dataArr[4] string2:despot];
    };
    [transView show];
}
#pragma mark
#pragma mark - 懒加载&Action

- (UILabel *)bookMoneyLabel {
    if (!_bookMoneyLabel) {
        _bookMoneyLabel = [[UILabel alloc] init];
        NSString *final = [NSString stringWithFormat:@"%0.2lf", ([self.model.price floatValue] * 0.1)];
        _bookMoneyLabel.attributedText = [self getAttributeWithString1:@"应付定金：" string2:final];
    }
    return _bookMoneyLabel;
}

- (UIButton *)payCount {
    if (!_payCount) {
        _payCount = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_payCount setTitle:@"结算" forState:(UIControlStateNormal)];
        [_payCount setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        [_payCount setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_payCount addTarget:self action:@selector(clickPayBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _payCount;
}

- (NSAttributedString *)getAttributeWithString1:(NSString *)text1 string2:(NSString *)text2 {
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text1 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:text2 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffa11a"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    [attribute appendAttributedString:attribute2];
    return attribute;
}
- (NSAttributedString *)getChoseAttributeString1:(NSString *)text1 string2:(NSString *)text2 {
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text1 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:text2 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];

    [attribute appendAttributedString:attribute2];
    return attribute;
}

#pragma mark
#pragma mark - 监听键盘方法
- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height - 50;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tablevView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top).offset(-h);
            make.bottom.equalTo(self.payCount.top).offset(h);
            make.left.right.equalTo(self.view);

        }];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.tablevView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.bottom.equalTo(self.payCount.top);
            make.left.right.equalTo(self.view);

        }];
    }];
}


- (UITextView *)noteTextView {
    if (!_noteTextView) {
        _noteTextView  = [[UITextView alloc] init];
        _noteTextView.delegate = self;
        _noteTextView.backgroundColor = [UIColor whiteColor];
        _noteTextView.textColor = [UIColor colorWithHexString:@"#000000"];
        _noteTextView.font = [UIFont systemFontOfSize:14];
        _noteTextView.layer.cornerRadius = 5;
        _noteTextView.layer.masksToBounds = YES;
        _noteTextView.returnKeyType = UIReturnKeyDefault;
        
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = @"备注";
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:14];
        placeLabel.frame = CGRectMake(5, 5, 30, 15);
        [_noteTextView addSubview:placeLabel];
        self.placeLabel = placeLabel;
    }
    return _noteTextView;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.placeLabel.text = @"备注";
    }else{
        self.placeLabel.text = @"";
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShopAdress" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
